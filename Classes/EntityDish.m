//
//  Dish.m
//  padOrder
//
//  Created by Macric Cho on 2010/9/26.
//  Copyright 2010 Macricho. All rights reserved.
//

#import "EntityDish.h"
#import "EntityImage.h"

@implementation EntityDish
@dynamic Dish_Name;
@dynamic Dish_No;
@dynamic Update_Date;
@dynamic Describe;
@dynamic Dish_Price;
@dynamic DishSet;
@dynamic Kind;
@dynamic Images;


- (NSURL *)getURLForMainImageFullPath{
    
    NSURL *url = [[self getApplicationDelegate] applicationDocumentsDirectory];
    for (EntityImage *image in self.Images) {
        if ([image.Dish isEqual:self]) {
            url = [url URLByAppendingPathComponent:image.Image_Path];
            url = [url URLByAppendingPathComponent:image.Image_FileName];
            //return image;
            break;
        }
    }
    return url;
}


@end
