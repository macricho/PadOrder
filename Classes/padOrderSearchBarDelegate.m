//
//  padOrderSearchBarDelegate.m
//  padOrder
//
//  Created by Macric Cho on 2010/11/13.
//  Copyright 2010 Macricho. All rights reserved.
//

#import "padOrderSearchBarDelegate.h"
#import "DishDataTableViewController.h"

@implementation padOrderSearchBarDelegate
@synthesize dishDataTableViewController;

- (void) searchDisplayController:(UISearchDisplayController *)controller didShowSearchResultsTableView:(UITableView *)tableView{
    //(@"SHow");
    self.dishDataTableViewController.onSearch = YES;
}

- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    //(@"Change");
    /*NSPredicate *predicate = [NSPredicate predicateWithFormat:@"Dish.Dish_Name like '%@'",searchText];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[self.dishDataTableViewController.fetchedResultsController.fetchRequest entity]];
    [fetchRequest setPredicate:predicate];
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"Dish.Dish_No" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    self.dishDataTableViewController.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext: self.dishDataTableViewController.fetchedResultsController.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
*/
}

- (void) searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    //(@"cancel");
    self.dishDataTableViewController.onSearch = NO;
}


@end
