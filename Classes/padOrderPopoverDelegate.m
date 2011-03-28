//
//  padOrderPopoverDelegate.m
//  padOrder
//
//  Created by Macric Cho on 2010/9/9.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "padOrderPopoverDelegate.h"


@implementation padOrderPopoverDelegate

-(void) popoverControllerDidDismissPopover:(UIPopoverController *)popoverController{
    
    UINavigationController *leftListNaviViewController = (UINavigationController *)popoverController.contentViewController;
    leftListNaviViewController.navigationBar.tintColor = [UIColor grayColor];
    //(@"!!!");
}

- (BOOL) popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController{
    //(@"?????");
    return YES;
}

@end
