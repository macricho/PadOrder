//
//  padOrderSegmentSetupController.m
//  padOrder
//
//  Created by Macric Cho on 2010/9/24.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "padOrderSegmentSetupController.h"
#import "DishViewController.h"
#import "EntityOrderKind.h"
#import "DishDataModelController.h"

@implementation padOrderSegmentSetupController
@synthesize dishViewController;;
@synthesize tableView;
@synthesize fetchedResultsController;

#pragma mark -
#pragma mark Self-Method

- (id) initWithController:(DishViewController *)Controller andTableView:(UITableView *)aTableView{
    self = [super init];
    if(self){
        self.dishViewController = Controller;
        self.tableView = aTableView;
        //self.tableView.allowsSelection = NO;
    }
    return self;
}

- (IBAction) changeSegmentSelect:(id)sender{
    //The count of section in table view have to be over zero
    
    [self.dishViewController refreshFetchedResultsControllerWithIndex:self.dishViewController.segmentControl.selectedSegmentIndex];
    if([self.tableView numberOfSections] > 0){
        NSIndexPath *topIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];

        [self.tableView scrollToRowAtIndexPath:topIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        [self.tableView reloadData];
    }
}

- (void) segmentControl:(UISegmentedControl *)segmentControl setTitles:(NSArray *)array{
    
    [segmentControl removeAllSegments];
    
    NSUInteger i, count = [array count];
    for (i = 0; i < count; i++) {
        NSString *title = [(EntityOrderKind *)[array objectAtIndex:i] Kind_Name];
        [segmentControl insertSegmentWithTitle:title atIndex:i animated:YES];
        [title release];
    }
    
    [segmentControl addTarget:self action:@selector(changeSegmentSelect:) forControlEvents:UIControlEventValueChanged];
    //此行會執行一次選資料的動作
    [segmentControl setSelectedSegmentIndex:0];
}


@end
