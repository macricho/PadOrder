//
//  padOrderSearchBarDelegate.h
//  padOrder
//
//  Created by Macric Cho on 2010/11/13.
//  Copyright 2010 Macricho. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DishDataTableViewController;
@interface padOrderSearchBarDelegate : NSObject <UISearchBarDelegate,UISearchDisplayDelegate>{
    DishDataTableViewController *dishDataTableViewController;
}

@property(nonatomic, retain) DishDataTableViewController *dishDataTableViewController;

@end
