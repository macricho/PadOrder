    //
//  DishDetailViewController.m
//  padOrder
//
//  Created by Macric Cho on 2010/11/1.
//  Copyright 2010 Macricho. All rights reserved.
//

#import "DishDetailViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation DishDetailViewController
@synthesize navigationBar;
@synthesize dishDescription;
@synthesize moreImageScrollView;
@synthesize dishImageView;
@synthesize dishTitle;
@synthesize dishPrice;
@synthesize addButton;
@synthesize tableViewController;
@synthesize contentScrollView;
@synthesize indexPath;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil indexPath:(NSIndexPath *)indexPath {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg-pattern.png"]];
        self.topTitleLabel.text = @"Introduction";
        //self.submitButton.indexPath = indexPath;
        //self.dishImageView.frame = CGRectMake(69, 146, 200, 200);
        //self.dishImageView.frame = CGRectMake(50, 88, 200, 200);
    }
    return self;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dishImageView.layer.cornerRadius = 10;
    self.dishImageView.layer.masksToBounds = YES;
    
    self.contentScrollView.alwaysBounceVertical = YES;
    self.contentScrollView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    
        //self.moreImageScrollView.canCancelContentTouches = NO;
    self.moreImageScrollView.clipsToBounds = YES;
    self.moreImageScrollView.alwaysBounceHorizontal = YES;
        //self.moreImageScrollView.alwaysBounceVertical = YES;
    self.moreImageScrollView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    //UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tableViewBackground.png"]];
    //[self.moreImageScrollView addSubview:imageView];
    //self.moreImageScrollView.contentSize = CGSizeMake(imageView.frame.size.width, imageView.frame.size.height);
    self.moreImageScrollView.scrollEnabled = YES;
	self.addButton.isDetail = YES;
    self.addButton.indexPath = self.indexPath;
    //[self.addButton addTarget:self.tableViewController action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
	////(@"2:%@",self.tableViewController);
	//[self.addButton addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    CGRect contentFrame = self.contentScrollView.frame;
    CGPoint contentOrigin = contentFrame.origin;
    CGSize contentSize = contentFrame.size;
    
    self.contentScrollView.contentSize = contentSize;
    self.contentScrollView.frame = CGRectMake(58, 117, contentSize.width, 750);
    [self.view addSubview:self.contentScrollView];
    //[self.view addSubview:self.addButton];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    BOOL result = [self resetContentScrollFrameWithOrientation:interfaceOrientation];
    return result;
}

- (BOOL)resetContentScrollFrameWithOrientation:(UIInterfaceOrientation)interfaceOrientation{
    CGRect bgFrame = self.imageBgView.frame;
    CGPoint bgOrigin = bgFrame.origin;
    CGSize bgSize = bgFrame.size;
    CGFloat bgHeight = self.view.frame.size.height;
    
    CGSize contentSize = contentScrollView.contentSize;
    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortrait:
        case UIInterfaceOrientationPortraitUpsideDown:
            self.contentScrollView.contentSize = CGSizeMake(652, contentSize.height);
            self.imageBgView.frame = CGRectMake(bgOrigin.x, bgOrigin.y, bgSize.width, 911);
            return YES;
            break;
        default:
            self.imageBgView.frame = CGRectMake(bgOrigin.x, bgOrigin.y, bgSize.width, 655);
            self.contentScrollView.contentSize = CGSizeMake(596, contentSize.height);
            ////(@"rotate Land");
            return NO;
            break;
    }

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
    //(@"UNLOAD");
}


- (void)dealloc {
    [super dealloc];
}

@end
