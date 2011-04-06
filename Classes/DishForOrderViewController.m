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
#import "DishDataTableViewController.h"
#import "padOrderSegmentSetupController.h"
@implementation DishForOrderViewController

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
        
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
    //self.navigationItem.prompt = @"點餐服務";
    
    DishDataTableViewController *dishDataTableViewController = [[DishDataTableViewController alloc] initWithStyle:UITableViewStylePlain];
    dishDataTableViewController.navigationController = self.navigationController;
    
    self.tableViewController = dishDataTableViewController;
    
    //self.tableView = self.tableViewController.tableView;
    self.tableViewController.tableView = self.tableView;
    self.tableView.dataSource = self.tableViewController;
    self.tableView.delegate = self.tableViewController;
    
    
    self.segmentSetupController = [[padOrderSegmentSetupController alloc] initWithController:self andTableView:self.tableView];
    self.segmentSetupController.fetchedResultsController = self.tableViewController.fetchedResultsController;
    [segmentSetupController segmentControl:segmentControl setTitles:self.segmentArray];
    UIBarButtonItem *itemForToolBar = [[UIBarButtonItem alloc] initWithCustomView:self.segmentControl];
    self.navigationItem.titleView = itemForToolBar.customView;
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
