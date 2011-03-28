//
//  padOrderFacebookDelegate.h
//  padOrder
//
//  Created by Macric Cho on 2010/11/9.
//  Copyright 2010 Macricho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FBConnect.h"

@interface padOrderFacebookDelegate : NSObject<FBRequestDelegate,FBDialogDelegate,FBSessionDelegate> {
    Facebook *facebook;
}

@property (nonatomic, retain) Facebook *facebook;

@end
