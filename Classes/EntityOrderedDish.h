//
//  OrderedList.h
//  padOrder
//
//  Created by Macric Cho on 2010/9/27.
//  Copyright 2010 Macricho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EntityRefer.h"

@class EntityDish;
@class EntityOrderedInfo;
@class EntityStatus;
@interface EntityOrderedDish : EntityRefer {

}

@property (nonatomic, retain) EntityDish *Dish;
@property (nonatomic, retain) NSDate *Cook_Time;
@property (nonatomic, retain) NSNumber *Order_No;
@property (nonatomic, retain) NSDate *Repent_Time;
@property (nonatomic, retain) NSDate *Submit_Time;
@property (nonatomic, retain) NSString *Seat_No;
@property (nonatomic, retain) EntityStatus *Status;
@property (nonatomic, retain) NSNumber *Dish_Index;
@property (nonatomic, retain) NSNumber *willShow;
@property (nonatomic, retain) EntityOrderedInfo *Ordered_Info;

@end
