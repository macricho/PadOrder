//
//  PadOrderLogoViewController.m
//  padOrder
//
//  Created by Grady Cho on 11/3/11.
//  Copyright 2011年 Macricho. All rights reserved.
//

#import "PadOrderLogoViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation PadOrderLogoViewController
@synthesize exitButton;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        CGRect screenFrame = [[UIScreen mainScreen] bounds];
        //CGFloat endX = (screenFrame.size.width/4);
        //CGFloat endY = (screenFrame.size.height/4);
        CGFloat width = (screenFrame.size.width/2);
        CGFloat height = (screenFrame.size.height/2);
        
        self.view.frame = CGRectMake(0, 0, width, height);
        //self.view.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
        
        
    }
    return self;
}


- (IBAction)hideInfoView:(id)sender{
    //(@"HHHH");
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //self.view.backgroundColor = [UIColor whiteColor];
    //[[View layer] setCornerRadius:xx]  設圓角
    [[self.view layer] setCornerRadius:10];
    [[self.view layer] setBorderWidth:3];
    self.view.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.view.layer.shadowRadius = 5;
    self.view.layer.shadowOffset = CGSizeMake(5, 5);
    self.view.layer.shadowColor = [[UIColor blueColor] CGColor];
    self.view.layer.masksToBounds = YES;
    
    UIView *versionView = [self.view viewWithTag:1001];
    [[versionView layer] setCornerRadius:10];
    [[versionView layer] setMasksToBounds:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end
