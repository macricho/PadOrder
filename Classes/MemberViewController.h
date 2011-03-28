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
}

@property (nonatomic, retain) Facebook *fb;

- (IBAction) login:(id)sender;

@end
