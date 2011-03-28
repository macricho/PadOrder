//
//  OrderedListViewController.m
//  padOrder
//
//  Created by Macric Cho on 2010/9/1.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "OrderedListViewController.h"
#import "OrderedTableViewController.h"
#import "padOrderAppDelegate.h"
#import "padOrderDataManager.h"

#import "DishDataModelController.h"
#import "OrderedDishModelController.h"
#import "OrderedInfoModelController.h"
#import "CustomAlertView.h"

#import "CookingTableViewController.h"

@implementation OrderedListViewController
@synthesize tableView;
@synthesize managedObjectContext;
@synthesize padOrderDataManagerDelegate;
@synthesize clearAllButton;
@synthesize orderedTableViewController;
@synthesize remindedView;
@synthesize totalPriceLabel;
@synthesize totalPrice;
@synthesize submitButton;
@synthesize segmentControl;
@synthesize cookingTableViewController;
@synthesize naviBar;


#pragma mark -
#pragma mark Self-Method

- (NSString *) getApplicationDocumentPath{
    return [[[padOrderAppDelegate alloc] applicationDocumentsDirectory] path];
}

- (CGSize) getContentSizeInPopover{
    return CGSizeMake(320, 700);
}

#pragma mark -
#pragma mark Alert View Delegate

- (void) willPresentAlertView:(UIAlertView *)alertView{
    
}

- (void) didPresentAlertView:(UIAlertView *)alertView{
    
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            [self.orderedTableViewController sendOrderingList];
            [UIView beginAnimations:@"ShowSegement" context:nil];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [UIView setAnimationDuration:1];
            self.segmentControl.alpha = 1;
            [UIView commitAnimations];
            break;
    }
}

- (void) alertViewCancel:(UIAlertView *)alertView{
    
}

#pragma mark -
#pragma mark TableView Controller Delegate

- (id)copy{
    return self;
}


 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
        
    }
    return self;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.frame = CGRectMake(0, 0, 320, 704);
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg-pattern.png"]];
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];

    self.contentSizeForViewInPopover = [self getContentSizeInPopover];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSInteger DESK_NO = [userDefault integerForKey:@"DESK_NO"];
    //self.title = [NSString stringWithFormat:@"第%d桌",DESK_NO];
    
    //self.navigationItem.
    //self.navigationItem.prompt = nil;
    self.title = @"點餐清單";
    //label.font = [UIFont fontWithName:label.font.fontName size:50];
    //[test removeFromSuperview];
    //[self.navigationController.navigationBar addSubview:label];
    //NSLog(@"%@",[self.navigationController.navigationBar.subviews objectAtIndex:1]);
    //UI
    //self.navigationController.navigationBar.translucent = YES;
    
    self.orderedTableViewController = [[OrderedTableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    self.cookingTableViewController = [[CookingTableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    [self.segmentControl addTarget:self action:@selector(switchTableView:) forControlEvents:UIControlEventValueChanged];
    
    [self refreshPriceLabel];
    self.orderedTableViewController.listViewController = self;
    
    self.tableView.dataSource = orderedTableViewController;
    self.tableView.delegate = orderedTableViewController;
    self.tableView.rowHeight = 100;
    [self reloadTableViewSelectToIndexPath:nil usingAnimationTransition:UIViewAnimationTransitionNone usingSelectAnimation:NO];
}

- (void) refreshPriceLabel{
    [self changeSubmitButtonTitle];
    
    [self.orderedTableViewController countOrderedDishTotalPrice];
    self.totalPriceLabel.text = [NSString stringWithFormat:@"合計         NT $%@",orderedTableViewController.totalPrice];
}

- (void) animation:(UIViewAnimationTransition)transition ToSwitch:(UITableView *)aView{
    [UIView beginAnimations:@"SwitchView" context:nil];
    [UIView setAnimationDuration:1.25];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
        //先將目前的表格視圖設為隱藏
    [UIView setAnimationTransition:transition forView:aView cache:YES];
    aView.hidden = YES;
    [UIView commitAnimations];
    
    [self.tableView reloadData];
    
    [UIView beginAnimations:@"SwitchView" context:nil];
    [UIView setAnimationDuration:1.25];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationTransition:transition forView:aView cache:YES];
    aView.hidden = NO;
    [UIView commitAnimations];
    [self reloadTableViewSelectToIndexPath:nil usingAnimationTransition:UIViewAnimationTransitionNone usingSelectAnimation:NO];
}

- (void) switchTableView:(id)sender{
    //分兩部分
    //1. 設定固定的TableView DataSource & Delegate
    //透過指定資料來源來設定同一個TableView要顯示哪些資料
    if ([[[sender class] description] isEqual:@"UISegmentedControl"]) {
        UISegmentedControl *segment = (UISegmentedControl *)sender;
        if (segment.selectedSegmentIndex == 1) {
                //烹飪情況
            self.tableView.tag = 1;
            [self.cookingTableViewController reloadDataSource];
            self.tableView.dataSource = self.cookingTableViewController;
            self.tableView.delegate = self.cookingTableViewController;
            //[self.tableView reloadData];
        }
        else {
            self.tableView.tag = 0;
            self.tableView.dataSource = orderedTableViewController;
            self.tableView.delegate = orderedTableViewController;
        }
        
    }
    else {
        //由此處設定 歷史清單 的資料來源
        //nil 代表沒有資料
        UIBarButtonItem *historyButton = (UIBarButtonItem *)sender;
        self.tableView.dataSource = nil;
        self.tableView.delegate = nil;
        self.tableView.tag = 2;
            //self.navigationItem.rightBarButtonItem = nil;
    }
    //2. 執行動畫
    //執行動畫，判斷資料是否存在，而決定該顯示哪些動畫，和哪些View
    
    [self animation:UIViewAnimationTransitionFlipFromLeft ToSwitch:self.tableView];

}

- (void) switchTableViewToOrding{
    
}

- (BOOL) checkHasFetched{
    BOOL isFetched = YES;
    NSInteger count= [[orderedTableViewController.fetchedResultsController fetchedObjects] count];
    
    UIBarButtonItem *historyButton = [[UIBarButtonItem alloc] initWithTitle:@"點餐記錄" style:UIBarButtonItemStylePlain target:self action:@selector(switchTableView:)];
    self.navigationItem.rightBarButtonItem = historyButton;
    //self.navigationItem.rightBarButtonItem.
    
    [UIView beginAnimations:@"Hidden" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1];
    
    if(count==0){
        isFetched = NO;
        //[UIView set]
        self.totalPriceLabel.alpha = 0;
        self.segmentControl.alpha = 0;
        //self.totalPriceLabel.hidden = YES;
        //self.segmentControl.hidden = YES;
        self.submitButton.enabled = NO;
        self.clearAllButton.enabled = NO;
        //self.clearAllButton.hidden = YES;
        self.navigationItem.rightBarButtonItem.customView.alpha = 1;
        
    }
    else {
        self.navigationItem.rightBarButtonItem = nil;
        self.totalPriceLabel.alpha = 1;
        //self.segmentControl.alpha = 1;
        //self.totalPriceLabel.hidden = NO;
        //self.segmentControl.hidden = NO;
        self.submitButton.enabled = YES;
        self.clearAllButton.enabled = YES;
        //self.clearAllButton.hidden = NO;
    }
    [UIView commitAnimations];

    return isFetched;
}

- (void) changeSubmitButtonTitle{
    NSString *buttonTitle = @"買單結帳";
    if([self.orderedTableViewController.orderedInfoModelController isExistOrderingList]){
        buttonTitle  = @"點餐完畢";
    }
    [self.submitButton setTitle: buttonTitle forState:UIControlStateNormal];
}

- (IBAction) clearAllOrderedDish:(id)sender{
    [self.orderedTableViewController clearAllOrderingDish];
        
}

- (IBAction) billSender:(id)sender{
    if([self.orderedTableViewController.orderedInfoModelController isExistOrderingList]){
        NSMutableString *listString = [NSMutableString stringWithString:@"您已點的清單如下:\n"];
        
        NSInteger dishCount = 1;
        for (EntityOrderedInfo *infoObject in [[self.orderedTableViewController.orderedInfoModelController fetchedDishSelectStatus:0] fetchedObjects]) {
            
            [listString appendFormat:@"%d : %@(%@份)\n",dishCount++,infoObject.Dish.Dish_Name,infoObject.Count];
        }
        
        CustomAlertView *alertView = [[CustomAlertView alloc] initWithTitle:@"是否確定送出烹飪？" message:listString cancelButtonTitle:@"確定" otherButtonTitles:@"取消"];
        alertView.tag = 0;
        [alertView show];
        alertView.delegate = self;
        
    }
    else {
        [self.orderedTableViewController hiddenObject];
        
        UIAlertView *checkAlertView = [[UIAlertView alloc] initWithTitle:@"結帳" message:@"將為您聯絡服務人員，請耐心等候..." delegate:self cancelButtonTitle:@"確定" otherButtonTitles:nil];
        checkAlertView .tag = 1;
        [checkAlertView show];
    }
        //[self checkHasFetched];
}

- (void) reloadTableViewScrollToIndexPath:(NSIndexPath *)indexPath usingAnimationTransition:(UIViewAnimationTransition)transition usingSelectAnimation:(BOOL) boolean{
    
    BOOL isExistOrderingDish = [self checkHasFetched];
    
    NSTimeInterval time = 0.5;
    //動畫一定要分兩部分，不然會不連續
    if(!isExistOrderingDish){
        //前半動畫，處理提醒視圖隱藏時的部份
        //從無到有的部分，動畫固定
        time = 1.25; 
        [UIView beginAnimations:@"SwitchView" context:nil];
        [UIView setAnimationDuration:time];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.remindedView cache:YES];
        
        self.remindedView.hidden = YES;
        
        [UIView commitAnimations];
    }
    
    //後半動畫，處理要顯示的表格
    [UIView beginAnimations:@"SwitchView" context:nil];
    [UIView setAnimationDuration:time];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    //分兩部分，如果是從提醒視圖來的，以向右翻轉作為動畫
    //如果是增減，那就已翻頁的方式為動畫
    //以上面宣告，集指定好的 time 變數，來決定兩種不同動畫顯示時，處理的速度。
    if(!isExistOrderingDish){
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.tableView cache:YES];
        self.tableView.hidden = YES;
        self.remindedView.hidden = NO;
    }
    else {
        [UIView setAnimationTransition:transition forView:self.tableView cache:YES];
        self.tableView.hidden = NO;
        self.remindedView.hidden = YES;
    }
    
    [self.tableView reloadData];
    if(indexPath != nil)[self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:boolean];
    [UIView commitAnimations];
}



- (void) reloadTableViewSelectToIndexPath:(NSIndexPath *)indexPath usingAnimationTransition:(UIViewAnimationTransition)transition usingSelectAnimation:(BOOL) boolean{
    
    BOOL isExistOrderingDish = [self checkHasFetched];

    NSTimeInterval time = 0.5;
        //動畫一定要分兩部分，不然會不連續
    if(!isExistOrderingDish){
            //前半動畫，處理提醒視圖隱藏時的部份
            //從無到有的部分，動畫固定
        time = 1.25; 
        [UIView beginAnimations:@"SwitchView" context:nil];
        [UIView setAnimationDuration:time];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.remindedView cache:YES];
        
        self.remindedView.hidden = YES;
        
        [UIView commitAnimations];
    }

        //後半動畫，處理要顯示的表格
    [UIView beginAnimations:@"SwitchView" context:nil];
    [UIView setAnimationDuration:time];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        //分兩部分，如果是從提醒視圖來的，以向右翻轉作為動畫
        //如果是增減，那就已翻頁的方式為動畫
        //以上面宣告，集指定好的 time 變數，來決定兩種不同動畫顯示時，處理的速度。
    if(!isExistOrderingDish){
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.tableView cache:YES];
        self.tableView.hidden = YES;
        self.remindedView.hidden = NO;
    }
    else {
        [UIView setAnimationTransition:transition forView:self.tableView cache:YES];
        self.tableView.hidden = NO;
        self.remindedView.hidden = YES;
    }
    
    [self.tableView reloadData];
    if(indexPath != nil) [self.tableView selectRowAtIndexPath: indexPath animated:boolean scrollPosition:UITableViewScrollPositionBottom];
    [UIView commitAnimations];
}


- (void)pureReloadTableViewWithAnimation:(BOOL)animation{
    [self reloadTableViewSelectToIndexPath:nil usingAnimationTransition:UIViewAnimationTransitionNone usingSelectAnimation:animation];
}

/*
- (void)loadView{
    //(@"????");
    [super loadView];
}
*/

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
    self.tableView = nil;
}


- (void)dealloc {
    [super dealloc];
    [tableView release];
    [orderedTableViewController release];
}



@end
