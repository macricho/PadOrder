//
//  padOrderSplitControllerDelegate.m
//  padOrder
//
//  Created by Macric Cho on 2010/9/8.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "padOrderSplitControllerDelegate.h"
#import "MainFuncViewController.h"
#import "padOrderPopoverDelegate.h"
#import "OrderedListViewController.h"

@interface UINavigationBar(Color) 
@end

@implementation UINavigationBar(Color)
/*
- (void)setTintColor:(UIColor *)tintColor{
    //[super setTintColor:[self tintColor]];
}
*/
@end


@implementation padOrderSplitControllerDelegate
@synthesize popOverController;


- (void) splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem{
    
    UIViewController *bViewController = self.popOverController.contentViewController;
    
    mainViewController = [svc.viewControllers objectAtIndex:1];
    selectedNavController = (UINavigationController *)mainViewController.funcsTabBarController.selectedViewController;
    selectedNavController.topViewController.navigationItem.leftBarButtonItem = nil;

    if (self.popOverController.popoverVisible) {
        //NSLog(@"還在顯示");
        [self.popOverController dismissPopoverAnimated:YES];
    }
    
    
    self.popOverController = nil;
    self.popOverController.contentViewController = nil;
    //[bViewController release];
    
}

- (void) splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc{
    
    barButtonItem.title = [[svc.viewControllers objectAtIndex:0] title];
    mainViewController = [svc.viewControllers objectAtIndex:1];
    selectedNavController = (UINavigationController *)mainViewController.funcsTabBarController.selectedViewController;
    aViewController.navigationController.navigationBar.tintColor = selectedNavController.navigationBar.tintColor;
    UIViewController *selectedViewController = selectedNavController.topViewController;
    
    if([selectedNavController.viewControllers count]>1) 
        selectedViewController =[selectedNavController.viewControllers objectAtIndex:1];
    
    if(selectedViewController.navigationItem.backBarButtonItem){
        selectedViewController.navigationItem.rightBarButtonItem = barButtonItem;
    }
    else{
        selectedViewController.navigationItem.leftBarButtonItem = barButtonItem;
    }

    self.popOverController = pc;
    pc.delegate = self;
}

- (void) splitViewController:(UISplitViewController *)svc popoverController:(UIPopoverController *)pc willPresentViewController:(UIViewController *)aViewController{
    
    //為了避免原來的ViewController出現問題
    //直接init一個新的listViewController

    OrderedListViewController *rootViewController = [[OrderedListViewController alloc] init];
    
    UINavigationController *showNaviController = [[UINavigationController alloc] initWithRootViewController:rootViewController];

    [pc setContentViewController:showNaviController];
    
}


-(void) popoverControllerDidDismissPopover:(UIPopoverController *)popoverController{
    [popOverController.contentViewController.view removeFromSuperview];
}



@end
