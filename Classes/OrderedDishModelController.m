//
//  OrderedDishModelController.m
//  padOrder
//
//  Created by Macric Cho on 2010/10/3.
//  Copyright 2010 Macricho. All rights reserved.
//

#import "OrderedDishModelController.h"
#import "EntityDish.h"
#import "EntityOrderedDish.h"
#import "EntityStatus.h"


@implementation OrderedDishModelController

#pragma mark -
#pragma mark Initialization

- (id) init{
    if(self = [super init]){
        self.entity = [NSEntityDescription entityForName:@"Ordered_Dish" inManagedObjectContext:managedObjectContext];
    }
    return self;
}


#pragma mark -
#pragma mark Self-Method

- (NSFetchedResultsController *) allEntityFetchedResultsController{
    //Delete Cache avoid Data Error
    [NSFetchedResultsController deleteCacheWithName:@"OrderedDishes"];
    
    //Create a fetch request
    NSFetchRequest  *fetchRequest = [self createSimpleFetchRequest];
    //Create somethin for request 
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"willShow=YES"];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"Ordered_Dish" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    
    [fetchRequest setPredicate:predicate];
    [fetchRequest setSortDescriptors:sortDescriptors];
    [fetchRequest setResultType:NSManagedObjectResultType];
    
    NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext 
              sectionNameKeyPath:nil cacheName:@"OrderedDishes"];
    [fetchRequest release];
    return fetchedResultsController;
}


- (NSMutableArray *) mutableArrayWithDish:(EntityDish *)dish{
    //EntityOrderedDish *orderDish = nil;
    //Create a fetch request
    NSFetchRequest  *fetchRequest = [self createSimpleFetchRequest];
    //Create somethin for request 
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"Ordered_Dish.Dish_No=%@ AND Status.Status_No=0",[dish Dish_No]];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"Dish_Index" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    NSError *error = nil;
    [fetchRequest setPredicate:predicate];
    [fetchRequest setSortDescriptors:sortDescriptors];
    [fetchRequest setResultType:NSManagedObjectResultType];
    
    NSMutableArray *items = [[managedObjectContext executeFetchRequest:fetchRequest error:&error] mutableCopy];
    
    /*if([items count] != 0){
        orderDish = (EntityOrderedDish *)[items pop];
    }*/
    //[items release];
    [fetchRequest release];
    return items;
}



- (NSFetchedResultsController *) fetchedResultsControllerGroupByStatus{
    //Delete Cache avoid Data Error
    [NSFetchedResultsController deleteCacheWithName:@"StatusOrderedDishes"];
    
    //Create a fetch request
    NSFetchRequest  *fetchRequest = [self createSimpleFetchRequest];
    //Create somethin for request 
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"willShow=YES"];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"Status.Status_No" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    
    [fetchRequest setPredicate:predicate];
    [fetchRequest setSortDescriptors:sortDescriptors];
    [fetchRequest setResultType:NSManagedObjectResultType];
    
    NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext 
              sectionNameKeyPath:@"Status_No" cacheName:@"StatusOrderedDishes"];
    [fetchRequest release];
    return fetchedResultsController;
}


- (void) insertBeOrderedDish:(EntityDish *) dish{
    EntityOrderedDish *newOrderedDish = [[EntityOrderedDish alloc] initWithEntity:entity insertIntoManagedObjectContext:managedObjectContext];
    NSMutableArray *items = [self mutableArrayWithDish:dish];
    EntityOrderedDish *orderedDish;
    //注意！舊的修改是否顯示！並把index加1傳給新的
    if(items != nil){
        EntityOrderedDish *checkOrderedDish = (EntityOrderedDish *)[items lastObject];
        for (orderedDish in items) {
            //(@"Dish:%@,willShow:%d,Status:%@",orderedDish.Dish_Index,[orderedDish.willShow boolValue],orderedDish.Status_No);
            [orderedDish setValue:[NSNumber numberWithBool:YES] forKeyPath:@"willShow"];
        }
        [checkOrderedDish setValue:[NSNumber numberWithBool:NO] forKey:@"willShow"];
        if([checkOrderedDish.Status.Status_No isEqual:[NSNumber numberWithInt:0]]) [checkOrderedDish setValue:[NSNumber numberWithBool:YES] forKey:@"willShow"];
        
        NSNumber *number  = checkOrderedDish.Dish_Index;
        int index = [number integerValue];
        index=index+1;
        newOrderedDish.Dish_Index = [NSNumber numberWithInt:index];
    }
    
    
    newOrderedDish.Dish = dish;

    // Save the context.
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         */
        //(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
}


@end
