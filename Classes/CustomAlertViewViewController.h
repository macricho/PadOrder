//
//  CustomAlertViewViewController.h
//  padOrder
//
//  Created by 均諺 on 2010/11/19.
//  Copyright 2010 Macricho. All rights reserved.
//

#import <UIKit/UIKit.h>

    //記得加入UIAlertViewDelete
@interface CustomAlertViewViewController : UIViewController<UIAlertViewDelegate> {
    UIAlertView *myAlertView;
}

@property (nonatomic,retain) UIAlertView *myAlertView;

-(IBAction) buttonPressed:(id)sender;

@end