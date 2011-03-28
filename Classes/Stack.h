//
//  Stack.h
//  padOrder
//
//  Created by Macric Cho on 2010/10/7.
//  Copyright 2010 Macricho. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Stack : NSMutableArray {

}

- (NSMutableArray *) pop;
- (void) push:(id)object;
@end
