//
//  EntityOrderKind.h
//  padOrder
//
//  Created by Macric Cho on 2010/10/29.
//  Copyright 2010 Macricho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EntityRefer.h"

@interface EntityOrderKind : EntityRefer {

}
@property (nonatomic, retain) NSString *Kind_Name;
@property (nonatomic, retain) NSNumber *Kind_No;
@property (nonatomic, retain) NSNumber *Segment_Type;
@property (nonatomic, retain) NSNumber *Will_Show;

+ (NSFetchRequest *) fetchAllShowKind;

@end
