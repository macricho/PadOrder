//
//  OrderedInfoModelController.h
//  padOrder
//
//  Created by Macric Cho on 2010/10/7.
//  Copyright 2010 Macricho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "padOrderModelObject.h"
#import "Stack.h"

@class EntityOrderedInfo;
@class EntityOrderedDish;
@class EntityDish;
@interface OrderedInfoModelController : padOrderModelObject {
    
}
- (NSFetchedResultsController *) fetchedDishSelectStatusFrom:(NSInteger)from to:(NSInteger)to;
- (NSFetchedResultsController *) fetchedResultsControllerGroupByStatus;
- (NSFetchedResultsController *) fetchedDishSelectStatus:(NSInteger)status;
- (EntityOrderedInfo *)orderedInfoFetchedWithDish:(EntityDish *)dish;
- (EntityOrderedInfo *)orderedInfoFetchedWithDish:(EntityDish *)dish withStatus:(NSInteger)status;
- (Stack *) mutableArrayWithDish:(EntityDish *)dish;
- (BOOL) isExistWithDish:(EntityDish *)dish;
- (void) insertBeOrderedDish: (EntityDish *) dish;
- (void) deleteAllFetchedResultWithController:(NSFetchedResultsController *)fetchedResultController;
- (void) deleteInfoAndRelativeOrderedDish:(EntityOrderedInfo *)infoObject;
- (NSArray *) fetchRelativeOrderedDishes:(EntityOrderedInfo *)infoObject;
- (BOOL) isExistOrderingList;
- (void) updateSubmitDateTime:(NSDate *)date withStatus:(NSInteger)status;
- (void) updateCookingDateTime:(NSDate *)date withStatus:(NSInteger)status;
- (void) updateRepentDateTime:(NSDate *)date withStatus:(NSInteger)status;
- (void) updateDate:(SEL)seletor withStatus:(NSInteger)status date:(NSDate *)date;
- (void) changeOrderedDishFromStatus:(NSInteger) fromNo toStatus:(NSInteger)toNo;
@end
