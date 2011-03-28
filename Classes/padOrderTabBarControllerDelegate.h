//
//  padOrderTabBarControllerDelegate.h
//  padOrder
//
//  Created by Macric Cho on 2010/9/8.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <Foundation/Foundation.h>

@class padOrderSplitControllerDelegate;
@class MainFuncViewController;

@interface padOrderTabBarControllerDelegate : NSObject <UITabBarControllerDelegate,UIAlertViewDelegate,UIActionSheetDelegate>{
    padOrderSplitControllerDelegate *splitControllerDelegate;
    MainFuncViewController *mainViewController;
    UINavigationItem *splitPopoverButton;
    UINavigationController *beforeNavController;
    UIView *blackView;
    UIViewController *blackViewController;
    UIActionSheet *actionSheet;
}

@property (nonatomic, assign) padOrderSplitControllerDelegate *splitControllerDelegate;
@property (nonatomic, assign) IBOutlet MainFuncViewController *mainViewController;
@property (nonatomic, retain) UINavigationItem *splitPopoverButton;
@property (nonatomic, retain) UINavigationController *beforeNavController;
@property (nonatomic, retain) UIView *blackView;
@property (nonatomic, retain) UIViewController *blackViewController;
@property (nonatomic, retain) UIActionSheet *actionSheet;
@end
