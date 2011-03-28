//
//  padOrderModelObject.m
//  padOrder
//
//  Created by Macric Cho on 2010/10/3.
//  Copyright 2010 Macricho. All rights reserved.
//

#import "padOrderModelObject.h"
#import "padOrderAppDelegate.h"

@implementation padOrderModelObject
@synthesize appDelegateObject;
@synthesize managedObjectContext;
@synthesize entity;

#pragma mark -
#pragma mark init

- (id) init{
    if(self = [super init]){
        //取得本應用程式的委派！
        self.appDelegateObject = (padOrderAppDelegate *)[[UIApplication sharedApplication] delegate];
        self.managedObjectContext = appDelegateObject.managedObjectContext;
    }
    return self;
}

- (NSFetchRequest *) createSimpleFetchRequest{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    [fetchRequest setEntity:self.entity];
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    // Edit the sort key as appropriate.
    return fetchRequest;
}

- (void) refreshFetchedResultsController:(NSFetchedResultsController *)fetchResultsController{
    NSError *error = nil;
    
    if(![fetchResultsController performFetch:&error]){
        //(@"Error!!%@",error);
    }    
}

- (void) deleteAllFetchedResultWithController:(NSFetchedResultsController *)fetchedResultController{
    for (NSManagedObject *object in [fetchedResultController fetchedObjects]) {
        [self.managedObjectContext deleteObject:object];
    }
}

- (void) saveToContext{
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         */
        //(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

- (NSArray *) executeFetchRequest:(NSFetchRequest *)fetchRequest{
    NSError *error;
    return [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
}

- (NSArray *) entity:(NSString *)entityString withPredicate:(NSString *)predicateString sortBy:(NSString *)valueKey  ascending:(BOOL)asc{
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:entityString inManagedObjectContext:self.managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:valueKey ascending:asc];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateString];
    [fetchRequest setEntity:entityDescription];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    return [self executeFetchRequest:fetchRequest];
}


- (NSArray *) getFetchedResultWithPredicate:(NSString *)predicateString sortBy:(NSString *)valueKey ascending:(BOOL)asc{
    return [self entity:[self.entity name] withPredicate:predicateString sortBy:valueKey ascending:asc];
}


@end
