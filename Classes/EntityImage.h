//
//  EntityImage.h
//  padOrder
//
//  Created by Macric Cho on 2010/10/29.
//  Copyright 2010 Macricho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EntityRefer.h"
#import "EntityDish.h"

@interface EntityImage : EntityRefer {

}

@property (nonatomic, retain) NSNumber *IsMainImage;
@property (nonatomic, retain) NSString *Image_Path;
@property (nonatomic, retain) NSString *Image_FileName;
@property (nonatomic, retain) EntityDish *Dish;

@end
