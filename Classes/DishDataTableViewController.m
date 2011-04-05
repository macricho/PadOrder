//
//  DishTableViewController.m
//  padOrder
//
//  Created by Macric Cho on 2010/9/19.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DishDataTableViewController.h"
#import "DishTableCellView.h"
#import "DishDataTableView.h"
#import "EntityDish.h"
#import "EntityOrderedInfo.h"
#import "EntityDishSet.h"
#import "EntityDescribe.h"
#import "EntityImage.h"
#import "padOrderAppDelegate.h"
#import "padOrderAlertViewDelegate.h"
#import "OrderedInfoModelController.h"
#import "OrderedListViewController.h"
#import "OrderedTableViewController.h"
#import "DishDetailViewController.h"
#import "VarsButton.h"
#import "MoveAnimationController.h"
#import "padOrderSearchBarDelegate.h"
#import "VarsBarButtomItem.h"
#import "CustomAlertView.h"
#import "SetInfomationViewController.h"
#import "DishForOrderViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation DishDataTableViewController
@synthesize dataDictionary;
@synthesize tableCellView;
@synthesize fetchedResultsController;
@synthesize orderedListViewController;
@synthesize navigationController;
@synthesize appDelegate;
@synthesize moveAnimationController;
@synthesize onSearch;
@synthesize popoverController;
@synthesize setInfoViewController;
@synthesize dishMenuViewController;
@synthesize detailViewController;
@synthesize dishCountTextField;
@synthesize adderButton;

#pragma mark -
#pragma mark Initialization


- (void) testAlert:(NSString *)message{
    [[[UIAlertView alloc] initWithTitle:@"Title" message:[NSString stringWithFormat:@"Message:%@",message] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    //NSLog(@"%d",buttonIndex);
    NSInteger orderCount = 1;
    switch (buttonIndex) {
        case 1:
            orderCount = 2;
            break;
        case 2:
            orderCount = 3;
            break;
        case 3:
            orderCount = 5;
            break;
        case 4:
            orderCount = -1;
            break;
        default:
            orderCount = 1;
            break;
    }
    if (self.orderedListViewController.tableView.tag != 0) {
        //如果已點清單的區域顯示的是清單以外的部份，如：烹飪情況的清單，就要拉回原來的清單在加以點選
        self.orderedListViewController.segmentControl.selectedSegmentIndex = 0;
        [self.orderedListViewController switchTableView:self.orderedListViewController.segmentControl];
    }
    
    DishTableCellView *cell = nil;
    UIImageView *dishImageView = nil;
    CGRect startFrame;
    CGRect endFrame;
    CGRect topRectToVisible;
    
    cell = (DishTableCellView *)[self.tableView cellForRowAtIndexPath:self.adderButton.indexPath];
    
    UIColor *cellMoveBeginBgColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tableViewBgPattern.png"]];
    self.orderedListViewController = [[[[self.appDelegate mainSplitViewController].viewControllers objectAtIndex:0] viewControllers] objectAtIndex:0];
    
    OrderedInfoModelController *orderedInfoModelController =  [[OrderedInfoModelController alloc] init];
    
    EntityDish *dish = (EntityDish *)self.adderButton.managerObject;
    
    UIImage *dishImage = cell.dishImageView.image;
    if(cell.isExistDishImage){
         dishImage = [UIImage imageWithContentsOfFile:[[dish getURLForMainImageFullPath] path]];
        dishImage = [self cuttingPictureForCellFormat:dishImage];
    }
    
    dishImageView = [[UIImageView alloc] initWithImage:dishImage];
    //dishImageView.backgroundColor = [UIColor clearColor];
    BOOL alreadyVisible = [orderedInfoModelController isExistWithDish:dish];
    
    //插入點菜的餐點到已點的餐點列表
    for (NSInteger i=0; i<orderCount && i > -1; i++) {
        [orderedInfoModelController insertBeOrderedDish:dish];
    }
    
    
    EntityOrderedInfo *orderedInfo = [orderedInfoModelController orderedInfoFetchedWithDish:dish withStatus:0];
    
    //NSLog(@"%@",orderedInfo);
    
    OrderedTableViewController *orderedTableViewController = self.orderedListViewController.orderedTableViewController;
    //先顯示翻轉動畫
    [orderedListViewController reloadTableViewSelectToIndexPath:nil
                                       usingAnimationTransition:UIViewAnimationTransitionNone usingSelectAnimation:YES];
    NSIndexPath *selectedIndexPath = [orderedTableViewController indexPathAndRefreshWithEntity:orderedInfo];
    //[orderedListViewController.tableView reloadData];
    //[orderedListViewController.tableView scrollToRowAtIndexPath:selectedIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        
    [orderedListViewController reloadTableViewScrollToIndexPath:selectedIndexPath usingAnimationTransition:UIViewAnimationTransitionNone usingSelectAnimation:NO];
    
    UITableViewCell *orderedCell = [self.orderedListViewController.tableView cellForRowAtIndexPath:selectedIndexPath];
    
    if(!alreadyVisible) orderedCell.hidden = YES;
    
    if (self.adderButton.isDetail) {
        dishImageView = [[UIImageView alloc] initWithImage:self.detailViewController.dishImageView.image];
        
        //先換算座標系統到window的座標上
        startFrame = [self.moveAnimationController relativeToAbsolute:self.detailViewController.dishImageView];


    }
    else{
        
        //找出該cell在整個window 的絕對位置
        topRectToVisible = self.tableView.layer.visibleRect; //可以抓到tableView"出現"的左上角的點座標大小
        
        if(self.onSearch) {
            topRectToVisible = self.searchDisplayController.searchResultsTableView.layer.visibleRect;
            cell = (DishTableCellView *)[self.searchDisplayController.searchResultsTableView cellForRowAtIndexPath:self.adderButton.indexPath];
            cellMoveBeginBgColor  = [UIColor whiteColor];
        }

        
        //先換算座標系統到window的座標上
        startFrame = [self.moveAnimationController relativeToAbsolute:cell.dishImageView];
        //透過顯示的點座標，取得目前Cell的座標位置

        startFrame = CGRectMake(startFrame.origin.x,  startFrame.origin.y - topRectToVisible.origin.y, cell.dishImageView.frame.size.width, cell.dishImageView.frame.size.height);
        
    }
    
    endFrame = CGRectZero;
    //self.navigationController.hidesBottomBarWhenPushed = YES;
    
    switch([[UIApplication sharedApplication] statusBarOrientation]){
        case UIDeviceOrientationLandscapeRight:
        case UIDeviceOrientationLandscapeLeft: 
            endFrame = [self.moveAnimationController relativeToAbsolute:orderedCell.imageView];
            break;
    }
    
    topRectToVisible = self.orderedListViewController.tableView.layer.visibleRect;
    
    endFrame = CGRectMake(endFrame.origin.x, endFrame.origin.y - topRectToVisible.origin.y, endFrame.size.width, endFrame.size.height);
    
    self.moveAnimationController.beAnimation = dishImageView;
    self.moveAnimationController.startFrame = startFrame;
    self.moveAnimationController.endFrame = endFrame;
    self.moveAnimationController.startBgColor = cellMoveBeginBgColor;
    self.moveAnimationController.endAlpha = 0;
    [self.moveAnimationController action];
    
    //cell.submitButton.hidden = NO;
    //if(cell.accessoryType) cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    [self performSelector:@selector(reloadTableViewAfterAnimationWithIndexPath:) withObject:selectedIndexPath afterDelay:0.85];

}

//點選加點時會做的事情

- (void) buttonDetail:(id)sender{
    VarsButton *button = (VarsButton *)sender;
    [self tableView:self.tableView accessoryButtonTappedForRowWithIndexPath:button.indexPath];
}

- (void) buttonAction:(id)sender{
    CGRect topRectToVisible = CGRectZero;
    CGRect startFrame = CGRectZero;
    CGRect actionSheetFrame = CGRectZero;
    
    
    VarsButton *button = (VarsButton *)sender;
    self.adderButton = button;
    
    UIActionSheet *orderSelect = [[UIActionSheet alloc] initWithTitle:@"請選擇餐點份數" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"1份",@"2份",@"3份",@"5份",@"其他/自定", nil];
    
    if (!button.isDetail){
        //如果不是介紹頁面
        //就在Cell的地方顯示選單
        //找出所屬的Cell 以便製作快照    
        DishTableCellView *cell = (DishTableCellView *)[self.tableView cellForRowAtIndexPath:button.indexPath];
        //找出該cell在整個window 的絕對位置
        topRectToVisible = self.tableView.layer.visibleRect; //可以抓到tableView"出現"的左上角的點座標大小
        
        if(self.onSearch) {
            topRectToVisible = self.searchDisplayController.searchResultsTableView.layer.visibleRect;
            cell = (DishTableCellView *)[self.searchDisplayController.searchResultsTableView cellForRowAtIndexPath:button.indexPath];
        }
        
        //先換算座標系統到window的座標上
        
        actionSheetFrame = [self.moveAnimationController relativeToAbsolute:cell.submitButton];
        
        CGPoint actionSheetOrigin = actionSheetFrame.origin;
        CGSize actionSheetSize = actionSheetFrame.size;
        
        actionSheetFrame = CGRectMake(actionSheetOrigin.x, actionSheetOrigin.y-topRectToVisible.origin.y + actionSheetSize.height, 0, 0);
    }
    else{
        [self.detailViewController.contentScrollView scrollRectToVisible:self.detailViewController.addButton.frame animated:NO];
        topRectToVisible = self.detailViewController.contentScrollView.layer.visibleRect;
        actionSheetFrame = [self.moveAnimationController relativeToAbsolute:self.detailViewController.addButton];
        CGPoint actionSheetOrigin = actionSheetFrame.origin;
        CGSize actionSheetSize = actionSheetFrame.size;
        actionSheetFrame = CGRectMake(actionSheetOrigin.x, actionSheetOrigin.y-topRectToVisible.origin.y+actionSheetSize.height, 0, 0);
    }
    [orderSelect showFromRect:actionSheetFrame inView:self.appDelegate.window animated:YES];
    
}

- (void) reloadTableViewAfterAnimationWithIndexPath:(NSIndexPath *)indexPath{
    [orderedListViewController reloadTableViewSelectToIndexPath:indexPath usingAnimationTransition:UIViewAnimationTransitionNone usingSelectAnimation:YES];
    
}


- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if ((self = [super initWithStyle:style])) {
        [self setTableView:[[DishDataTableView alloc] initWithFrame:self.tableView.frame style:style]];
    }
    return self;
}
/*
- (id) initWithStyle:(UITableViewStyle)style andFetchedResultController:(NSFetchedResultsController *)fetchedResultdController{
    
}
*/

- (UIImage *) cuttingPictureForCellFormat:(UIImage *)image{
    CGRect clip = CGRectMake(image.size.width*0.25, image.size.height*0.25, 200, 200);
    UIImage *cuttedImage = [UIImage imageWithCGImage:CGImageCreateWithImageInRect(image.CGImage , clip)];
    return cuttedImage;
}

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
    self.appDelegate = (padOrderAppDelegate *)[[UIApplication sharedApplication] delegate];
    self.tableView.allowsSelection = NO;
    self.tableView.layer.cornerRadius = 10;
    self.moveAnimationController = [[MoveAnimationController alloc] init];
    padOrderSearchBarDelegate *searchDelegate = [[padOrderSearchBarDelegate alloc] init];
    searchDelegate.dishDataTableViewController = self;
    self.searchDisplayController.delegate = searchDelegate;
    self.searchDisplayController.searchBar.delegate =  searchDelegate;
    //self.searchDisplayController.searchResultsDataSource = [[DishDataTableViewController alloc] initWithStyle:UITableViewStylePlain];
    self.onSearch = NO;
    
    
    self.setInfoViewController = [[SetInfomationViewController alloc] initWithNibName:@"SetInfomationView" bundle:[NSBundle mainBundle]];
    self.setInfoViewController.modalInPopover = YES;
    setInfoViewController.contentSizeForViewInPopover = CGSizeMake(self.setInfoViewController.view.frame.size.width, self.setInfoViewController.view.frame.size.height);
    self.popoverController = [[UIPopoverController alloc] initWithContentViewController:self.setInfoViewController];
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Override to allow orientations other than the default portrait orientation.
    //[self.tableView reloadData];
    return YES;
}

#pragma mark -
#pragma mark Table view data source

//設定詳細餐點資訊的物件顯示
- (void) tableView:(UITableView *)tableView 
    accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    self.detailViewController = [[DishDetailViewController alloc] initWithNibName:@"DishDetailView" bundle:[NSBundle mainBundle] indexPath:indexPath];
    EntityDish *dish = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    DishTableCellView *cell = (DishTableCellView *)[self.tableView cellForRowAtIndexPath:indexPath];
    
    detailViewController.title = @"餐點介紹";
    detailViewController.tableViewController = self;
    detailViewController.dishTitle.text = dish.Dish_Name;
	detailViewController.addButton.managerObject = dish;
    detailViewController.dishDescription.text = dish.Describe.Describe_Complete;
    detailViewController.indexPath = indexPath;
    detailViewController.dishPrice.text = [NSString stringWithFormat:@"NT $%@",dish.Dish_Price];
    [detailViewController.addButton setBackgroundImage:cell.submitButton.currentBackgroundImage forState:UIControlStateNormal];
    detailViewController.addButton.fetchedResultsController = self.fetchedResultsController;
	
    CGRect addButtonFrame = detailViewController.addButton.frame;
    CGRect submitButtonFrame = cell.submitButton.frame;
    CGPoint buttonOrigin = addButtonFrame.origin;
    CGSize buttonSize = submitButtonFrame.size;
    
    detailViewController.addButton.frame = CGRectMake(buttonOrigin.x, buttonOrigin.y, buttonSize.width, buttonSize.height);
    [detailViewController.addButton setTitle:cell.submitButton.titleLabel.text forState:UIControlStateNormal];
	[detailViewController.addButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    detailViewController.dishImageView.image = cell.dishImageView.image;
    detailViewController.dishImageView.layer.cornerRadius = cell.dishImageView.layer.cornerRadius;
    detailViewController.dishImageView.layer.masksToBounds = YES;
    //detailViewController.dishImageView.layer.shadowRadius = 10;
    //detailViewController.dishImageView.layer.borderWidth = 2;
    //detailViewController.dishImageView.layer.doubleSided = YES;
    detailViewController.navigationBar = self.navigationController.navigationBar;
    [self.navigationController pushViewController:detailViewController animated:YES];
    //self.navigationController.navigationBar.hidden = YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    NSUInteger sectionsCount = [self.fetchedResultsController.sections count]; 
    return sectionsCount;//[dataDictionary count];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultsController sections] objectAtIndex:section];
    EntityDish *sectionDish = [[sectionInfo objects] objectAtIndex:0];
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 30)];
    
    toolBar.tintColor = [UIColor grayColor];
    
    NSString *title = [self tableView:tableView titleForHeaderInSection:section];
    
    SEL selector = @selector(showSetScetionInfo:);
    VarsBarButtomItem *item = [[VarsBarButtomItem alloc] initWithTitle: title style:UIBarButtonItemStylePlain target:self action: nil];
    VarsBarButtomItem *space = [[VarsBarButtomItem alloc] initWithTitle: @"系列介紹" style:UIBarButtonSystemItemFixedSpace target:self action: selector];
    
    space.Set = sectionDish.DishSet;
    space.indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
    //2010/10/27註記
    //我不知道怎麼讓selector傳送參數進去
    //除非他被點到時，我在呼叫？
    //還是寫一個類別繼承UIBarButtonItem後 專門處理之？ 
    //最後使用sender來傳送標題再讀出資料吧～
    [toolBar setItems:[NSArray arrayWithObjects:item,space,nil]];
    return toolBar;
    //return label;
}

-(void) showSetScetionInfo:(id)sender{
    VarsBarButtomItem *button = (VarsBarButtomItem *)sender;
    
    if (self.popoverController.popoverVisible) {
        [self.popoverController dismissPopoverAnimated:YES];
    }
    else {
        self.setInfoViewController.title.text = button.Set.Set_Name;
        self.setInfoViewController.content.text = button.Set.Set_Note;
        [self.popoverController presentPopoverFromBarButtonItem:button permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{    
    //標題會先做指定設定
    id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultsController sections] objectAtIndex:section];
    EntityDish *dish = [[sectionInfo objects] objectAtIndex:0];
    return dish.DishSet.Set_Name;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //取出對應於fetchedResultsController在indexPath的dishEntity
    EntityDish *dish = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    //拿到Application Document的位置路徑
    NSString *path = [[self.appDelegate applicationDocumentsDirectory] path];
    
    //implement OrderedInfoModelController 
    OrderedInfoModelController *infoModelController = [[OrderedInfoModelController alloc] init];
    
    //Cell 的原生程式碼
    static NSString *CellIdentifier = @"Cell";
	//if(indexPath.row == 1) CellIdentifier = @"Cell2";
    DishTableCellView *cell = (DishTableCellView *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[[DishTableCellView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        //提供Submiot Button的 Target位置，以便呼叫此tableViewController的ButtonAction方法
        cell.dataTableViewController = self;
        cell.dishTitle = dish.Dish_Name;
        
        cell.buttonBgPicName = @"cellAddButton.png";
        cell.detailButtonBgPicName = @"cellDetailButton.png";
		//cell.spySlider = [[UISlider alloc] init];
		//cell.spySlider.tag = 100;
		//cell.spySlider.maximumValue = 100;
		//cell.spySlider.minimumValue = 0;
		
        
        //取出這個dish的主要圖片;
        NSURL *picPath = [dish getURLForMainImageFullPath];
        UIImage *pic = [UIImage imageWithContentsOfFile:[picPath path]];
        UIImage *showPicture = [UIImage imageNamed:@"no_image.png"];
        cell.isExistDishImage = (pic != nil);
        if (cell.isExistDishImage) {
            cell.isExistDishImage = YES;
            showPicture = [self cuttingPictureForCellFormat:pic];
        }
        cell.dishImage = showPicture;
    }
    cell.submitButton.indexPath = indexPath;
    cell.submitButton.managerObject = dish;
    cell.detailButton.indexPath = indexPath;
    //自定的按鈕類別，可以存一堆變數
    //這裡把indexPath的位置傳給按鈕
    
    cell.dishPrice = dish.Dish_Price;
    cell.descriptText = dish.Describe.Describe_Simple;
	cell.hotValue = 10;
    cell.hotSplider.hidden = YES;
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	/*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end

