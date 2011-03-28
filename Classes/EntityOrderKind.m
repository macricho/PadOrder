//
//  EntityOrderKind.m
//  padOrder
//
//  Created by Macric Cho on 2010/10/29.
//  Copyright 2010 Macricho. All rights reserved.
//

#import "EntityOrderKind.h"


@implementation EntityOrderKind
@dynamic Kind_Name;
@dynamic Kind_No;
@dynamic Segment_Type;
@dynamic Will_Show;

+ (NSFetchRequest *) fetchAllShowKind{
    NSFetchRequest *request = [self fetchRequestTemplateForName:@"allShowKind"];
    return request;
}

@end
