//
//  OrderKindModelController.m
//  padOrder
//
//  Created by Macric Cho on 2010/10/29.
//  Copyright 2010 Macricho. All rights reserved.
//

#import "OrderKindModelController.h"


@implementation OrderKindModelController

#pragma mark -
#pragma mark Initialization

- (id) init{
    if(self = [super init]){
        self.entity = [NSEntityDescription entityForName:@"Dish_Kind" inManagedObjectContext:managedObjectContext];
    }
    return self;
}

- (NSArray *)segmentTitleArrayWithTypeNo:(NSNumber *)segmentNo{
    //(@"1");
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"Segment_Type=%@",segmentNo];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"Dish_Kind" inManagedObjectContext:managedObjectContext]];
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"Kind_No" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    [fetchRequest setPredicate:predicate];
    NSArray *array = [managedObjectContext executeFetchRequest:fetchRequest error:nil];
    return array;
}

@end
