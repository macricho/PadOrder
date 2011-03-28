//
//  DishDetailViewController.h
//  padOrder
//
//  Created by Macric Cho on 2010/11/1.
//  Copyright 2010 Macricho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "padOrderViewController.h"
#import "DishDataTableViewController.h"
#import "VarsButton.h"

@interface DishDetailViewController : padOrderViewController {
    UINavigationBar *navigationBar;
    UIScrollView *contentScrollView;
    UIScrollView *moreImageScrollView;
    UIImageView *dishImageView;
    UILabel *dishTitle;
    UILabel *dishPrice;
    UITextView *dishDescription;
    VarsButton *addButton;
    DishDataTableViewController *tableViewController;
	NSIndexPath *indexPath;
}
@property (nonatomic, retain) IBOutlet UIScrollView *contentScrollView;
@property (nonatomic, retain) DishDataTableViewController *tableViewController;
@property (nonatomic, retain) IBOutlet VarsButton *addButton;
@property (nonatomic, retain) IBOutlet UILabel *dishTitle;
@property (nonatomic, retain) IBOutlet UIImageView *dishImageView;
@property (nonatomic, retain) UINavigationBar *navigationBar;
@property (nonatomic, retain) IBOutlet UITextView *dishDescription;
@property (nonatomic, retain) IBOutlet UILabel *dishPrice;
@property (nonatomic, retain) IBOutlet UIScrollView *moreImageScrollView;
@property (nonatomic, retain) NSIndexPath *indexPath;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil indexPath:(NSIndexPath *)indexPath;

- (BOOL) resetContentScrollFrameWithOrientation:(UIInterfaceOrientation)interfaceOrientation;

@end
