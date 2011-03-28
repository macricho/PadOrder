//
//  padOrderDataManager.h
//  padOrder
//
//  Created by Macric Cho on 2010/9/18.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#define KEY_DISH_NO @"Dish_No"
#define KEY_DISH_NAME @"Dish_Name"
#define KEY_HOT_INDEX @"Hot_Index"
#define KEY_UPDATE_DATE @"Update_Date"
#define KEY_IS_SUGGEST @"isSuggest"
#define KEY_WILL_SHOW @"willShow"
#define KEY_RELATION_SET @"Set"
#define KEY_RELATION_IMAGES @"Images"
#define KEY_RELATION_DESCRIBE @"Describe"
#define KEY_RELATION_KIND @"Kind"


#import <Foundation/Foundation.h>
@class EntityDish;
@class EntityOrderedDish;
@class padOrderAppDelegate;
@interface padOrderDataManager : NSObject <NSFetchedResultsControllerDelegate>{
    NSFetchedResultsController *fetchedResultsController;
    NSManagedObjectContext *managedObjectContext;
    NSString *entityName;
    padOrderAppDelegate *padOrderApplicationDelegate;
}

@property (nonatomic, retain) padOrderAppDelegate *padOrderApplicationDelegate;
@property (nonatomic, retain) NSString *entityName;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (void) insertNewObjectWithDictionary:(NSDictionary *)dictionary;
- (id) initWithEntityName:(NSString *)entity;
- (void)insertNewObjectForTableView:(UITableView *)tableView;
- (NSFetchedResultsController *) fetchedResultsControllerWithRequest:(NSFetchRequest *)request;
@end
