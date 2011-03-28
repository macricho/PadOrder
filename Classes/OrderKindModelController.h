//
//  OrderKindModelController.h
//  padOrder
//
//  Created by Macric Cho on 2010/10/29.
//  Copyright 2010 Macricho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "padOrderModelObject.h"
#import "Stack.h"

@interface OrderKindModelController : padOrderModelObject {

}

- (NSArray *)segmentTitleArrayWithTypeNo:(NSNumber *)segmentNo;
@end
