//
//  CustomAlertView.h
//  padOrder
//
//  Created by 均諺 on 2010/11/19.
//  Copyright 2010 Macricho. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CustomAlertView : UIAlertView <UIAlertViewDelegate>{
    
}

- (id) initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles;

@end
