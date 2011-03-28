//
//  DishTableCellView.h
//  padOrder
//
//  Created by Macric Cho on 2010/10/18.
//  Copyright 2010 Macricho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TableCellViewClass.h"
//#import "DishDataTableViewController.h"

@class EntityDish;
@interface DishTableCellView : TableCellViewClass<UITableViewDelegate>{
    EntityDish *dishEntityInfo;
    NSString *dishTitle;
    NSString *descriptText;
    NSString *dishImageName;
    UITableViewController *dataTableViewController;
    NSNumber *dishPrice;
    NSString *buttonBgPicName;
    NSString *detailButtonBgPicName;
	NSInteger hotValue;
}

@property (nonatomic, retain) NSString *buttonBgPicName;
@property (nonatomic, retain) NSString *detailButtonBgPicName;
@property (nonatomic, retain) EntityDish *dishEntityInfo;
@property (nonatomic, retain) NSString *dishTitle;
@property (nonatomic, retain) NSString *dishImageName;
@property (nonatomic, retain) NSString *descriptText;
@property (nonatomic, retain) NSNumber *dishPrice;
@property (nonatomic, retain) UITableViewController *dataTableViewController;
@property (nonatomic) NSInteger hotValue;
//- (void) setDishPicture:(NSString *)imageName;
//- (void) setSubmitButton:(NSString *)normal onPressed:(NSString *)pressed;
@end
