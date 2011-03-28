//
//  padOrderSetupController.h
//  padOrder
//
//  Created by Macric Cho on 2010/9/24.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DishViewController;
@class EntityOrderKind;
@interface padOrderSegmentSetupController : NSObject {
    DishViewController *dishViewController;
    NSFetchedResultsController *fetchedResultsController;
    UITableView *tableView;
}

@property (nonatomic, retain) DishViewController *dishViewController;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
- (void) segmentControl:(UISegmentedControl *)segmentControl setTitles:(NSArray *)array;
- (IBAction) changeSegmentSelect:(id)sender;
- (id) initWithController:(id)Controller andTableView:(UITableView *)tableView;
@end
