    //
//  DishForRankViewController.m
//  padOrder
//
//  Created by Macric Cho on 2010/10/28.
//  Copyright 2010 Macricho. All rights reserved.
//

#import "DishForRankViewController.h"
#import "EntityOrderKind.h"
#import "OrderKindModelController.h"
#import "RankDataTableViewController.h"

@implementation DishForRankViewController


 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
        
        //DishDataTableViewController *dishDataTableViewController = [[DishDataTableViewController alloc] initWithStyle:UITableViewStylePlain];
        
        RankDataTableViewController *rankDataTableViewcontroller = [[RankDataTableViewController alloc] initWithStyle:UITableViewStylePlain];
        
        self.tableViewController =  rankDataTableViewcontroller;

        
        NSArray *array = [[[OrderKindModelController alloc] init] segmentTitleArrayWithTypeNo:[NSNumber numberWithInt:2]];
        self.segmentArray = array;
        //self.segmentArray = [NSArray arrayWithObjects:@"主廚推薦",@"本週排行",@"本月排行",nil];
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
    self.topTitleLabel.text = @"Ranking";
    self.navigationItem.prompt = @"人氣排行";
    //self.bgTopImageView.image = [UIImage imageNamed:@"tableViewBgTopRank.png"];
    //[self.tableViewController setNavigationController:self.navigationController];
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
