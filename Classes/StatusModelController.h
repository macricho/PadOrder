//
//  StatusModelController.h
//  padOrder
//
//  Created by Macric Cho on 2010/11/7.
//  Copyright 2010 Macricho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "padOrderModelObject.h"
#import "Stack.h"

@class EntityStatus;
@interface StatusModelController : padOrderModelObject{
    
}

- (NSDictionary *) statusNoToNameDictionary;
- (EntityStatus *) statusObjectWithNo:(NSInteger)no;


@end
