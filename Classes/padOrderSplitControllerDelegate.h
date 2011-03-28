//
//  padOrderSplitControllerDelegate.h
//  padOrder
//
//  Created by Macric Cho on 2010/9/8.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class MainFuncViewController;
@class padOrderPopoverDelegate;
@interface padOrderSplitControllerDelegate : NSObject <UISplitViewControllerDelegate,UIPopoverControllerDelegate>{
    UINavigationController *selectedNavController;
    MainFuncViewController *mainViewController;
    UIPopoverController *popOverController;
}

@property (nonatomic, retain) UIPopoverController *popOverController;

@end
