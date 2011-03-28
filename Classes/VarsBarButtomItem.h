//
//  VarsBarButtomItem.h
//  padOrder
//
//  Created by Macric Cho on 2010/11/16.
//  Copyright 2010 Macricho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UniversialBarButtomItem.h"

@class EntityDishSet;
@interface VarsBarButtomItem : UniversialBarButtomItem {
    EntityDishSet *Set;
    NSIndexPath *indexPath;
}

@property (nonatomic, retain) EntityDishSet *Set;
@property (nonatomic, retain) NSIndexPath *indexPath;

@end
