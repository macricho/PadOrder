//
//  EntityStatus.h
//  padOrder
//
//  Created by Macric Cho on 2010/11/7.
//  Copyright 2010 Macricho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EntityRefer.h"

@interface EntityStatus : EntityRefer {

}

@property (nonatomic, retain) NSNumber *Status_No;
@property (nonatomic, retain) NSString *Status_Name;

@end
