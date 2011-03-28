//
//  StatusModelController.m
//  padOrder
//
//  Created by Macric Cho on 2010/11/7.
//  Copyright 2010 Macricho. All rights reserved.
//

#import "StatusModelController.h"
#import "EntityStatus.h"

@implementation StatusModelController

- (id) init{
    if(self = [super init]){
        self.entity = [NSEntityDescription entityForName:@"Status" inManagedObjectContext:managedObjectContext];
    }
    return self;
}

- (NSDictionary *) statusNoToNameDictionary{
    NSFetchRequest *request = [self createSimpleFetchRequest];
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    for (EntityStatus *statusObject in [self.managedObjectContext executeFetchRequest:request error:nil]) {
        [dictionary setObject:statusObject.Status_Name forKey:statusObject.Status_No];
    }
    return dictionary;
}

-(EntityStatus *)statusObjectWithNo:(NSInteger)no{
    NSFetchRequest *request = [self createSimpleFetchRequest];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"Status_No=%d",no];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *statusArray = [self.managedObjectContext executeFetchRequest:request error:&error];
    EntityStatus *statusObject = (EntityStatus *)[statusArray lastObject];

    NSLog(@"Error:%@",error);
    
    return statusObject;
}

@end
