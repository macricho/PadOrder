//
//  GStepControllerCollection.m
//  padOrder
//
//  Created by 均諺 on 2010/12/5.
//  Copyright 2010 Macricho. All rights reserved.
//

#import "GStepControllerCollection.h"
#import "GuideSetpViewController.h"
#import "GStep1ViewController.h"
#import "GStep2ViewController.h"

@implementation GStepControllerCollection
@synthesize rootViewController;
@synthesize step1ViewController;
@synthesize step2ViewController;

- (id) init{
    self = [super init];
    if (self) {
        self.step1ViewController = [[GStep1ViewController alloc] init];
        self.step2ViewController = [[GStep2ViewController alloc] init];
        self.rootViewController = nil;
    }
    return self;
}

- (UIViewController *) nextViewController{
    NSInteger tmp;
    if (self.rootViewController == nil) {
        self.rootViewController = self.step1ViewController;
    }
    else {
        switch (self.rootViewController.view.tag) {
            case 1:
                self.rootViewController = self.step2ViewController;
                break;
            case 2:
                tmp = self.rootViewController.view.tag;
                self.rootViewController = [[GuideSetpViewController alloc] init];
                self.rootViewController.view.tag = tmp+1; 
                break;
            default:
                tmp = self.rootViewController.view.tag;
                self.rootViewController = [[GuideSetpViewController alloc] init];
                self.rootViewController.view.tag = tmp+1;  
                break;
        }
    }

    return self.rootViewController;
}

@end
