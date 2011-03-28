    //
//  DishForOrderViewController.m
//  padOrder
//
//  Created by Macric Cho on 2010/10/28.
//  Copyright 2010 Macricho. All rights reserved.
//

#import "DishForOrderViewController.h"
#import "EntityOrderKind.h"
#import "OrderKindModelController.h"

@implementation DishForOrderViewController

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
                ////(@"Array:%@",array);
        NSArray *array = [[[OrderKindModelController alloc] init] segmentTitleArrayWithTypeNo:[NSNumber numberWithInt:1]];
        
        self.segmentArray = array;//array;//[NSArray arrayWithObjects:@"主廚套餐",@"主菜單點",@"特色小吃",@"飲品甜點",nil];
        //(@"dvo:%@",self.segmentArray);
    }
    return self;
}


/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    self.topTitleLabel.text = @"Menu";
    self.navigationItem.prompt = @"點餐服務";
    //self.topTitleLabel.font = [UIFont fontWithName:@"Zapfino" size:50];
    self.bgTopImageView.image = [UIImage imageNamed:@"tableViewBgTopMenu.png"];
    //self.tableViewController.navigationController = self.navigationController;
    [self.tableViewController setNavigationController:self.navigationController];
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