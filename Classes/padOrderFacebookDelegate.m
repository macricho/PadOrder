//
//  padOrderFacebookDelegate.m
//  padOrder
//
//  Created by Macric Cho on 2010/11/9.
//  Copyright 2010 Macricho. All rights reserved.
//

#import "padOrderFacebookDelegate.h"


@implementation padOrderFacebookDelegate
@synthesize facebook;

- (id) init{
    if(self = [super init]){
        self.facebook = [[Facebook alloc] init];
    }
    return self;
}

@end
