//
//  EntityRefer.m
//  padOrder
//
//  Created by Macric Cho on 2010/10/27.
//  Copyright 2010 Macricho. All rights reserved.
//

#import "EntityRefer.h"

@implementation EntityRefer

+ (NSFetchRequest *) fetchRequestTemplateForName:(NSString *)name{
    return [[NSManagedObjectModel alloc] fetchRequestTemplateForName:name];
}

@end
