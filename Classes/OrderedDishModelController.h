//
//  OrderedDishModelController.h
//  padOrder
//
//  Created by Macric Cho on 2010/10/3.
//  Copyright 2010 Macricho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "padOrderModelObject.h"
#import "Stack.h"

@class EntityDish;
@class EntityOrderedDish;

@interface OrderedDishModelController : padOrderModelObject {
    
}


//- (NSFetchedResultsController *) fetchedResultsController; 新增幾個Method 讓他可以產生特定需求
//例如：產生以Status_No分出Section的FetchedResultsController;
- (NSFetchedResultsController *) fetchedResultsControllerGroupByStatus;
- (NSFetchedResultsController *) allEntityFetchedResultsController;
- (void) refreshFetchedResultsController:(NSFetchedResultsController *)fetchResultsController;
- (NSMutableArray *) mutableArrayWithDish:(EntityDish *)dish;
- (void) insertBeOrderedDish: (EntityDish *) dish;

@end

