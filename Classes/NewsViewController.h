//
//  NewsViewController.h
//  padOrder
//
//  Created by Macric Cho on 2010/9/8.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsViewController : UIViewController {
    UIWebView *webView;
    UIToolbar *webToolBar;
}
@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) IBOutlet UIToolbar *webToolBar;

- (void) goHome;
- (void) addHomeButton;
@end
