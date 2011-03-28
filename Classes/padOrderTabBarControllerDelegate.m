//
//  padOrderTabBarControllerDelegate.m
//  padOrder
//
//  Created by Macric Cho on 2010/9/8.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "padOrderTabBarControllerDelegate.h"
#import "padOrderSplitControllerDelegate.h"
#import "MainFuncViewController.h"
#import "padOrderAlertViewDelegate.h"
#import "padOrderAppDelegate.h"
#import "DishDetailViewController.h"

@implementation padOrderTabBarControllerDelegate
@synthesize splitControllerDelegate;
@synthesize mainViewController;
@synthesize splitPopoverButton;
@synthesize beforeNavController;
@synthesize blackView;
@synthesize blackViewController;
@synthesize actionSheet;
#pragma mark -
#pragma mark  AlertDelegate

-(void) willPresentAlertView:(UIAlertView *)alertView{
    CGFloat originX = alertView.frame.origin.x;
    CGFloat originY = alertView.frame.origin.y;
    CGFloat originWidth = alertView.frame.size.width;
    CGFloat originHeight = alertView.frame.size.height;
    
    //alertView.frame = CGRectMake(originX, originY, originWidth, originHeight+100);
    ////(@"%@",alertView.subviews);
    for (id item in alertView.subviews) {
        if([[[item class] description] isEqual:@"UIThreePartButton"]){
                ////(@"%@",item);
                //(UIThreePartButton)item.frame.origin.y += 10;
        }
    }
}

-(void) didPresentAlertView:(UIAlertView *)alertView{
}

#pragma mark -
#pragma mark  TabBarDelegate

- (void) awakeFromNib{
}

- (void) tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    ////(@"tabBar-selected %@",splitControllerDelegate);

    padOrderAppDelegate *applicationDeleagte = nil;
    
    
    if(viewController.view.tag == 0){
        applicationDeleagte = (padOrderAppDelegate *)[[UIApplication sharedApplication] delegate];
        [applicationDeleagte backToIndexView:[NSNumber numberWithInt:beforeNavController.view.tag]];
    }
    
    else if(viewController == beforeNavController){

    }
    
    else if(viewController.view.tag == 3 ){
        
        self.actionSheet = [[UIActionSheet alloc] initWithTitle:@"請點選欲請求服務" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"鍋底加湯",@"清桌服務",@"疑難雜症",@"登出社交網",nil];
        
        actionSheet.frame = CGRectMake(100, 100, 500, 500);
        [actionSheet addButtonWithTitle:@"Space"];
        //actionSheet.userInteractionEnabled = NO;
        
        ////(@"%d",actionSheet.userInteractionEnabled);
        
        self.blackViewController = [[UIViewController alloc] init];
        self.blackViewController.view.frame = [[UIScreen mainScreen] bounds];
        self.blackViewController.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];

        //self.blackView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        //blackView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        //[[(padOrderAppDelegate *)[[UIApplication sharedApplication] delegate] window] addSubview:blackView];
        [[(padOrderAppDelegate *)[[UIApplication sharedApplication] delegate] window] addSubview:blackViewController.view];
        [actionSheet showInView:blackViewController.view];
        
        //[HH showFromRect:CGRectMake(0, 0, 400, 500) inView:viewController.view animated:YES];
        
         
        
        //if (beforeNavController.view.tag == 0) {
        //    viewController = [[tabBarController viewControllers] objectAtIndex:1];
        //}
        /*
        UIAlertView *serviceAlertView = [[UIAlertView alloc] initWithTitle:@"請點選欲請求服務" message:@"別忘了謝謝辛苦的服務人員喔！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"鍋底加湯",@"清桌服務",@"疑難雜症",nil];
            //[serviceAlertView setAccessibilityFrame:CGRectMake(100, 500, 500, 300)];
            //[serviceAlertView setBounds:CGRectMake(0, 0, 500, 500)];
        [serviceAlertView show];
         */
        tabBarController.selectedViewController = beforeNavController;
    }
    else{
        self.splitPopoverButton = (UINavigationItem *)beforeNavController.topViewController.navigationItem.leftBarButtonItem;
        if (viewController.interfaceOrientation == UIInterfaceOrientationPortrait || UIInterfaceOrientationPortraitUpsideDown) {
            [(UINavigationController *)viewController topViewController].navigationItem.leftBarButtonItem = splitPopoverButton;
            beforeNavController.topViewController.navigationItem.leftBarButtonItem = nil;
        }
        beforeNavController = (UINavigationController *)viewController;
        UINavigationController *navigation = (UINavigationController *)viewController;
        
        if([[[[navigation visibleViewController] class] description] isEqualToString:@"DishDetailViewController"]){
            DishDetailViewController *detailViewController = (DishDetailViewController *)navigation.visibleViewController;
            [detailViewController resetContentScrollFrameWithOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
        }
        
        
    }
    
}

- (void)actionSheetCancel:(UIActionSheet *)actionSheet{
    
}

- (void)willPresentActionSheet:(UIActionSheet *)actionSheet{
    UILabel *titleLabel = nil;
    //NSInteger buttonCounter = 0;
    for (UIView *object in actionSheet.subviews) {
        if ([[[object class] description] isEqualToString:@"UILabel"]) {
            titleLabel = (UILabel *)object;
        }
        else{
            CGPoint objOrigin = object.frame.origin;
            CGSize  objSize = object.frame.size;
            CGFloat objHeight = objSize.height;
            object.frame = CGRectMake(objOrigin.x, objOrigin.y+objHeight, objSize.width, objSize.height);
            //buttonCounter++;
        }
    }
    
    ////(@"%@,max:%d",actionSheet.subviews,buttonCounter);
    
    NSInteger buttonMaxTag = [actionSheet numberOfButtons];
    [[actionSheet viewWithTag:buttonMaxTag] removeFromSuperview];
    
    CGFloat fontSize = 25;
    CGRect titleFrame = titleLabel.frame;
    CGPoint titleOrigin = titleFrame.origin;
    CGSize  titleSize = titleFrame.size;
    
    titleLabel.frame = CGRectMake(titleOrigin.x, titleOrigin.y+10, titleSize.width, fontSize);
    
    titleLabel.text = [NSString stringWithFormat:@"%@",titleLabel.text,titleLabel.text];
    titleLabel.font = [UIFont fontWithName:titleLabel.font.fontName size:fontSize];
    
    UILabel *subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleOrigin.x, titleOrigin.y+40, titleSize.width, titleSize.height)];
    
    subTitleLabel.textColor = titleLabel.textColor;
    subTitleLabel.shadowColor = titleLabel.shadowColor;
    subTitleLabel.shadowOffset = titleLabel.shadowOffset;
    subTitleLabel.font = [UIFont fontWithName:subTitleLabel.font.fontName size:16];
    subTitleLabel.text = @"別忘了謝謝辛苦的服務人員喔！";
    subTitleLabel.backgroundColor = [UIColor clearColor];
    subTitleLabel.textAlignment = UITextAlignmentCenter;
    [actionSheet addSubview:subTitleLabel];
     
}

- (void)didPresentActionSheet:(UIActionSheet *)actionSheet{
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    [UIView beginAnimations:@"RemoveBlackBackGroundView" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.5];
    //blackView.alpha = 0;
    blackViewController.view.alpha = 0;
    //[blackView removeFromSuperview];
    [UIView commitAnimations];
    [blackViewController.view performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.5];
    //[blackView performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.5];
}

@end
