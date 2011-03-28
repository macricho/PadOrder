//
//  CookingStatusTableViewController.h
//  padOrder
//
//  Created by 均諺 on 2010/12/6.
//  Copyright 2010 Macricho. All rights reserved.
//

#import <UIKit/UIKit.h>


@class padOrderSplitControllerDelegate;
@class padOrderDataManager;
@class EntityOrderedDish;
@class EntityDish;
@class CustomCellView;
@class OrderedListViewController;

@class StatusModelController;
@class OrderedDishModelController;
@class OrderedInfoModelController;
@class EntityOrderedInfo;
@class Stack;
@interface CookingTableViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate> {
    NSFetchedResultsController *fetchedResultsController;
    OrderedListViewController *listViewController;
    OrderedDishModelController *orderedDishModelController;
    OrderedInfoModelController *orderedInfoModelController;
}

@property (nonatomic, retain) OrderedListViewController *listViewController;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) OrderedDishModelController *orderedDishModelController;
@property (nonatomic, retain) OrderedInfoModelController *orderedInfoModelController;

- (void) reloadDataSource;

@end
