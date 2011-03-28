//
//  DishViewController.h
//  padOrder
//
//  Created by Macric Cho on 2010/9/8.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "padOrderViewController.h"

@class DishDataTableViewController;
@class DishDataTableView;
@class padOrderSegmentSetupController;
@class DishDataModelController;
@interface DishViewController : padOrderViewController {
    DishDataTableView *tableView;
    UISegmentedControl *segmentControl;
    
    NSArray *segmentArray;
    padOrderSegmentSetupController *segmentSetupController;
    DishDataTableViewController *tableViewController;
    UIImageView *bgTopImageView;
    UILabel *contentTextLabel;
    //UILabel *topTitleLabel;
}
@property (nonatomic, retain) NSArray *segmentArray;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet DishDataTableViewController *tableViewController;
@property (nonatomic, retain) padOrderAppDelegate *padOrderDelegate;
@property (nonatomic, retain) padOrderSegmentSetupController *segmentSetupController;

//@property (nonatomic, retain) IBOutlet UILabel *topTitleLabel;

@property (nonatomic, retain) IBOutlet UISegmentedControl *segmentControl;
@property (nonatomic, retain) IBOutlet UIImageView *bgTopImageView;
@property (nonatomic, retain) IBOutlet UILabel *contentTextLabel;
- (void) refreshFetchedResultsControllerWithIndex:(NSInteger)index;

@end
