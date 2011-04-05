//
//  OrderedTableViewController.m
//  padOrder
//
//  Created by Macric Cho on 2010/9/9.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "OrderedTableViewController.h"
#import "OrderedDetailViewController.h"
#import "OrderedListViewController.h"
#import "MainFuncViewController.h"
#import "CustomCellView.h"

#import "padOrderAppDelegate.h"
#import "padOrderSplitControllerDelegate.h"

#import "padOrderDataManager.h"
#import "OrderedInfoModelController.h"
#import "OrderedDishModelController.h"
#import "StatusModelController.h"

#import "EntityDish.h"
#import "EntityDescribe.h"
#import "EntityOrderedDish.h"
#import "EntityOrderedInfo.h"
#import "EntityImage.h"
#import "Stack.h"
@implementation OrderedTableViewController
@synthesize fetchedResultsController;
@synthesize listViewController;
@synthesize chineseHeader;
@synthesize orderedDishModelController;
@synthesize orderedInfoModelController;
@synthesize totalPrice;
@synthesize isClear;
 
#pragma mark -
#pragma mark Self-Method

- (void) reloadTableViewSelectToIndexPath:(NSIndexPath *)indexPath usingAnimationTransition:(UIViewAnimationTransition)transition usingSelectAnimation:(BOOL)boolean{
    [self.listViewController reloadTableViewSelectToIndexPath:indexPath usingAnimationTransition:transition usingSelectAnimation:boolean];
}

- (void) sendOrderingList{
    //之後要加入連線到廚房的動作
    //先做改變屬性
    //在填入submit_time的屬性
    //[self.orderedInfoModelController updateSubmitDateTime:[NSDate date]];
    [self.orderedInfoModelController updateSubmitDateTime:[NSDate date] withStatus:0];
    [self.orderedInfoModelController changeOrderedDishFromStatus:0 toStatus:1];
    //重新擷取資料庫資料，以便顯示的資料是最新的
    [orderedInfoModelController refreshFetchedResultsController:fetchedResultsController];  
    [listViewController refreshPriceLabel];  
    [listViewController refreshPriceLabel];
    //更新合計標籤
    [listViewController refreshPriceLabel];;
    [self reloadTableViewSelectToIndexPath:nil usingAnimationTransition:UIViewAnimationTransitionCurlUp usingSelectAnimation:YES];    
}

// 把status 為2的 已點餐點設為隱藏
- (void) hiddenObject{
    for (EntityOrderedInfo *infoObject in [self.fetchedResultsController fetchedObjects]) {
        infoObject.Will_Show = [NSNumber numberWithBool:NO];
    }
    //重新擷取資料庫資料，以便顯示的資料是最新的
    [orderedInfoModelController refreshFetchedResultsController:fetchedResultsController];  
    [listViewController refreshPriceLabel];  
    [listViewController refreshPriceLabel];
    //更新合計標籤
    [listViewController refreshPriceLabel];;
    [self reloadTableViewSelectToIndexPath:nil usingAnimationTransition:UIViewAnimationTransitionFlipFromRight usingSelectAnimation:YES];
    [self.orderedInfoModelController.managedObjectContext save:nil];
}


- (NSIndexPath *) indexPathAndRefreshWithEntity:(EntityOrderedInfo *)infoEntity{
    //重新擷取資料庫資料，以便顯示的資料是最新的
    [orderedInfoModelController refreshFetchedResultsController:fetchedResultsController];  
    [listViewController refreshPriceLabel];  
    [listViewController refreshPriceLabel];
    //更新合計標籤
    [listViewController refreshPriceLabel];;
    return [self.fetchedResultsController indexPathForObject:infoEntity];
}

- (void) refreshFetchedResultsControllerByStatusFrom:(NSInteger)from to:(NSInteger)to{
    if([[self.fetchedResultsController fetchedObjects] count] == 0) self.isClear = YES;
    
    self.fetchedResultsController = [orderedInfoModelController fetchedDishSelectStatusFrom:from to:to];
    //重新擷取資料庫資料，以便顯示的資料是最新的
    [orderedInfoModelController refreshFetchedResultsController:fetchedResultsController];  
    [listViewController refreshPriceLabel];  
    [listViewController refreshPriceLabel];
}

- (void) countOrderedDishTotalPrice{
    self.totalPrice = [NSNumber numberWithInt:0];
    for (EntityOrderedInfo *infoObject in [self.fetchedResultsController fetchedObjects]) {
        //self.totalPrice += infoObject.Dish.Dish_Price;
        ////(@"INFO:%@",infoObject);
        self.totalPrice = [NSNumber numberWithInt:[self.totalPrice integerValue]+[infoObject.Price integerValue] ];
    }
}

#pragma mark -
#pragma mark Initialization


- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if ((self = [super initWithStyle:style])) {
        self.totalPrice = 0;
        
        self.orderedDishModelController = [[OrderedDishModelController alloc] init];
        self.orderedInfoModelController = [[OrderedInfoModelController alloc] init];
        
        self.chineseHeader = [[[StatusModelController alloc] init] statusNoToNameDictionary];        
        //NSLog(@"%@",self.chineseHeader);
        self.fetchedResultsController = [orderedInfoModelController fetchedResultsControllerGroupByStatus];
        ////重新擷取資料庫資料，以便顯示的資料是最新的
    [orderedInfoModelController refreshFetchedResultsController:fetchedResultsController];  
    //[listViewController refreshPriceLabel];  
    //[listViewController refreshPriceLabel];
    //更新合計標籤
    [listViewController refreshPriceLabel];;
    }
    return self;
}


#pragma mark -
#pragma mark UIActionSheetDelegate

//處理要當使用者點選跳出的按鈕時，要怎麼操作
//2010/10/29 遇到的問題（已解決）：Core Data的關連要注意，不然會有被覆蓋的問題
- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSIndexPath *indexPath = [self.listViewController.tableView indexPathForSelectedRow];
    EntityOrderedInfo *selectedInfo = [self.fetchedResultsController objectAtIndexPath:indexPath];
    NSEntityDescription *entity = self.orderedDishModelController.entity;
    NSManagedObjectContext *managedObjectContext = self.orderedDishModelController.managedObjectContext;
    UIViewAnimationTransition transition = UIViewAnimationTransitionCurlUp;
    //NSLog(@"Bu:%d",buttonIndex);
    
    
    buttonIndex += actionSheet.tag;    
    
    
    switch (buttonIndex) {
        case 0: 
            
            //刪除這個編號的全部
            //刪掉的是他所附屬的所有OrderedDish
            [self.orderedInfoModelController deleteInfoAndRelativeOrderedDish:selectedInfo];
            
            indexPath = nil;
            //設定刪除的動畫
            transition = UIViewAnimationTransitionCurlDown;
            break;
        case 1: //加點一份
            //insertDish = [[EntityOrderedInfo alloc] initWithEntity:entity insertIntoManagedObjectContext:[selectedInfo managedObjectContext]];
            //insertDish = selectedInfo.Order;   
            [self.orderedInfoModelController insertBeOrderedDish:selectedInfo.Dish];
            break;
        case 2:{ 
            //刪減一份
            NSFetchRequest *request = [[NSFetchRequest alloc] init];//[self.orderedDishModelController createSimpleFetchRequest];
            [request setEntity:entity];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"Dish = %@ AND  Ordered_Info=%@ And Status.Status_No = %d",selectedInfo.Dish,selectedInfo,actionSheet.tag];
            NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"Order_No" ascending:NO];
            //[request setPredicate:predicate];
            [request setSortDescriptors:[NSArray arrayWithObject:sort]];
            NSArray *array = [managedObjectContext executeFetchRequest:request error:nil];
            
            //NSLog(@"Array:%@,%d",array,actionSheet.tag);
            EntityOrderedDish *ordered = [array objectAtIndex:0];
            [managedObjectContext deleteObject:ordered];
            
            selectedInfo.Count = [NSNumber numberWithInt:([selectedInfo.Count intValue]-1)];
            selectedInfo.Price = [NSNumber numberWithInt:[selectedInfo.Dish.Dish_Price intValue] * [selectedInfo.Count intValue]];
            if ([selectedInfo.Count isEqualToNumber:[NSNumber numberWithInt:0]]) {
                [managedObjectContext deleteObject:selectedInfo];
                indexPath = nil;
            }
            NSError *error=nil;
            [managedObjectContext save:&error];
            [managedObjectContext release];
            //設定刪除的動畫
            transition = UIViewAnimationTransitionCurlDown;
            break;
        }
    }
    
    if(buttonIndex != actionSheet.cancelButtonIndex){
        //重新擷取資料庫資料，以便顯示的資料是最新的
    [orderedInfoModelController refreshFetchedResultsController:fetchedResultsController];  
    [listViewController refreshPriceLabel];  
    [listViewController refreshPriceLabel];
    //更新合計標籤
    [listViewController refreshPriceLabel];;
        //[self reloadTableViewSelectToIndexPath:indexPath ];
        [self reloadTableViewSelectToIndexPath:indexPath usingAnimationTransition:transition usingSelectAnimation:NO];
            //[self.listViewController checkHasFetched];
    }
}

- (void) clearAllOrderingDish{
    
    NSFetchedResultsController *fetchedController = [self.orderedInfoModelController fetchedDishSelectStatus:@"1"];
    
    for (EntityOrderedInfo *info in [fetchedController fetchedObjects]) {
        [self.orderedInfoModelController deleteInfoAndRelativeOrderedDish:info];
    }
    
    //[self.orderedInfoModelController deleteAllFetchedResultWithController:self.fetchedResultsController];
    //重新擷取資料庫資料，以便顯示的資料是最新的
    [orderedInfoModelController refreshFetchedResultsController:fetchedResultsController];  
    [listViewController refreshPriceLabel];  
    [listViewController refreshPriceLabel];
    //更新合計標籤
    [listViewController refreshPriceLabel];;
    //[self reloadTableViewSelectToIndexPath:nil ];
    [self reloadTableViewSelectToIndexPath:nil usingAnimationTransition:UIViewAnimationTransitionCurlUp usingSelectAnimation:YES];
}

- (void) clearAllOrderedDish{
    for (EntityOrderedInfo *info in [self.fetchedResultsController fetchedObjects]) {
        [self.orderedInfoModelController deleteInfoAndRelativeOrderedDish:info];
    }
    //[self.orderedInfoModelController deleteAllFetchedResultWithController:self.fetchedResultsController];
    //重新擷取資料庫資料，以便顯示的資料是最新的
    [orderedInfoModelController refreshFetchedResultsController:fetchedResultsController];  
    [listViewController refreshPriceLabel];  
    [listViewController refreshPriceLabel];
    //更新合計標籤
    [listViewController refreshPriceLabel];;
    //[self reloadTableViewSelectToIndexPath:nil ];
    [self reloadTableViewSelectToIndexPath:nil usingAnimationTransition:UIViewAnimationTransitionNone usingSelectAnimation:YES];
}

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
    self.listViewController.tableView.rowHeight = 100;
    // Uncomment the following line to preserve selection between presentations.
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
    return YES;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EntityOrderedInfo *selected = [fetchedResultsController objectAtIndexPath:indexPath];
    UIActionSheet *sheet = nil;
    
    switch ([selected.Status.Status_No integerValue]) {
        case 0:
            sheet = [[UIActionSheet alloc] initWithTitle:[NSString 
                                                          stringWithFormat:@"正在修改：%@",selected.Dish.Dish_Name] 
                                                delegate:self
                                       cancelButtonTitle:@"返回清單" 
                                  destructiveButtonTitle:[NSString stringWithFormat:@"取消全部 %@份",selected.Count] 
                                       otherButtonTitles:@"加點一份",@"刪減一份",nil];      
            sheet.tag = 0;
            break;
        case 1:
            /*sheet = [[UIActionSheet alloc] initWithTitle:[NSString 
                                                          stringWithFormat:@"正在更改：%@",selected.Dish.Dish_Name] 
                                                delegate:self
                                       cancelButtonTitle:@"返回清單" 
                                  destructiveButtonTitle:@"取消可更改之最大份數" 
                                       otherButtonTitles:@"再加點一份",@"悔改一份",nil];  
             */
            sheet = [[UIActionSheet alloc] initWithTitle:[NSString 
                                                          stringWithFormat:@"正在更改：%@",selected.Dish.Dish_Name] 
                                                delegate:self
                                       cancelButtonTitle:@"返回清單" 
                                  destructiveButtonTitle:nil 
                                       otherButtonTitles:@"再加點一份",nil];  
            sheet.tag = 1;
            break;
        default:
            break;
    }
    if(sheet != nil){
        sheet.tag = [selected.Status.Status_No intValue];
        [sheet showFromRect:[tableView rectForRowAtIndexPath:indexPath] inView:tableView animated:YES];
        [sheet release];
    }
}

//設定詳細按鈕被點下時要做啥事情
- (void) tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    /*OrderedDetailViewController *orderedDetailViewController = [[OrderedDetailViewController alloc] initWithNibName:@"OrderedDetailView" bundle:[NSBundle mainBundle]];
    
    orderedDetailViewController.title = @"Selected";
    
    MainFuncViewController *main = [[listViewController.navigationController.splitViewController viewControllers] objectAtIndex:1];
    UINavigationController *selectedNavController = (UINavigationController *)[main.funcsTabBarController selectedViewController];
    
    //[selectedNavController popToRootViewControllerAnimated:YES]; 
    
    [selectedNavController pushViewController:orderedDetailViewController animated:YES];
     
    //找出split的委派物件，並且操控
    padOrderSplitControllerDelegate *splitDelegate = (padOrderSplitControllerDelegate *)listViewController.navigationController.splitViewController.delegate;
    [splitDelegate.popOverController dismissPopoverAnimated:YES];
    
    [orderedDetailViewController release];
    [self changeOrderedDishStatus:@"0" withIndexPath:indexPath];
     */
}

- (UIImage *) image:(UIImage *)image reSize:(CGSize)newSize{
        UIGraphicsBeginImageContext(newSize);
        [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();    
        UIGraphicsEndImageContext();
        return newImage;
}


#pragma mark -
#pragma mark Table view data source

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    //當格子顯示出來時要做啥～
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    NSUInteger sectionCount = [fetchedResultsController.sections count];
    return sectionCount;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultsController sections] objectAtIndex:section];
    //NSLog(@"objects:%@",[sectionInfo objects]);
    NSNumber *index = [NSNumber numberWithInteger:[[sectionInfo indexTitle] integerValue]];
    //NSLog(@"Titles:%@",[[sectionInfo indexTitle] class]);
    //NSLog(@"%d",section);
    //NSString *title = [chineseHeader objectForKey:[fetchedResultsController.sectionIndexTitles objectAtIndex:section]];
    //NSString *title = @"YES";
    //NSString *title = [chineseHeader objectForKey:section];
    NSString *title = [chineseHeader objectForKey:index];
    return title;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EntityOrderedInfo *orderedInfo = [fetchedResultsController objectAtIndexPath:indexPath];
    
    NSURL *picPath = [orderedInfo.Dish getURLForMainImageFullPath];    
    UIImage *pic = [UIImage imageWithContentsOfFile:[picPath path]];
    UIImage *showPicture = [UIImage imageNamed:@"no_image.png"];
    
    if (pic) {
        CGRect clip = CGRectMake(pic.size.width*0.25, pic.size.height*0.25, 200, 200);
        
        showPicture = [UIImage imageWithCGImage:CGImageCreateWithImageInRect(pic.CGImage , clip)];
        showPicture =  [self image:showPicture reSize:CGSizeMake(100, 100)];
    }
    
    
    NSString *formatString = [NSString stringWithFormat:@"\
已點：%@份\n\
小計：NT $%@",orderedInfo.Count,orderedInfo.Price];

    //if (![orderedInfo.Status isEqual:@"1"]) {
            //formatString = [NSString stringWithFormat:@"已點：%@份\n烹飪中：%@\n",orderedInfo.Count,orderedInfo.Count];
        //formatString = [NSString stringWithFormat:@"未烹煮：%@份\n小計：NT $%@",orderedInfo.Count,orderedInfo.Price];
    //}
    
    NSString *CellIdentifier = [@"Section" stringByAppendingFormat:@"%d",indexPath.section];
    
    CustomCellView *cell = (CustomCellView *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[CustomCellView alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        //UIView *viewc = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        //viewc.backgroundColor = [UIColor redColor];
        //cell.accessoryView = viewc;
        //[viewc release];
        //cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    }
    // Configure the cell...

    //EntityOrderedDish *orderedDish = [fetchedResultsController objectAtIndexPath:indexPath];//
    //cell.textLabel.text = [NSString stringWithFormat:@"%@",orderedDish.Ordered_Dish.Dish_Name] ;
    //cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",orderedDish.Dish_Index];

    cell.imageView.autoresizesSubviews = YES;
    
    //cell.image = [cell imageWithShadow:showPicture]; 
    //[cell setImage:showPicture inFrame:CGRectMake(0, 0, 50, 50)];
    //cell.imageView.frame= CGRectMake(0, 0, 50, 50);// = [[UIImageView alloc] initWithFrame:];
    cell.imageView.image = showPicture;
    
    ////(@"%@",cell.imageView.image);
    //[showPicture c]
    //[cell.imageView sizeThatFits:CGSizeMake(50, 50)];
    //[cell.imageView sizeThatFits:CGRectMake(0, 0, 50, 50)];
    //cell.image = showPicture;
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",orderedInfo.Dish.Dish_Name] ;
    cell.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
    cell.detailTextLabel.minimumFontSize = 15;
    cell.detailTextLabel.numberOfLines = 2;
    cell.detailTextLabel.text = formatString;
     return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return HEADER_HEIGHT;
}

/*
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 30)];
    toolBar.tintColor = [UIColor grayColor];
    NSString *title = [self tableView:tableView titleForHeaderInSection:section];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle: title style:UIBarButtonItemStylePlain target:self action: nil];
    [toolBar setItems:[NSArray arrayWithObjects:item,nil]];
    return toolBar;
}
*/
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
    [self.tableView release];
    [super dealloc];
}


@end

