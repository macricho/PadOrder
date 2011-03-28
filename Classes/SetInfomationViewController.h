//
//  SetInfomationViewController.h
//  padOrder
//
//  Created by 均諺 on 2010/11/20.
//  Copyright 2010 Macricho. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SetInfomationViewController : UIViewController {
    UILabel *title;
    UITextView *content;
}

@property (nonatomic, retain) IBOutlet UILabel *title;
@property (nonatomic, retain) IBOutlet UITextView *content;

@end
