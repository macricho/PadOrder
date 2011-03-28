//
//  DishDataModelController.h
//  padOrder
//
//  Created by Macric Cho on 2010/10/3.
//  Copyright 2010 Macricho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "padOrderModelObject.h"

@class EntityOrderKind;
@class EntityDish;
@interface DishDataModelController : padOrderModelObject{
    
}

- (NSSet *) allDishes;
- (NSFetchedResultsController *) fetchedResultsControllerGroupBySetWhereKindIs:(EntityOrderKind *)kind;

@end
