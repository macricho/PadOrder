    //
//  NewsViewController.m
//  padOrder
//
//  Created by Macric Cho on 2010/9/8.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NewsViewController.h"


@implementation NewsViewController
@synthesize webView;
@synthesize webToolBar;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
        
    }
    return self;
}

- (void) addHomeButton{
    UIBarButtonItem *home = [[UIBarButtonItem alloc] initWithTitle:@"回首頁" style:UIBarButtonItemStylePlain target:self action:@selector(goHome)];
    NSMutableArray *items = [[self.webToolBar items] mutableCopy];
    [items insertObject:home atIndex:[[self.webToolBar items] count]];
    [self.webToolBar setItems:items];
    [home release];
    [items release];
}

- (void) goHome{
    NSURL *indexURL = [[NSURL alloc] initWithString:@"http://www.google.com.tw"];
    NSURLRequest *homeRequest = [[NSURLRequest alloc] initWithURL:indexURL];
    [self.webView loadRequest:homeRequest];
    [indexURL release];
    [homeRequest release];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg-pattern.png"]];
    self.webToolBar.tintColor=[UIColor grayColor];
    self.webView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg-pattern.png"]];
    [self addHomeButton];
    [self goHome];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
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
