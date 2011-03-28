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
        self.tableViewController = [[DishDataTableViewController alloc] initWithStyle:UITableViewStylePlain];
        self.segmentArray = [NSArray arrayWithObject:@"Dishes"];//只是先指定
        //[NSArray arrayWithObjects:@"主廚套餐",@"主菜單點",@"特色小吃",@"飲品甜點",nil];
        self.padOrderDelegate = [[UIApplication sharedApplication] delegate];
    }
    return self;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    //self.topTitleLabel.transform = CGAffineTransformMakeRotation(-0.05f);
    //self.navigationController.navigationBar.backgroundColor = bgImage;
    self.bgTopImageView.image = [[UIImage alloc] init];
    
    ////(@"Split:%@",self.navigationController.tabBarController.splitViewController);
    
    self.tableViewController.orderedListViewController = [[self.splitViewController viewControllers] objectAtIndex:0];
    
    [self refreshFetchedResultsControllerWithIndex:0];
    //[self.tableViewController.fetchedResultsController performFetch:nil];
    
    //self.tableViewController.dataDictionary = dictionary;
    
    //將Segment的設定類別實作出來
    self.segmentSetupController = [[padOrderSegmentSetupController alloc] initWithController:self andTableView:self.tableViewController.tableView];
    self.segmentSetupController.fetchedResultsController = self.tableViewController.fetchedResultsController;
    [segmentSetupController segmentControl:segmentControl setTitles:self.segmentArray];
    UIBarButtonItem *itemForToolBar = [[UIBarButtonItem alloc] initWithCustomView:self.segmentControl];
    self.navigationItem.titleView = itemForToolBar.customView;
    //self.navigationItem.rightBarButtonItem = itemForToolBar;    
}


- (void) refreshFetchedResultsControllerWithIndex:(NSInteger)index{
    /*NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Dishes" inManagedObjectContext:self.padOrderDelegate.managedObjectContext]];
    [request setPredicate:[NSPredicate predicateWithFormat:@"Kind.Kind_No=%@",((EntityOrderKind *)[self.segmentArray objectAtIndex:index]).Kind_No]];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"DishSet.Set_Name" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:sort]];
    
    //(@"YES");
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.padOrderDelegate.managedObjectContext sectionNameKeyPath:@"DishSet.Set_Name" cacheName:@"Ref"];
    */
    DishDataModelController *modelController = [[DishDataModelController alloc] init];
    //NSFetchedResultsController *oriFetchedResultsController = self.tableViewController.fetchedResultsController;
    //[oriFetchedResultsController autorelease];
    //(@"dv:%@",self.segmentArray);
    if([self.segmentArray count] > 0) {
        NSError *error;
        NSFetchedResultsController *aFetchedResultsController = [modelController fetchedResultsControllerGroupBySetWhereKindIs:[self.segmentArray objectAtIndex:index]];
        [aFetchedResultsController performFetch:&error];
        self.tableViewController.fetchedResultsController = aFetchedResultsController;
    }
    
   
    ////(@"%@",error);
    //[aFetchedResultsController performFetch:nil];
    
    [self.tableViewController.tableView reloadData];
    ////(@"fet?%@",[aFetchedResultsController fetchedObjects]);
    //[self.dishViewController.tableViewController setFetchedResultsController:aFetchedResultsController];
    //[aFetchedResultsController performFetch:&error];
    //self.dishViewController.tableViewController.fetchedResultsController = aFetchedResultsController;
    //[self.dishViewController.tableViewController.fetchedResultsController performFetch:&error];
    
    //[modelController release];
    //[error release];
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
