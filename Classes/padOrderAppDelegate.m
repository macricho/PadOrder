//
//  padOrderAppDelegate.m
//  padOrder
//
//  Created by Macric Cho on 2010/9/1.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "padOrderAppDelegate.h"
#import "MainFuncViewController.h"
#import "BeginViewController.h"
#import "padOrderSplitControllerDelegate.h"
#import "OrderedInfoModelController.h"
#import "EntityDish.h"
#import "EntityDishSet.h"
#import "EntityDescribe.h"
#import "EntityOrderKind.h"
#import "EntityImage.h"
#import "EntityStatus.h"
#import "OrderKindModelController.h"
#import "padOrderFacebookDelegate.h"
#import "GStepControllerCollection.h"
#import "PORequestFromWebConnectionDeleagte.h"
#import <QuartzCore/QuartzCore.h>

#define DISH_NAME @"東洋香檸雞腿飯"
#define SET_NAME @"異國主廚"

#define DISH_IMG_PATH @"DishImages"

@interface UISplitViewController(N) 

@end

@implementation UISplitViewController(N)

- (void)viewDidLoad{
    [super viewDidLoad];
}

@end


@implementation padOrderAppDelegate
@synthesize window;
@synthesize mainSplitViewController;
@synthesize beginViewController;
@synthesize facebookDelegate;
@synthesize BGNavigationController;
@synthesize guideStepObject;

- (void) setDishKind{
}

- (EntityOrderKind *) selectKindObjectWithSegmentType:(NSInteger)typeNo andSegmentNo:(NSInteger)segmentNo{
    EntityOrderKind *kind = nil;
    OrderKindModelController *kindModelController = [[OrderKindModelController alloc]init];
    kind = [[kindModelController entity:@"Dish_Kind" withPredicate:[NSString stringWithFormat:@"Kind_No=%d",segmentNo]sortBy:@"Kind_No" ascending:YES] objectAtIndex:typeNo];
    return kind;
}

- (void) insertTempData{
    //2010/10/25註記
    //現在要把插入資料的動作簡化
    //也可以做成Method放進ModelController中
    //
    //OrderedDishModelController *orderedDishModelController =  [[OrderedDishModelController alloc] init];
    
    ////(@"managedObjectContext:%@",self.managedObjectContext);
    
    NSEntityDescription *kindEntity = [NSEntityDescription entityForName:@"Dish_Kind" inManagedObjectContext:self.managedObjectContext];
    NSFetchRequest *kindFetch = [[NSFetchRequest alloc] init];
    EntityOrderKind *kind = nil;
    [kindFetch setEntity:kindEntity];
    NSError *ttt = nil;
    if([[self.managedObjectContext executeFetchRequest:kindFetch error:&ttt] count] == 0){
        ////(@"start:%@",[self.managedObjectContext executeFetchRequest:kindFetch error:nil]);
        kind = [[EntityOrderKind alloc] initWithEntity:kindEntity insertIntoManagedObjectContext:self.managedObjectContext];
        kind.Kind_No = [NSNumber numberWithInt:0];
        kind.Segment_Type = [NSNumber numberWithInt:1]; // 1代表是主要的點餐界面
        kind.Kind_Name = @"主廚特餐";
        [self.managedObjectContext save:nil];
        
        kind = [[EntityOrderKind alloc] initWithEntity:kindEntity insertIntoManagedObjectContext:self.managedObjectContext];
        kind.Kind_No = [NSNumber numberWithInt:1];
        kind.Segment_Type = [NSNumber numberWithInt:1]; // 1代表是主要的點餐界面
        kind.Will_Show = [NSNumber numberWithBool:YES];
        kind.Kind_Name = @"主菜單點";
        [self.managedObjectContext save:nil];
        
        kind = [[EntityOrderKind alloc] initWithEntity:kindEntity insertIntoManagedObjectContext:self.managedObjectContext];
        kind.Kind_No = [NSNumber numberWithInt:2];
        kind.Segment_Type = [NSNumber numberWithInt:1]; // 1代表是主要的點餐界面
        kind.Will_Show = [NSNumber numberWithBool:YES];
        kind.Kind_Name = @"特色小吃";
        [self.managedObjectContext save:nil];
        
        kind = [[EntityOrderKind alloc] initWithEntity:kindEntity insertIntoManagedObjectContext:self.managedObjectContext];
        kind.Kind_No = [NSNumber numberWithInt:3];
        kind.Segment_Type = [NSNumber numberWithInt:1]; // 1代表是主要的點餐界面
        kind.Will_Show = [NSNumber numberWithBool:YES];
        kind.Kind_Name = @"飲品甜點";
        [self.managedObjectContext save:nil];
        
        /**********************************************************************/
        
        kind = [[EntityOrderKind alloc] initWithEntity:kindEntity insertIntoManagedObjectContext:self.managedObjectContext];
        kind.Kind_No = [NSNumber numberWithInt:0];
        kind.Segment_Type = [NSNumber numberWithInt:2]; // 2代表是人氣排行
        kind.Will_Show = [NSNumber numberWithBool:YES];
        kind.Kind_Name = @"主廚推薦";
        [self.managedObjectContext save:nil];
        
        kind = [[EntityOrderKind alloc] initWithEntity:kindEntity insertIntoManagedObjectContext:self.managedObjectContext];
        kind.Kind_No = [NSNumber numberWithInt:1];
        kind.Segment_Type = [NSNumber numberWithInt:2]; // 2代表是人氣排行
        kind.Will_Show = [NSNumber numberWithBool:YES];
        kind.Kind_Name = @"當月排行";
        [self.managedObjectContext save:nil];
        
        kind = [[EntityOrderKind alloc] initWithEntity:kindEntity insertIntoManagedObjectContext:self.managedObjectContext];
        kind.Kind_No = [NSNumber numberWithInt:2];
        kind.Segment_Type = [NSNumber numberWithInt:2]; // 2代表是人氣排行
        kind.Will_Show = [NSNumber numberWithBool:YES];
        kind.Kind_Name = @"本週排行";
        [self.managedObjectContext save:nil];
    }
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Dishes" inManagedObjectContext:self.managedObjectContext];
    
    NSEntityDescription *setEntity = [NSEntityDescription entityForName:@"Dishes_Set" inManagedObjectContext:self.managedObjectContext];

    NSEntityDescription *describeEntity = [NSEntityDescription entityForName:@"Dishes_Describe" inManagedObjectContext:self.managedObjectContext];
    
    NSEntityDescription *imageEntity = [NSEntityDescription entityForName:@"Dishes_Images" inManagedObjectContext:self.managedObjectContext];
    
    EntityDishSet *set = [[EntityDishSet alloc] initWithEntity:setEntity insertIntoManagedObjectContext:self.managedObjectContext];

    set.Set_Name = SET_NAME;
    set.Set_Note = @"濃濃的異國風情，是許多人嚮往的世界。異國主廚系列將帶領著您，品嚐各個不同角落的特色風味，讓您不用出遠門，也能環遊世界喔！\n經典代表：\n東洋香檸雞腿飯";
    
    
    EntityDescribe *describe = [[EntityDescribe alloc] initWithEntity:describeEntity insertIntoManagedObjectContext:self.managedObjectContext];
    
    describe.Describe_Complete = @"多汁鮮嫩的雞腿排先以多種香料醃製入味，散發著清新檸檬香氣，可以充分品嚐雞腿肉的鮮美滋味又不覺得油膩，是一道相當受歡迎的簡餐。";
    
    describe.Describe_Simple = @"多汁鮮嫩的雞腿排先以多種香料醃製入味，散發著清新檸檬香氣，可以充分品嚐雞腿肉的鮮美滋味又不覺得油膩，是一道相當受歡迎的簡餐。";
    
    [self.managedObjectContext save:nil];
    
    //2010/10/29 現在要想辦法取出Kind物件，使用OrderKindModelController
    
    //[self setDishKind];
    
    NSEntityDescription *statusEntity = [NSEntityDescription entityForName:@"Status" inManagedObjectContext:self.managedObjectContext];
    NSFetchRequest *statusFetch = [[NSFetchRequest alloc] init];
    EntityStatus *status = nil;
    [statusFetch setEntity:statusEntity];
    
    if ([[self.managedObjectContext executeFetchRequest:statusFetch error:nil] count] ==0) {
        
        status = [[EntityStatus alloc] initWithEntity:statusEntity insertIntoManagedObjectContext:self.managedObjectContext];
        status.Status_No = [NSNumber numberWithInt:0];
        status.Status_Name = @"還在點餐的清單";
        [self.managedObjectContext save:nil];
        
        status = [[EntityStatus alloc] initWithEntity:statusEntity insertIntoManagedObjectContext:self.managedObjectContext];
        status.Status_No = [NSNumber numberWithInt:1];
        status.Status_Name = @"尚未買單的清單";
        [self.managedObjectContext save:nil];
        
        status = [[EntityStatus alloc] initWithEntity:statusEntity insertIntoManagedObjectContext:self.managedObjectContext];
        status.Status_No = [NSNumber numberWithInt:2];
        status.Status_Name = @"烹煮中";
        [self.managedObjectContext save:nil];
    }
    
    /************************************************************************************/
    
    NSInteger timeNo = (int)[[NSDate date] timeIntervalSince1970];
    NSInteger type = 0;
    NSInteger div = 4;
    NSInteger no = timeNo%div;
    
    kind = [self selectKindObjectWithSegmentType:type andSegmentNo:no];
    
    EntityDish *dish = [[EntityDish alloc] initWithEntity:entity insertIntoManagedObjectContext:self.managedObjectContext];
    
    EntityImage *image = [[EntityImage alloc] initWithEntity:imageEntity insertIntoManagedObjectContext:self.managedObjectContext];
    image.Image_Path = DISH_IMG_PATH;
    image.Image_FileName = @"6.png";
    image.IsMainImage = [NSNumber numberWithBool:YES];
    image.Dish = dish;
    [self.managedObjectContext save:nil];
    
    image = [[EntityImage alloc] initWithEntity:imageEntity insertIntoManagedObjectContext:self.managedObjectContext];
    image.Image_Path = DISH_IMG_PATH;
    image.Image_FileName = @"7.png";
    image.IsMainImage = [NSNumber numberWithBool:NO];
    image.Dish = dish;
    [self.managedObjectContext save:nil];
    
    image = [[EntityImage alloc] initWithEntity:imageEntity insertIntoManagedObjectContext:self.managedObjectContext];
    image.Image_Path = DISH_IMG_PATH;
    image.Image_FileName = @"8.png";
    image.IsMainImage = [NSNumber numberWithBool:NO];
    image.Dish = dish;
    [self.managedObjectContext save:nil];
    
    //EntityImage *image = [[kindModelController entity:@"Dishes_Images" withPredicate:@"IsMainImage = YES" sortBy:@"IsMainImage" ascending:YES] objectAtIndex:0];
    //dish.Images = image;
    dish.Describe = describe;
    dish.DishSet = set;
    dish.Dish_No = [NSString stringWithFormat:@"%d",timeNo];//@"0";
    dish.Dish_Name = DISH_NAME;
    //[[[NSDate date] description] substringWithRange:NSMakeRange(0, 5)];//@"天廚奇譚";
    dish.Kind = kind;
    dish.Dish_Price = [NSNumber numberWithInt:149];
    dish.Update_Date = [NSDate date];
    image.Dish = dish;
    describe.Dish = dish;
    [self.managedObjectContext save:nil];
    
    
    //[self.managedObjectContext detectConflictsForObject:dish];
    
    // dish = [(EntityOrderedDish *)[test objectAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]] Ordered_Dish];
    //[orderedDishModelController insertBeOrderedDish:dish];
    //[orderedInfoModelController insertBeOrderedDish:dish];
    //[padOrderDataManagerDelegate insertNewObjectWithDictionary:nil];
}


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    [self insertTempData];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:7 forKey:@"DESK_NO"];
    NSLog(@"%d",[defaults synchronize]);
    //[defaults setObject:[UIColor grayColor] forKey:@"BarColor"];

    ////(@"%@",[])
    // Override point for customization after application launch.
    //self.facebook = [[Facebook alloc] init];
    mainSplitViewController.delegate = [[padOrderSplitControllerDelegate alloc] init];
    mainSplitViewController.navigationController.navigationBar.tintColor = [UIColor grayColor];
    
    self.beginViewController = [[BeginViewController alloc] initWithNibName:@"BeginView" bundle:nil];
    self.BGNavigationController = [[UINavigationController alloc] initWithRootViewController:self.beginViewController];
    self.window.rootViewController = mainSplitViewController;
    self.window.rootViewController = self.BGNavigationController;
    
    self.guideStepObject = [[GStepControllerCollection alloc] init];
    
    NSFileManager *filemanager = [NSFileManager defaultManager];
    NSString *dishImageDocumentPath = [[[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"DishImages"] path];
    BOOL isExistImagePath = [filemanager fileExistsAtPath:dishImageDocumentPath];
    
    if(!isExistImagePath) [filemanager createDirectoryAtPath:dishImageDocumentPath attributes:nil];

    [window makeKeyAndVisible];
    
    return YES;
}

- (void) backToIndexView:(id)sender{
    //[[[UIAlertView alloc] initWithTitle:@"Title" message:@"Message" delegate:nil 
    ////(@"back!!!");
    //(@"%@",[[sender class] description]);
    if ([[[sender class] description] isEqualToString:@"NSCFNumber"]) {
        NSNumber *indexNumber = (NSNumber *)sender;
        
        self.beginViewController.tabBarIndex = [indexNumber intValue];
    }
    self.window.rootViewController = self.BGNavigationController;
    [self windowPageTransitionAnimation:1];
    //[[UIApplication sharedApplication] setStatusBarOrientation:<#(UIInterfaceOrientation)#>]
}

- (IBAction) actionToNext:(id)sender{
    UIButton *touchButton = (UIButton *)sender;
    NSArray *viewControllers = nil;
    MainFuncViewController *mainFcuncViewController = nil;
    UITabBarController *tabBarController = nil; 
    
    switch (touchButton.tag) {
        case 0:
            [((UINavigationController *)self.window.rootViewController) pushViewController:[self.guideStepObject nextViewController] animated:YES];
            break;
        case 1:

            viewControllers = [self.mainSplitViewController viewControllers];
            mainFcuncViewController = [viewControllers lastObject];
            tabBarController = mainFcuncViewController.funcsTabBarController;

            //延續一開始tabBarController的設定畫面為0
            //這裡就可以在顯示之前點選1的畫面
            //就可以避開Navi的Bar往下掉的問題了！
            //[tabBarController loadView];
            //(@"%d",beginViewController.tabBarIndex);
            tabBarController.selectedViewController = [[tabBarController viewControllers] objectAtIndex:beginViewController.tabBarIndex];

            self.window.rootViewController = self.mainSplitViewController;
            //[[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:YES];
            
            [self windowPageTransitionAnimation:0];
            
            break;
        case 2:
            break;
        case 3:
            break;
        case 4:
            break;
    }

}

- (void) windowPageTransitionAnimation:(NSInteger)type{
        
    
    UIView *show = [[UIView alloc] initWithFrame:CGRectMake(256, 192, 512, 384)];
    show.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];
    NSInteger alpha = 0;
    show.alpha = alpha;
    show.layer.cornerRadius = 70;
    show.layer.masksToBounds = YES;
    
    
    [self.window.rootViewController.view addSubview:show];
    
    [UIView beginAnimations:@"RemindShow" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDelay:1.26];
    [UIView setAnimationDuration:1];
    
    [UIView beginAnimations:@"SwitchView" context:nil];
    [UIView setAnimationDuration:1.25];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    switch (type) {
        case 0:
            [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.window cache:YES];
            alpha = 1;
            break;
        case 1:
            [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.window cache:YES];
            alpha = 0;
            break;
    }
    
    [UIView commitAnimations]; 
    
    show.alpha = alpha;
    
    [UIView beginAnimations:@"RemindShow2" context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDelay:1.26];
    [UIView setAnimationDuration:1];
    show.alpha = 0;
    [UIView commitAnimations];
    [UIView commitAnimations];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


/**
 applicationWillTerminate: saves changes in the application's managed object context before the application terminates.
 */
- (void)applicationWillTerminate:(UIApplication *)application {
    NSError *error = nil;
    if (managedObjectContext_ != nil) {
        if ([managedObjectContext_ hasChanges] && ![managedObjectContext_ save:&error]) {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            //(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}


#pragma mark -
#pragma mark Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext {
    
    if (managedObjectContext_ != nil) {
        return managedObjectContext_;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext_ = [[NSManagedObjectContext alloc] init];
        [managedObjectContext_ setPersistentStoreCoordinator:coordinator];
    }
    return managedObjectContext_;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel {
    
    if (managedObjectModel_ != nil) {
        return managedObjectModel_;
    }
    NSString *modelPath = [[NSBundle mainBundle] pathForResource:@"padOrder" ofType:@"momd"];
    NSURL *modelURL = [NSURL fileURLWithPath:modelPath];
    managedObjectModel_ = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];    
    return managedObjectModel_;
}


/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    if (persistentStoreCoordinator_ != nil) {
        return persistentStoreCoordinator_;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"padOrder.sqlite"];
    
    NSError *error = nil;
    persistentStoreCoordinator_ = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![persistentStoreCoordinator_ addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        //(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return persistentStoreCoordinator_;
}


#pragma mark -
#pragma mark Application's Documents directory

/**
 Returns the path to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


- (NSString *) imagePathDocumentsDirectory{
    return [[self applicationDocumentsDirectory] stringByAppendingPathComponent:@"DishImages"];
}


- (BOOL) application:(UIApplication *)application handleOpenURL:(NSURL *)url{
	[[PORequestFromWebConnectionDeleagte alloc] initWitURL:url];
    return YES;
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
    
    [mainSplitViewController release];
    
    [managedObjectContext_ release];
    [managedObjectModel_ release];
    [persistentStoreCoordinator_ release];
    
    [window release];
    [super dealloc];
}


@end

