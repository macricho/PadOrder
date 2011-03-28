//
//  Stack.m
//  padOrder
//
//  Created by Macric Cho on 2010/10/7.
//  Copyright 2010 Macricho. All rights reserved.
//

#import "Stack.h"


@implementation Stack

- (NSMutableArray *) pop{
    if([self count] == 0) return nil;
    id object =  [self lastObject];
    return object;
}

- (void) push:(id)object{
    [self addObject:object];
}

@end
