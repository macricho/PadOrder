//
//  CustomAlertView.m
//  padOrder
//
//  Created by 均諺 on 2010/11/19.
//  Copyright 2010 Macricho. All rights reserved.
//

#import "CustomAlertView.h"


@implementation CustomAlertView

- (id) initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles{
    
    if(self = [super initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles,nil]){
        
    }
    return self;
}

- (void) willPresentAlertView:(UIAlertView *)alertView{
    for (id item in alertView.subviews) {
        if([[[item class] description] isEqual:@"UIThreePartButton"]){
                //NSLog(@"%@",item);
        }
    }
}

- (void) didPresentAlertView:(UIAlertView *)alertView{
    
}

@end
