//
//  padOrderDataManager.m
//  padOrder
//
//  Created by Macric Cho on 2010/9/18.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "padOrderDataManager.h"
#import "padOrderAppDelegate.h"

#import "EntityDish.h"
#import "EntityOrderedDish.h"

@implementation padOrderDataManager
@synthesize fetchedResultsController;
@synthesize managedObjectContext;
@synthesize padOrderApplicationDelegate;
@synthesize entityName;


#pragma mark -
#pragma mark Self-medthod

- (void) reloadFetchedResults{
    
}

- (NSFetchedResultsController *) fetchedResultsControllerWithRequest:(NSFetchRequest *)request{
    if (fetchedResultsController != nil) {
        return fetchedResultsController;
    }
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:@"Root"];
    
    aFetchedResultsController.delegate = self;
    
    self.fetchedResultsController = aFetchedResultsController;
    
    [aFetchedResultsController release];
    
    return fetchedResultsController;
    
}

#pragma mark -
#pragma mark init

- (id) init{
    if(self = [super init]){
        self.padOrderApplicationDelegate = [[UIApplication sharedApplication] delegate];//取得本應用程式的委派！
        self.managedObjectContext = padOrderApplicationDelegate.managedObjectContext;
        fetchedResultsController = [self fetchedResultsController];
    }
    return self;
}

- (id) initWithEntityName:(NSString *)entity{
    self = [self init];
    self.entityName = entity;
    return self;
}

- (void) insertNewObjectWithDictionary:(NSDictionary *)dictionary{
    //(@"InsertNewObject");
    // Create a new instance of the entity managed by the fetched results controller.
    NSManagedObjectContext *context = [fetchedResultsController managedObjectContext];
    NSEntityDescription *entity = [[fetchedResultsController fetchRequest] entity];
    
    EntityDish *newManagedObject = [[EntityDish alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
    newManagedObject.Dish_No = @"002";
    newManagedObject.Dish_Name = @"112";
    newManagedObject.Update_Date = [NSDate date];
    
    NSEntityDescription *orderedEntity = [NSEntityDescription entityForName:@"Ordered_Dish" inManagedObjectContext:context];
    EntityOrderedDish *orderedDish = [[EntityOrderedDish alloc] initWithEntity:orderedEntity insertIntoManagedObjectContext:context];
    orderedDish.Dish = newManagedObject;
    //orderedDish.Status_No = @" 1";
    //NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
    
    // If appropriate, configure the new managed object.
    //for (id key in dictionary) {
    //    [newManagedObject setValue:[dictionary objectForKey:key] forKey:key];
    //}
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         */
        //(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    //NSIndexPath *insertionPath = [fetchedResultsController indexPathForObject:newManagedObject];
    //[tableView selectRowAtIndexPath:insertionPath animated:YES scrollPosition:UITableViewScrollPositionTop];
}

//原始的插入內容資料
- (void)insertNewObjectForTableView:(UITableView *)tableView {
    NSIndexPath *currentSelection = [tableView indexPathForSelectedRow];
    if (currentSelection != nil) {
        [tableView deselectRowAtIndexPath:currentSelection animated:NO];
    }    

    // Create a new instance of the entity managed by the fetched results controller.
    NSManagedObjectContext *context = [fetchedResultsController managedObjectContext];
    NSEntityDescription *entity = [[fetchedResultsController fetchRequest] entity];
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
    
    // If appropriate, configure the new managed object.
    [newManagedObject setValue:[NSDate date] forKey:@"timeStamp"];
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         */
        //(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    NSIndexPath *insertionPath = [fetchedResultsController indexPathForObject:newManagedObject];
    [tableView selectRowAtIndexPath:insertionPath animated:YES scrollPosition:UITableViewScrollPositionTop];
    //detailViewController.detailItem = newManagedObject;
}

#pragma mark -
#pragma mark Fetched results controller



- (NSFetchedResultsController *)fetchedResultsController {
    if (fetchedResultsController != nil) {
        return fetchedResultsController;
    }
    
    //
    // Set up the fetched results controller.
    // Create the fetch request for the entity.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Dishes" inManagedObjectContext:self.padOrderApplicationDelegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"Dish_No" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];

    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:@"Root"];
    
    aFetchedResultsController.delegate = self;
    
    self.fetchedResultsController = aFetchedResultsController;

    [aFetchedResultsController release];
    [fetchRequest release];
    [sortDescriptor release];
    [sortDescriptors release];
    
    return fetchedResultsController;
}    

#pragma mark -
#pragma mark Fetched results controller delegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    //[self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    /*
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
     */
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            //(@"Insert");
            break;
            
        case NSFetchedResultsChangeDelete:
            //(@"Delete");
            break;
            
        case NSFetchedResultsChangeUpdate:
            //(@"Update");
            break;
            
        case NSFetchedResultsChangeMove:
            //(@"Move");
            break;
    }

}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
   // [self.tableView endUpdates];
    //(@"Change?");
}

@end
