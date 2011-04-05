    //
//  MainFuncViewController.m
//  padOrder
//
//  Created by Macric Cho on 2010/9/1.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MainFuncViewController.h"
#import "NewsViewController.h"
#import "DishViewController.h"
#import "MemberViewController.h"
#import "padOrderTabBarControllerDelegate.h"
#import "padOrderSplitControllerDelegate.h"
#import "DishForRankViewController.h"
#import "DishForOrderViewController.h"

@implementation MainFuncViewController
@synthesize funcsTabBarController;
@synthesize managedObjectContext;


#pragma mark -
#pragma mark 自定方法

- (NSArray *) createTabBarArray{
    newsViewController = [[NewsViewController alloc] initWithNibName:@"NewsView" bundle:[NSBundle mainBundle]];
    dishViewController = [[DishForOrderViewController alloc] initWithNibName:@"DishView" bundle:[NSBundle mainBundle]];
    rankViewController = [[DishForRankViewController alloc] initWithNibName:@"DishView" bundle:[NSBundle mainBundle]];
    memberViewController = [[MemberViewController alloc] initWithNibName:@"MemberView" bundle:[NSBundle mainBundle]];
    
    UINavigationController *starterView = [self convertViewController: [[UIViewController alloc] init] WithTitle:@"回首頁"];
    
    UINavigationController *dishNavController = [self convertViewController:dishViewController WithTitle:@"點餐服務"];
    UINavigationController *rankNavController = [self convertViewController:rankViewController WithTitle:@"人氣排行"];
    UINavigationController *callService = [self convertViewController: [[UIViewController alloc] init] WithTitle:@"使用服務鈴"];
    UINavigationController *memberNavController = [self convertViewController:memberViewController WithTitle:@"會員專區"];
    
    dishNavController.delegate = self;
    rankNavController.delegate = self;
    memberNavController.delegate = self;
    
    
    //dishNavController.navigationBar.delegate = self;
    //rankNavController.navigationBar.delegate = self;
    //memberNavController.navigationBar.delegate = self;
    
    starterView.view.tag = 0;
    dishNavController.view.tag = 1;
    rankNavController.view.tag = 2;
    callService.view.tag = 3;
    memberNavController.view.tag = 4;
    
        //NSArray *resultArray = [NSArray arrayWithObjects:newsNavController,
        //                  dishNavController,                                                                                    
        //                  rankNavController,                                                                                    
        //                  callService,                                                                                    
        //                  memberNavController,                                                                                    
        //                  nil];
    NSArray *resultArray = [NSArray arrayWithObjects:
                            starterView,
                            dishNavController,                                                                                    
                            rankNavController,                                                                                    
                            callService, 
                            memberNavController,
                            nil];
    
    return resultArray;
}

- (void) configureTabBarItem{
    NSInteger index = 0;
    
    for (UITabBarItem *item in self.funcsTabBarController.tabBar.items) {
        //item = [item initWithTitle:item.title image:[NSString stringWithFormat:@"tabBarItem%d.png",index] tag:index];
        item.image = [UIImage imageNamed:[NSString stringWithFormat:@"tabBarItem%d.png",index]];
        index ++;
    }
}

- (UINavigationController *) convertViewController:(UIViewController *)rootController WithTitle:(NSString *)viewTitle{
    rootController.title = viewTitle;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:rootController];
    navController.delegate = self;
    navController.navigationBar.tintColor = [UIColor grayColor];
    return navController;
}

#pragma mark -
#pragma mark UINavigationController Delegate

- (void) navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    UIDevice *currentDevice = [UIDevice currentDevice];
    BOOL isSingleLevel = ([navigationController.viewControllers count] == 1);
    
    UIDeviceOrientation orientation = [currentDevice orientation];
    if (orientation == UIDeviceOrientationUnknown) {
        orientation = UIDeviceOrientationLandscapeLeft;
    }
    BOOL isLandscape = (orientation == UIInterfaceOrientationLandscapeLeft) || (orientation == UIInterfaceOrientationLandscapeRight);
    
    
    if (isSingleLevel ) {
        
        if (isLandscape) {
            viewController.navigationItem.leftBarButtonItem = nil;
        }
        else{
            viewController.navigationItem.rightBarButtonItem = viewController.navigationItem.leftBarButtonItem;
            viewController.navigationItem.leftBarButtonItem = nil;
        }
    }
    
}


- (void) navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
}

#pragma mark -
#pragma mark UINavigationBar Delegate

- (void)navigationBar:(UINavigationBar *)navigationBar didPopItem:(UINavigationItem *)item{
    //(@"pop");
}

- (void)navigationBar:(UINavigationBar *)navigationBar didPushItem:(UINavigationItem *)item{
    //(@"push");
}

#pragma mark -
#pragma mark UIViewController 

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
   [super viewDidLoad];
    //NSLog(@"View Did Load");
    //self.funcsTabBarController.tabBar.frame = CGRectMake(0, 0, 200, 200);
    
    UITabBarItem *item1 = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemContacts tag:5];
        //UITabBarItem *item2 = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemContacts tag:1];
        //UITabBarItem *item3 = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemContacts tag:2];
        //self.funcsTabBarController.tabBar.items = [NSArray arrayWithObjects:item1,item2,item3,nil];
    self.funcsTabBarController.viewControllers = [self createTabBarArray];

    //這裡要設定第一個要被顯示的初始畫面
    UINavigationController *setupFirstNavController = [self.funcsTabBarController.viewControllers objectAtIndex:1];
    
     //指定tabBarController的委派物件
    padOrderTabBarControllerDelegate *tabBarDelegate = [[padOrderTabBarControllerDelegate alloc] init];
    tabBarDelegate.mainViewController = self;//指定過去
    tabBarDelegate.beforeNavController = setupFirstNavController;
    tabBarDelegate.splitControllerDelegate = (padOrderSplitControllerDelegate *)self.splitViewController.delegate;
//    tabBarDelegate.splitPopoverButton = (UINavigationItem *)setupFirstNavController.topViewController.navigationItem.leftBarButtonItem;
    
    //透過Delegate才可以讓後續的AlertVew設定不會出現問題
    [tabBarDelegate tabBarController:funcsTabBarController 
                                  didSelectViewController:setupFirstNavController];
    
    self.funcsTabBarController.delegate = tabBarDelegate;
    
    [self setView: self.funcsTabBarController.view];
    [self configureTabBarItem];
    [setupFirstNavController release];
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    
    padOrderTabBarControllerDelegate *delegate =  (padOrderTabBarControllerDelegate *)self.funcsTabBarController.delegate;
    BOOL canRotate = YES;
    if(delegate.actionSheet.visible) canRotate = NO;
    //else return YES;
    return canRotate;
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
    //@synthesize funcsTabBarController;
    //@synthesize managedObjectContext;
    self.funcsTabBarController = nil;
    //NSLog(@"????");

}

- (void)dealloc {
    [super dealloc];
}


@end
