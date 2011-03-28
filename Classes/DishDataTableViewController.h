//
//  DishDataTableViewController.h
//  padOrder
//
//  Created by Macric Cho on 2010/9/19.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OrderedInfoModelController;
@class DishTableCellView;
@class DishDataTableView;
@class EntityDish;
@class EntityOrderedInfo;
@class EntityDishSet;
@class OrderedListViewController;
@class DishDetailViewController;
@class padOrderAppDelegate;
@class VarsBarButtomItem;
@class MoveAnimationController;
@class SetInfomationViewController;
@class DishForOrderViewController;
@class VarsButton;
@interface DishDataTableViewController : UITableViewController<UITableViewDelegate,UIActionSheetDelegate> {
    NSDictionary *dataDictionary;
    DishTableCellView *tableCellView;
    DishForOrderViewController *dishMenuViewController;
    OrderedListViewController *orderedListViewController;
    UINavigationController *navigationController;
    NSFetchedResultsController *fetchedResultsController;
    padOrderAppDelegate *appDelegate;
    MoveAnimationController *moveAnimationController;
    UIPopoverController *popoverController;
    SetInfomationViewController *setInfoViewController;
    BOOL onSearch;
    UITextField *dishCountTextField;
    VarsButton *adderButton;
}
@property (nonatomic) BOOL onSearch;
@property (nonatomic, retain) UIPopoverController *popoverController;
@property (nonatomic, retain) UINavigationController *navigationController;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSDictionary *dataDictionary;
@property (nonatomic, retain) OrderedListViewController *orderedListViewController;
@property (nonatomic, retain) IBOutlet DishTableCellView *tableCellView;
@property (nonatomic, retain) padOrderAppDelegate *appDelegate;
@property (nonatomic, retain) MoveAnimationController *moveAnimationController;
@property (nonatomic, retain) SetInfomationViewController *setInfoViewController;
@property (nonatomic, retain) DishForOrderViewController *dishMenuViewController;
@property (nonatomic, retain) DishDetailViewController *detailViewController;
@property (nonatomic, retain) UITextField *dishCountTextField;
@property (nonatomic, retain) VarsButton *adderButton;


- (void) showSetScetionInfo:(id)sender;
- (void) buttonAction:(id)sender;
- (void) buttonDetail:(id)sender;
- (void) reloadTableViewAfterAnimationWithIndexPath:(NSIndexPath *)indexPath;

@end
