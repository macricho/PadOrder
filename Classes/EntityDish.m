//
//  Dish.m
//  padOrder
//
//  Created by Macric Cho on 2010/9/26.
//  Copyright 2010 Macricho. All rights reserved.
//

#import "EntityDish.h"

@implementation EntityDish
@dynamic Dish_Name;
@dynamic Dish_No;
@dynamic Update_Date;
@dynamic Describe;
@dynamic Dish_Price;
@dynamic DishSet;
@dynamic Kind;
@dynamic Images;
/*
- (UIImage *) Dish_Image{
    //(@"Enter");
    //NSString *documentPath = [[self padOrderApp] applicationDocumentsDirectory];
    documentPath = [documentPath stringByAppendingPathComponent:@"DishImages/"];
    documentPath = [documentPath stringByAppendingPathComponent:@"0.png"];
    self.Dish_Image = [UIImage imageWithContentsOfFile:documentPath];
    //(@"Leave");
    
    return self.Dish_Image;
;
}*/

/*
-(NSString *) dish_name{
    
}

- (NSString *) dish_no{
    //(@"Dish Class Dish");
    return self.dish_no;
}

- (NSDate *) update_date{
    
}
*/
/*
- (EntityImage *) Images{
    //(@"Here");
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Dishes_Images" inManagedObjectContext:[self managedObjectContext]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"IsMainImage = YES"];
    NSError *error;
    [request setEntity:entity];
    [request setPredicate:predicate];
    //[request set]
    return [[[self managedObjectContext] executeFetchRequest:request error:&error] objectAtIndex:0];
    
}*/

@end
