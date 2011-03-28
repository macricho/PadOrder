//
//  DishDataModelController.m
//  padOrder
//
//  Created by Macric Cho on 2010/10/3.
//  Copyright 2010 Macricho. All rights reserved.
//

#import "DishDataModelController.h"
#import "EntityDish.h"
#import "EntityOrderKind.h"
@implementation DishDataModelController

- (id) init{
    if(self = [super init]){
        self.entity = [NSEntityDescription entityForName:@"Dishes" inManagedObjectContext:managedObjectContext];
    }
    return self;
}

- (NSFetchedResultsController *) fetchedResultsControllerGroupBySetWhereKindIs:(EntityOrderKind *)kind{
    //Delete Cache to avoid Data Error
    [NSFetchedResultsController deleteCacheWithName:@"DishSet"];
    //Create a fetch request
    NSFetchRequest  *fetchRequest = [self createSimpleFetchRequest];
    //Create somethin for request 
    NSPredicate *predicate = nil;
    
    predicate= [NSPredicate predicateWithFormat:@"Kind=%@",[kind objectID]];

    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"DishSet.Set_Name" ascending:YES];

    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];//[[NSArray alloc] initWithObjects:sortDescriptor, nil];

    [fetchRequest setPredicate:predicate];
    [fetchRequest setSortDescriptors:sortDescriptors];

    [fetchRequest setResultType:NSManagedObjectResultType];

    NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc] 
                                                            initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext 
                                                            sectionNameKeyPath:@"DishSet.Set_Name" cacheName:@"DishSet"];
    
    [fetchRequest release];

    [predicate release];

    return fetchedResultsController;
    
}

- (NSSet *) allDishes{
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"Dish_No" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    NSError *error = nil;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    [fetchRequest setSortDescriptors:sortDescriptors];
    [fetchRequest setFetchBatchSize:20];
    
    return [NSSet setWithArray:[managedObjectContext executeFetchRequest:fetchRequest error:&error]];
}
/*
- (NSFetchedResultsController *) fetchedResultsControllerGroupByStatus{
    NSFetchRequest  *fetchRequest = [self createSimpleFetchRequest];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"Status_No" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    [NSFetchedResultsController deleteCacheWithName:@"OrderedDishes"];
    NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext 
              sectionNameKeyPath:@"Status_No" cacheName:@"OrderedDishes"];
    
    [fetchRequest release];
    return fetchedResultsController;
}
*/
- (void) dealloc{
    [super dealloc];
}

@end
