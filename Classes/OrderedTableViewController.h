//
//  OrderedTableViewController.h
//  padOrder
//
//  Created by ; Cho on 2010/9/9.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#define ROW_HEIGHT 100;
#define HEADER_HEIGHT 30;

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
@interface OrderedTableViewController : UITableViewController<UIActionSheetDelegate,UIAlertViewDelegate> {
    NSDictionary *chineseHeader;
    NSFetchedResultsController *fetchedResultsController;
    OrderedListViewController *listViewController;
    OrderedDishModelController *orderedDishModelController;
    OrderedInfoModelController *orderedInfoModelController;
    NSNumber *totalPrice;
    BOOL isClear;
}

@property (nonatomic, retain) NSDictionary *chineseHeader;
@property (nonatomic, retain) OrderedListViewController *listViewController;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) OrderedDishModelController *orderedDishModelController;
@property (nonatomic, retain) OrderedInfoModelController *orderedInfoModelController;
@property (nonatomic, retain) NSNumber *totalPrice;
@property (nonatomic) BOOL isClear;

- (void) showTableViewData;
- (void) reloadTableViewSelectToIndexPath:(NSIndexPath *)indexPath usingAnimationTransition:(UIViewAnimationTransition)transition usingSelectAnimation:(BOOL) boolean;

- (NSIndexPath *) indexPathAndRefreshWithEntity:(EntityOrderedInfo *)infoEntity;
- (void) refreshFetchedResultsController;
- (void) refreshFetchedResultsControllerByStatusFrom:(NSInteger)from to:(NSInteger)to;
- (void) clearAllOrderedDish;
- (void) clearAllOrderingDish;
- (void) countOrderedDishTotalPrice;
- (void) sendOrderingList;
- (void) hiddenObject;
- (UIImage *) image:(UIImage *)image reSize:(CGSize)size;

@end
