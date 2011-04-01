//
//  MemberViewController.h
//  padOrder
//
//  Created by Macric Cho on 2010/9/11.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "padOrderViewController.h"
#import "FBConnect.h"
@interface MemberViewController : padOrderViewController{
    Facebook *fb;
    UITextField *account;
    UITextField *password;
}

@property (nonatomic, retain) Facebook *fb;
@property (nonatomic, retain) IBOutlet UITextField *account;
@property (nonatomic, retain) IBOutlet UITextField *password;
- (IBAction) login:(id)sender;

@end
