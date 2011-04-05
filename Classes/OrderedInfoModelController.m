//
//  OrderedInfoModelController.m
//  padOrder
//
//  Created by Macric Cho on 2010/10/7.
//  Copyright 2010 Macricho. All rights reserved.
//

#import "OrderedInfoModelController.h"
#import "EntityOrderedInfo.h"
#import "EntityOrderedDish.h"
#import "EntityDish.h"
#import "EntityStatus.h"
#import "StatusModelController.h"


@implementation OrderedInfoModelController

#pragma mark -
#pragma mark Initialization

- (id) init{
    if(self = [super init]){
        self.entity = [NSEntityDescription entityForName:@"Ordered_Info" inManagedObjectContext:managedObjectContext];
    }
    return self;
}

#pragma mark -
#pragma mark Self-Mothod

- (NSArray *) fetchRelativeOrderedDishes:(EntityOrderedInfo *)infoObject{
    NSEntityDescription *entityDesctiption = [NSEntityDescription entityForName:@"Ordered_Dish" inManagedObjectContext:self.managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];//[self.orderedDishModelController createSimpleFetchRequest];
    [request setEntity:entityDesctiption];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"Dish = %@ AND  Ordered_Info=%@ And Status.Status_No = 1",[infoObject.Dish objectID], [infoObject objectID]];
    [request setPredicate:predicate];
    return [managedObjectContext executeFetchRequest:request error:nil];
}

- (void) deleteInfoAndRelativeOrderedDish:(EntityOrderedInfo *)infoObject{
    for (EntityOrderedDish *ordered in [self fetchRelativeOrderedDishes:infoObject]) {
        //一個info代表一到菜要顯示的數量
        [managedObjectContext deleteObject:ordered];
    }
    [managedObjectContext deleteObject:infoObject];//因為現在只是刪除單項，所以可以直接刪掉，如果是結帳，那就要留下來，所以清除類型的，都可以不用留Status_No為1的info
    [managedObjectContext save:nil];   
}

- (NSFetchedResultsController *) fetchedResultsControllerGroupByStatus{
    //Delete Cache avoid Data Error
    [NSFetchedResultsController deleteCacheWithName:@"StatusOrderedInfo"];
    
    //Create a fetch request
    NSFetchRequest  *fetchRequest = [self createSimpleFetchRequest];
    //Create somethin for request 
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"Will_Show=YES"];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"Status.Status_No" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    
    [fetchRequest setPredicate:predicate];
    [fetchRequest setSortDescriptors:sortDescriptors];
    [fetchRequest setResultType:NSManagedObjectResultType];
    
    NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc] 
                                                    initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext 
                                                    sectionNameKeyPath:@"Status.Status_No" cacheName:@"StatusOrderedInfo"];
    [self refreshFetchedResultsController:fetchedResultsController];
    [fetchRequest release];
    return fetchedResultsController;
}

- (EntityOrderedInfo *)orderedInfoFetchedWithDish:(EntityDish *)dish withStatus:(NSInteger)status{
    StatusModelController *statusModelController = [[StatusModelController alloc] init];
    
    
    NSFetchRequest  *fetchRequest = [self createSimpleFetchRequest];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"Dish.Dish_No = %@ and Status = %@",[dish Dish_No],[[statusModelController statusObjectWithNo:status] objectID]];
    //NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"Status" ascending:YES];
    //NSArray *sortDescriptors = [[NSArray alloc] initWithObject:nil];
    [fetchRequest setPredicate:predicate];
    NSArray *array = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    return [array objectAtIndex:0];
}

- (EntityOrderedInfo *)orderedInfoFetchedWithDish:(EntityDish *)dish{
    NSFetchRequest  *fetchRequest = [self createSimpleFetchRequest];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"Dish.Dish_No = %@",[dish Dish_No]];
    //NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"Status" ascending:YES];
    //NSArray *sortDescriptors = [[NSArray alloc] initWithObject:nil];
    [fetchRequest setPredicate:predicate];
    NSArray *array = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    return [array objectAtIndex:0];
}


- (NSFetchedResultsController *) fetchedDishSelectStatus:(NSInteger)status{
    //Delete Cache avoid Data Error
    [NSFetchedResultsController deleteCacheWithName:@"SelectStatus"];
    //Create a fetch request
    NSFetchRequest  *fetchRequest = [self createSimpleFetchRequest];
    NSError *error = nil;
    //Create somethin for request 
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"Status.Status_No = %d",status];
    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"willShow=YES"];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"Status.Status_No" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    
    [fetchRequest setPredicate:predicate];
    [fetchRequest setSortDescriptors:sortDescriptors];
    [fetchRequest setRelationshipKeyPathsForPrefetching:[NSArray arrayWithObject:@"Dish"]];
    [fetchRequest setResultType:NSManagedObjectResultType];
    
    NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext                                             sectionNameKeyPath:nil cacheName:@"SelectStatus"];
    [fetchedResultsController performFetch:&error];
    [fetchRequest release];
    return fetchedResultsController;
}

- (NSFetchedResultsController *) fetchedDishSelectStatusFrom:(NSInteger)from to:(NSInteger)to{

        //Delete Cache avoid Data Error
    [NSFetchedResultsController deleteCacheWithName:@"SelectStatus"];
        //Create a fetch request
    NSFetchRequest  *fetchRequest = [self createSimpleFetchRequest];
    NSError *error = nil;
        //Create somethin for request 
    
    NSNumber *fromNumber = [NSNumber numberWithInteger:from];
    NSNumber *toNumber = [NSNumber numberWithInteger:to];
    
    NSArray *betweenArray = [NSArray arrayWithObjects:fromNumber,toNumber, nil];
    
    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"Status.Status_No >= %d or Status.Status_No <= %d and Will_Show=YES",from,to];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"Will_Show=YES and Status.Status_No >= %@ and Status.Status_No <= %@",fromNumber,toNumber];

    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"Will_Show=YES and Status.Status_No between %@",betweenArray];
        //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"willShow=YES"];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"Status.Status_No" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    
    [fetchRequest setPredicate:predicate];
    [fetchRequest setSortDescriptors:sortDescriptors];
    //[fetchRequest setRelationshipKeyPathsForPrefetching:[NSArray arrayWithObject:@"Dish"]];
    [fetchRequest setResultType:NSManagedObjectResultType];
    
    NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext                                             sectionNameKeyPath:nil cacheName:@"SelectStatus"];
    [fetchedResultsController performFetch:&error];
    [fetchRequest release];
    return fetchedResultsController;
}


- (void) deleteAllFetchedResultWithController:(NSFetchedResultsController *)fetchedResultController{
    /*for (EntityOrderedInfo *object in [fetchedResultController fetchedObjects]) {
        [self.managedObjectContext deleteObject:object.Order];
    }*/
    [super deleteAllFetchedResultWithController:fetchedResultController];
}

- (void) insertBeOrderedDish:(EntityDish *) dish{
    StatusModelController *statusModelController = [[StatusModelController alloc] init];
    EntityStatus *statusObj = [statusModelController statusObjectWithNo:0];
    //NSLog(@"stat:%@",statusObj);
    NSEntityDescription *orderedEntity = [NSEntityDescription entityForName:@"Ordered_Dish" inManagedObjectContext:managedObjectContext];
    
    NSArray *resultArray = [self entity:@"Ordered_Dish" withPredicate:nil sortBy:@"Order_No" ascending:NO];
    
    NSNumber *nextOrderNo = [NSNumber numberWithInt:0];
    if ([resultArray count]>0) {
        nextOrderNo = [NSNumber numberWithInt:[((EntityOrderedDish *)[resultArray objectAtIndex:0]).Order_No intValue]+1];
    }
    
    EntityOrderedDish *newOrderedDish = [[EntityOrderedDish alloc] initWithEntity:orderedEntity insertIntoManagedObjectContext:managedObjectContext];
    newOrderedDish.Order_No = nextOrderNo;
    newOrderedDish.Dish = dish;
    
        //stack的問題？
    NSMutableArray *items = [self mutableArrayWithDish:dish];
    
    //NSLog(@"items:%@",items);
    
    EntityOrderedInfo *infoEntity = nil;

    if([items count] > 0) infoEntity = (EntityOrderedInfo *)[items lastObject];
    NSUInteger count;
    NSUInteger totalPrice = [dish.Dish_Price integerValue];
    
    //如果沒有回傳 新增一個Info
    if(infoEntity == nil){
        infoEntity = [[EntityOrderedInfo alloc] initWithEntity:entity insertIntoManagedObjectContext:managedObjectContext];
        infoEntity.Dish = dish;
        //infoEntity.Order = newOrderedDish;
        count = 0;
    }
    else {
        count = [infoEntity.Count integerValue];
    }

    newOrderedDish.Ordered_Info = infoEntity;
    count = count + 1;
    totalPrice  = totalPrice * count;
    
    infoEntity.Count = [NSNumber numberWithInt:count];
    infoEntity.Price = [NSNumber numberWithInt:totalPrice];
    infoEntity.Status = statusObj;
    
    //[StatusModelController ]
    
    //infoEntity.Status = 
    // Save the context.  
    [self saveToContext];
}

- (BOOL)isExistWithDish:(EntityDish *)dish{
    BOOL isExist = NO;
    if ([[self mutableArrayWithDish:dish] count] > 0) {
        isExist = YES;
    }
    return isExist;
}



- (Stack *) mutableArrayWithDish:(EntityDish *)dish{
    //NSLog(@"DISH:%@",dish);
    EntityOrderedInfo *selectedDish = nil;
    //Create a fetch request
    NSFetchRequest  *fetchRequest = [self createSimpleFetchRequest];
    //Create somethin for request 
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"Dish = %@ AND Status.Status_No = 0",[dish objectID]];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"Dish.Dish_No" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    NSError *error = nil;
    [fetchRequest setPredicate:predicate];
    [fetchRequest setSortDescriptors:sortDescriptors];
    [fetchRequest setResultType:NSManagedObjectResultType];
    
    Stack *items = [[managedObjectContext executeFetchRequest:fetchRequest error:&error] mutableCopy];

    /*if([items count] != 0){
        selectedDish = (EntityOrderedInfo *)[items pop];
    }*/
    //[items release];
    [fetchRequest release];
    return items;
}

- (BOOL) isExistOrderingList{
    return  [[[self fetchedDishSelectStatus:0] fetchedObjects] count] > 0;
}


- (void) updateSubmitDateTime:(NSDate *)date withStatus:(NSInteger)status{
    [self updateDate:@selector(setSubmit_Time:) withStatus:status date:date];
}

- (void) updateCookingDateTime:(NSDate *)date withStatus:(NSInteger)status{
    [self updateDate:@selector(setCook_Time:) withStatus:status date:date];
}

- (void) updateRepentDateTime:(NSDate *)date withStatus:(NSInteger)status{
    [self updateDate:@selector(setRepent_Time:) withStatus:status date:date];
}


- (void) updateDate:(SEL)seletor withStatus:(NSInteger)status date:(NSDate *)date{
    NSFetchedResultsController *fetchedController = [self fetchedDishSelectStatus:status];
        ////(@"array:%@",[fetchedController fetchedObjects]);
    for (EntityOrderedInfo *infoObject in [fetchedController fetchedObjects]) {
        for (EntityOrderedDish *dishObject in [self fetchRelativeOrderedDishes:infoObject]) {
            //[dishObject setValue:date forKeyPath:keyPath];
            ////(@"date:%@",date);
            [dishObject performSelector:seletor withObject:date];
            //dishObject.Submit_Time = [NSDate date];
        }
    }
    [self saveToContext];
    [fetchedController release];
}


- (void) changeOrderedDishFromStatus:(NSInteger) fromStatus toStatus:(NSInteger)toStatus{
    /*[[fetchedResultsController objectAtIndexPath:indexPath] setValue:status_no forKey:@"Status_No"];
     [self reloadTableViewSelectToIndexPath:indexPath];*/
    StatusModelController *statusModel = [[StatusModelController alloc] init];
    
    
    //NSNumber *toStatusNumber = [NSNumber numberWithInt:toStatus];
    NSFetchedResultsController *fetchedController = [self fetchedDishSelectStatus:fromStatus];
    for (EntityOrderedInfo *infoObject in [fetchedController fetchedObjects]) {
        infoObject.Status = (EntityStatus *)[statusModel statusObjectWithNo:toStatus];
        for (EntityOrderedDish *dishObject in [self fetchRelativeOrderedDishes:infoObject]) {
            dishObject.Status = (EntityStatus *)[statusModel statusObjectWithNo:toStatus];
        }
    }
    [self saveToContext];
    [fetchedController release];
}



@end
