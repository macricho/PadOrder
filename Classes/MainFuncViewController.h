//
//  MainFuncViewController.h
//  padOrder
//
//  Created by Macric Cho on 2010/9/1.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewsViewController;
@class DishViewController;
@class MemberViewController;
@class padOrderTabBarControllerDelegate;
@class DishForRankViewController;
@class DishForOrderViewController;

@interface MainFuncViewController : UIViewController<UITabBarDelegate,UITabBarControllerDelegate,UINavigationControllerDelegate,UINavigationBarDelegate> {
    UITabBarController *funcsTabBarController;
    
    NewsViewController *newsViewController;
    DishViewController *dishViewController;
    DishViewController *rankViewController;
    MemberViewController *memberViewController;
    
    NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic, retain) IBOutlet UITabBarController *funcsTabBarController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (NSArray *) createTabBarArray;
- (void) configureTabBarItem;
- (UINavigationController *) convertViewController:(UIViewController *) rootController WithTitle:(NSString *)viewTitle;

@end
