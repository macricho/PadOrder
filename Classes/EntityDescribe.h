//
//  Describe.h
//  padOrder
//
//  Created by Macric Cho on 2010/9/26.
//  Copyright 2010 Macricho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EntityRefer.h"
#import "EntityDish.h"
@interface EntityDescribe : EntityRefer {

}

@property (nonatomic, retain) NSString *Describe_Complete;
@property (nonatomic, retain) NSString *Describe_Simple;
@property (nonatomic, retain) EntityDish *Dish;
@end
