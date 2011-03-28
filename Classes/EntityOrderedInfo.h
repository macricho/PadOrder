//
//  EntityOrderedInfo.h
//  padOrder
//
//  Created by Macric Cho on 2010/10/7.
//  Copyright 2010 Macricho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EntityRefer.h"

@class EntityDish;
@class EntityOrderedDish;
@class EntityStatus;
@interface EntityOrderedInfo : EntityRefer {

}

@property (nonatomic, retain) EntityDish *Dish;
@property (nonatomic, retain) EntityOrderedDish *Order;
@property (nonatomic, retain) EntityStatus *Status;
@property (nonatomic, retain) NSNumber *Count;
@property (nonatomic, retain) NSNumber *Price;
@property (nonatomic, retain) NSNumber *Will_Show;


@end
