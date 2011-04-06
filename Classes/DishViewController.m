    //
//  DishViewController.m
//  padOrder
//
//  Created by Macric Cho on 2010/9/8.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DishViewController.h"
#import "DishDataTableViewController.h"
#import "DishDataTableView.h"
#import "padOrderSegmentSetupController.h"
#import "DishDataModelController.h"
#import "padOrderAppDelegate.h"
#import "DishForOrderViewController.h"
#import "DishForRankViewController.h"

#import "EntityOrderKind.h"

@implementation DishViewController
@synthesize segmentControl;
@synthesize tableView;
@synthesize tableViewController;
@synthesize segmentSetupController;
@synthesize bgTopImageView;
@synthesize segmentArray;

//@synthesize topTitleLabel;

#pragma mark -
#pragma mark View Controller

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
        
        //if([[[self class] description] isEqualToString:@"DishForOrderViewController"]){
        //}
        self.segmentArray = [NSArray arrayWithObject:@"Dishes"];//只是先指定
        //[NSArray arrayWithObjects:@"主廚套餐",@"主菜單點",@"特色小吃",@"飲品甜點",nil];
        self.padOrderDelegate = (padOrderAppDelegate *)[[UIApplication sharedApplication] delegate];
        
    }
    return self;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.tableView.dataSource = self.tableViewController;
    //self.tableView.delegate = self.tableViewController;
    self.tableView.allowsSelection = NO;
    
    self.tableViewController.orderedListViewController = [[self.splitViewController viewControllers] objectAtIndex:0];
    
    [self refreshFetchedResultsControllerWithIndex:0];
    
    //將Segment的設定類別實作出來
    /*self.segmentSetupController = [[padOrderSegmentSetupController alloc] initWithController:self andTableView:self.tableView];
    self.segmentSetupController.fetchedResultsController = self.tableViewController.fetchedResultsController;
    [segmentSetupController segmentControl:segmentControl setTitles:self.segmentArray];
    UIBarButtonItem *itemForToolBar = [[UIBarButtonItem alloc] initWithCustomView:self.segmentControl];
    self.navigationItem.titleView = itemForToolBar.customView;
     */
  
}


- (void) refreshFetchedResultsControllerWithIndex:(NSInteger)index{

    DishDataModelController *modelController = [[DishDataModelController alloc] init];

    if([self.segmentArray count] > 0) {
        NSError *error;
        NSFetchedResultsController *aFetchedResultsController = [modelController fetchedResultsControllerGroupBySetWhereKindIs:[self.segmentArray objectAtIndex:index]];
        [aFetchedResultsController performFetch:&error];
        self.tableViewController.fetchedResultsController = aFetchedResultsController;
    }
    
    [self.tableView reloadData];
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
