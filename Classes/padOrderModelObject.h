//
//  padOrderModelObject.h
//  padOrder
//
//  Created by Macric Cho on 2010/10/3.
//  Copyright 2010 Macricho. All rights reserved.
//

#import <Foundation/Foundation.h>

@class padOrderAppDelegate;

@interface padOrderModelObject : NSObject {
    NSManagedObjectContext *managedObjectContext;
    NSEntityDescription *entity;
    padOrderAppDelegate *appDelegateObject;
}

@property (nonatomic, retain) padOrderAppDelegate *appDelegateObject;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSEntityDescription *entity;

- (void) saveToContext;
- (NSFetchRequest *) createSimpleFetchRequest;
- (void) refreshFetchedResultsController:(NSFetchedResultsController *)fetchResultsController;
- (void) deleteAllFetchedResultWithController:(NSFetchedResultsController *)fetchedResultController;
- (NSArray *) entity:(NSString *)entityString withPredicate:(NSString *)predicateString sortBy:(NSString *)valueKey  ascending:(BOOL)asc;
- (NSArray *) executeFetchRequest:(NSFetchRequest *)fetchRequest;
- (NSArray *) getFetchedResultWithPredicate:(NSString *)predicateString sortBy:(NSString *)valueKey ascending:(BOOL)asc;
@end
