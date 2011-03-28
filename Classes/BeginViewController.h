//
//  BeginViewController.h
//  padOrder
//
//  Created by Macric Cho on 2010/10/18.
//  Copyright 2010 Macricho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "padOrderLandscapeViewController.h"
#import "PadOrderLogoViewController.h"
@interface BeginViewController : padOrderLandscapeViewController {
    UIButton *infoButton;
    NSInteger nextIndex;
    PadOrderLogoViewController *logoViewController;
    UIView *blackView;
    UINavigationController *testController;
}

@property (nonatomic, retain) IBOutlet UIButton *infoButton;
@property (nonatomic) NSInteger tabBarIndex;
@property (nonatomic, retain) PadOrderLogoViewController *logoViewController;
@property (nonatomic, retain) UIView *blackView;
@property (nonatomic, retain) UINavigationController *testController;

- (IBAction) actionToNext:(id)sender;
- (IBAction) showPadOrderInformation:(id)sender;
- (IBAction) hidePadOrderInformation:(id)sender;
@end
