//
//  padOrderAlertViewDelegate.m
//  padOrder
//
//  Created by Macric Cho on 2010/9/9.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "padOrderAlertViewDelegate.h"


@implementation padOrderAlertViewDelegate

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    //(@"%d",buttonIndex);
}

- (void) alertViewCancel:(UIAlertView *)alertView{
    //(@"Here?");
}

- (void) alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    //(@"didDismiss%d",buttonIndex);
}

- (void) willPresentAlertView:(UIAlertView *)alertView{

}

- (void) didPresentAlertView:(UIAlertView *)alertView{
        //CALayer *l = alertView.layer;
        //l.contents = (id)[[UIImage imageNamed:@"facebook_logo.jpg"] CGImage];
}

- (void) dealloc{
    [self release];
    [super dealloc];
}

@end
