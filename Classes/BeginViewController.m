    //
//  BegainViewController.m
//  padOrder
//
//  Created by Macric Cho on 2010/10/18.
//  Copyright 2010 Macricho. All rights reserved.
//

#import "BeginViewController.h"
#import "padOrderAppDelegate.h"
#import "PadOrderLogoViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation BeginViewController
@synthesize infoButton;
@synthesize tabBarIndex;
@synthesize logoViewController;
@synthesize blackView;
@synthesize testController;

- (IBAction) actionToNext:(id)sender{
    [self.padOrderDelegate actionToNext:sender];
}

#pragma mark -
#pragma mark  program life-circle


 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
        self.tabBarIndex = 1;
        self.logoViewController = [[PadOrderLogoViewController alloc] initWithNibName:@"PadOrderLogoView" bundle:[NSBundle mainBundle]];
        //self.testController = [[UINavigationController alloc] initWithRootViewController:self.logoViewController];
        //self.testController.navigationBar.translucent = YES;
        [self.logoViewController.exitButton addTarget:self action:@selector(hidePadOrderInformation:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (IBAction)hidePadOrderInformation:(id)sender{
    CGFloat endX = (self.view.frame.size.width/4);
    CGFloat endY = (self.view.frame.size.height/4)+self.view.frame.size.height;
    CGFloat width = (self.view.frame.size.width/2);
    CGFloat height = (self.view.frame.size.height/2);
    
    CGPoint right_Top_End =  CGPointMake(endX +width, endY);
    
    UIButton *closeButton = (UIButton *)[self.view viewWithTag:2001];
    CGSize close_button_size = closeButton.currentBackgroundImage.size;
    
    [UIView beginAnimations:@"ShowPadOrderInformation" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1];
    self.logoViewController.view.frame = CGRectMake(endX, endY, width, height);
    closeButton.frame = CGRectMake(right_Top_End.x-(close_button_size.width/2)-2, right_Top_End.y-(close_button_size.height/2)+5, close_button_size.width, close_button_size.height);
    //self.testController.view.frame = CGRectMake(endX, endY, width, height);
    self.blackView.alpha = 0;
    [UIView commitAnimations];
    
}

- (IBAction)showPadOrderInformation:(id)sender{
    
    CGFloat endX = (self.view.frame.size.width/4);
    CGFloat endY = (self.view.frame.size.height/4);
    CGFloat width = (self.view.frame.size.width/2);
    CGFloat height = (self.view.frame.size.height/2);
    
    CGFloat startX = endX;
    CGFloat startY = endY + self.view.frame.size.height;
    
    CGPoint right_Top_Start = CGPointMake(startX+width, startY);
    CGPoint right_Top_End =  CGPointMake(endX +width, endY);
    
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setBackgroundImage:[UIImage imageNamed:@"closebox.png"] forState:UIControlStateNormal];
    [closeButton setBackgroundImage:[UIImage imageNamed:@"closebox_pressed.png"] forState:UIControlStateHighlighted];
    
    CGSize close_button_size = closeButton.currentBackgroundImage.size;
    
    closeButton.frame = CGRectMake(right_Top_Start.x-(close_button_size.width/2), right_Top_Start.y-(close_button_size.height/2), close_button_size.width, close_button_size.height);
    
    if([self.view viewWithTag:2001]) [[self.view viewWithTag:2001] removeFromSuperview];
    closeButton.tag = 2001;
    
    
    [closeButton addTarget:self action:@selector(hidePadOrderInformation:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.blackView = [[UIView alloc] initWithFrame:self.view.frame];
    self.blackView.backgroundColor = [UIColor blackColor];
    self.blackView.alpha = 0;
    
    [self.view addSubview:self.blackView];
    
    self.logoViewController.view.frame = CGRectMake(startX, startY, width, height);
    [self.view addSubview:self.logoViewController.view];
    [self.view addSubview:closeButton];
    
    [UIView beginAnimations:@"ShowPadOrderInformation" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1];
    
    logoViewController.view.frame = CGRectMake(endX, endY, width, height);
    closeButton.frame = CGRectMake(right_Top_End.x-(close_button_size.width/2)-2, right_Top_End.y-(close_button_size.height/2)+5, close_button_size.width, close_button_size.height);
    
    self.blackView.alpha = 0.5;
    [UIView commitAnimations];
    
    //if (shouldBlackViewAlphaEnd == 0) {
    //    [blackView removeFromSuperview];
    //}
    
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	//self.view.backgroundColor = [UIColor brownColor];
    //[self.infoButton addTarget:self action:@selector(test) forControlEvents:UIControlStateNormal];
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
    
}


@end
