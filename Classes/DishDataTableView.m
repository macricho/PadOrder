//
//  DishDataTableView.m
//  padOrder
//
//  Created by Macric Cho on 2010/10/21.
//  Copyright 2010 Macricho. All rights reserved.
//

#import "DishDataTableView.h"
#import "DishDataTableViewController.h"

@implementation DishDataTableView
@synthesize dishDataTableViewController;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
        //self.delegate = self.dishDataTableViewController;
        //self.dataSource = self.dishDataTableViewController;
        
    }
    return self;
}

- (id) initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if(self = [super initWithFrame:frame style:style]){
        //self.delegate = self.dishDataTableViewController;
        //self.dataSource = self.dishDataTableViewController;
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void)dealloc {
    [super dealloc];
}

@end
