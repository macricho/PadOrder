//
//  DishDataTableView.h
//  padOrder
//
//  Created by Macric Cho on 2010/10/21.
//  Copyright 2010 Macricho. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DishDataTableViewController;
@interface DishDataTableView : UITableView <UITableViewDelegate>{
    DishDataTableViewController *dishDataTableViewController;
}

@property (nonatomic,retain) DishDataTableViewController *dishDataTableViewController;

@end
