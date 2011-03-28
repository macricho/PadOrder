//
//  GStepControllerCollection.h
//  padOrder
//
//  Created by 均諺 on 2010/12/5.
//  Copyright 2010 Macricho. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GStep1ViewController;
@class GStep2ViewController;
@class GuideSetpViewController;
@interface GStepControllerCollection : NSObject {
    GuideSetpViewController *rootViewController;
    GStep1ViewController *step1ViewController;
    GStep2ViewController *step2ViewController;
}

@property (nonatomic, retain) GuideSetpViewController *rootViewController;
@property (nonatomic, retain) GStep1ViewController *step1ViewController;
@property (nonatomic, retain) GStep2ViewController *step2ViewController;


@end
