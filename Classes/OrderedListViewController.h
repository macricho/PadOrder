//
//  OrderedListViewController.h
//  padOrder
//
//  Created by Macric Cho on 2010/9/1.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllEntity.h"

@class OrderedTableViewController;
@class padOrderAppDelegate;
@class padOrderDataManager;
@class DishDataModelController;
@class OrderedDishModelController;
@class OrderedInfoModelController;
@class CustomAlertView;
@class CookingTableViewController;

@interface OrderedListViewController : UIViewController <UIAlertViewDelegate>{
    UITableView *tableView;
    OrderedTableViewController *orderedTableViewController;
    NSManagedObjectContext *managedObjectContext;
    padOrderDataManager *padOrderDataManagerDelegate;
    UIButton *clearAllButton;
    UIButton *submitButton;
    UIView *remindedView;
    UILabel *totalPriceLabel;
    NSNumber *totalPrice;
    UISegmentedControl *segmentControl;
    CookingTableViewController *cookingTableViewController;
    UINavigationBar *naviBar;
}
@property (nonatomic, retain) IBOutlet UIButton *submitButton;
@property (nonatomic , retain) padOrderDataManager *padOrderDataManagerDelegate;
@property (nonatomic, retain) IBOutlet OrderedTableViewController *orderedTableViewController;
@property (nonatomic, retain) IBOutlet UISegmentedControl *segmentControl;
@property (nonatomic, retain) IBOutlet UITableView *tableView;

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) IBOutlet UIView *remindedView;
@property (nonatomic, retain) IBOutlet UIButton *clearAllButton;
@property (nonatomic, retain) IBOutlet UILabel *totalPriceLabel;
@property (nonatomic, retain) NSNumber *totalPrice;

@property (nonatomic, retain) UINavigationBar *naviBar;

@property (nonatomic, retain) CookingTableViewController *cookingTableViewController;

- (void) reloadTableViewSelectToIndexPath:(NSIndexPath *)indexPath usingAnimationTransition:(UIViewAnimationTransition)transition usingSelectAnimation:(BOOL) boolean;
- (void) reloadTableViewScrollToIndexPath:(NSIndexPath *)indexPath usingAnimationTransition:(UIViewAnimationTransition)transition usingSelectAnimation:(BOOL) boolean;
- (void)pureReloadTableViewWithAnimation:(BOOL)animation;
- (void) switchTableViewToOrding;
- (IBAction) clearAllOrderedDish:(id)sender;
- (IBAction) billSender:(id)sender;
- (void) switchTableView:(id)sender;
- (NSString *) getApplicationDocumentPath;
- (CGSize) getContentSizeInPopover;
- (BOOL) checkHasFetched;
- (void) refreshPriceLabel;
- (void) changeSubmitButtonTitle;
- (void) animation:(UIViewAnimationTransition)transition ToSwitch:(UITableView *)aView;
@end
