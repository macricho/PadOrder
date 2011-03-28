//
//  EntityDishSet.h
//  padOrder
//
//  Created by Macric Cho on 2010/10/25.
//  Copyright 2010 Macricho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EntityRefer.h"


@interface EntityDishSet : EntityRefer {
    NSString *Set_Name;
    NSString *Set_Note;
}

@property (nonatomic, retain) NSString *Set_Name;
@property (nonatomic, retain) NSString *Set_Note;
@end
