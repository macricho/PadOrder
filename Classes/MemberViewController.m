    //
//  MemberViewController.m
//  padOrder
//
//  Created by Macric Cho on 2010/9/11.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MemberViewController.h"


@implementation MemberViewController
@synthesize fb;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
        self.fb = [[Facebook alloc] init];
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}


- (IBAction) login:(id)sender{
    NSString *padOrderID = @"172228222789173";
    
    NSArray *permissions =  [NSArray arrayWithObjects:@"read_stream", @"offline_access",nil];
    [self.fb authorize: padOrderID permissions:permissions delegate:self];
    
    //[fb logout:self];
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
