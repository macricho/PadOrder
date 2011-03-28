//
//  padOrderViewController.h
//  padOrder
//
//  Created by Macric Cho on 2010/11/2.
//  Copyright 2010 Macricho. All rights reserved.
//

#import <UIKit/UIKit.h>

@class padOrderAppDelegate;
@interface padOrderViewController : UIViewController {
    padOrderAppDelegate *padOrderDelegate;
    UILabel *topTitleLabel;
    UIImageView *imageBgView;
}
@property (nonatomic, retain) padOrderAppDelegate *padOrderDelegate;
@property (nonatomic, retain) IBOutlet UILabel *topTitleLabel;
@property (nonatomic, retain) IBOutlet UIImageView *imageBgView;
- (UIImage*)imageWithShadow : (UIImage *)image;

@end
