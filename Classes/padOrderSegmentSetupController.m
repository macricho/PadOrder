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
    if(self = [super init]){
        self.dishViewController = Controller;
        self.tableView = aTableView;
    }
    return self;
}

- (IBAction) changeSegmentSelect:(id)sender{
    //The count of section in table view have to be over zero
    
    ////(@"???");
    //NSFetchedResultsController *fetch = [self.dishViewController.tableViewController fetchedResultsController];

    ////(@"%d",self.dishViewController.segmentControl.selectedSegmentIndex);
    [self.dishViewController refreshFetchedResultsControllerWithIndex:self.dishViewController.segmentControl.selectedSegmentIndex];
    if([self.tableView numberOfSections] > 0){
        ////(@"tableView:%@",self.tableView);
        NSIndexPath *beSelect = [NSIndexPath indexPathForRow:0 inSection:0];
        self.tableView.allowsSelection = YES;
        [self.tableView selectRowAtIndexPath:beSelect animated:NO scrollPosition:UITableViewScrollPositionTop];
        self.tableView.allowsSelection = NO;
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
