//
//  POBillTableViewController.h
//  padOrder
//
//  Created by Grady Cho on 2011/3/13.
//  Copyright 2011年 Macricho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllEntity.h"
#import "AllModalController.h"

//整合正在點餐相關的清單控制器
//2011.03.13 還沒完成 正在製作
@interface POBillTableViewController : UITableViewController {
    NSFetchedResultsController *fetchedResultsController;
}
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@end
