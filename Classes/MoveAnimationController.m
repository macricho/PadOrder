//
//  MoveAnimationController.m
//  padOrder
//
//  Created by Macric Cho on 2010/11/13.
//  Copyright 2010 Macricho. All rights reserved.
//

#import "MoveAnimationController.h"
#import "padOrderAppDelegate.h"

@implementation MoveAnimationController
@synthesize beAnimation;
@synthesize startFrame;
@synthesize endFrame;
@synthesize startBgColor;
@synthesize endBgColor;
@synthesize animationContext;
@synthesize beginAlpha;
@synthesize endAlpha;

- (id) init{
    if(self = [super init]){
        self.beAnimation = [[UIView alloc] init];
        self.startFrame = CGRectZero;
        self.endFrame = CGRectZero;
        self.startBgColor = [UIColor whiteColor];
        self.endBgColor = [UIColor whiteColor];
        self.beginAlpha = 1;
        self.endAlpha = 0;
        self.animationContext = [(padOrderAppDelegate *)[[UIApplication sharedApplication] delegate] mainSplitViewController].view;
    }
    return self;
}

- (id) initWithView:(UIView *)aView{
    if (self = [self init]) {
        self.beAnimation = aView;
    }
    return self;
}

- (UIImage *) screenshotWithView:(UIView *)view{
    
    //UIGraphicsBeginImageContext(view.bounds.size);
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 1);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image= UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    /*
    CGSize viewSize = CGSizeMake(view.frame.size.width, view.frame.size.height); 
    UIGraphicsBeginImageContext(viewSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage *screenShot = UIGraphicsGetImageFromCurrentImageContext();
    //NSLog(@"%@",screenShot);
    UIGraphicsEndImageContext();
    */
     //return screenShot;
    return image;
}

- (CGRect) relativeToAbsolute:(UIView *)view{
    UIView *pView = view;
    CGFloat x = 0;
    CGFloat y = 0;
    
    if(view == nil) return CGRectZero;
    do {
        x += pView.frame.origin.x;
        y += pView.frame.origin.y;
        pView = pView.superview;
    } while (pView != self.animationContext);
    
    return CGRectMake(x, y, view.frame.size.width, view.frame.size.height);
}

- (UIImageView *) moveImage:(UIImage *)image inView:(UIView *)animationView  from:(CGRect)start to:(CGRect)end beginAlpha:(CGFloat) bAlpha endingAlpha:(CGFloat)eAlpha movingStartBackgroundColor:(UIColor *)startBg becomeEndBackgroundColor:(UIColor *)endBg{
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [imageView.image release];
    imageView.alpha = bAlpha;
    imageView.frame = start;
    [animationView addSubview:imageView];
    
    [UIView beginAnimations:@"moveAnimation" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:imageView cache:YES];
    [UIView setAnimationDuration:1];
    [imageView setFrame:end];
    imageView.alpha = eAlpha;
	//imageView.alpha = 0;
    imageView.backgroundColor = endBg;
    [UIView commitAnimations];
    return imageView;
    //[self performSelector:@selector(releaseImageView:) withObject:imageView afterDelay:2];
}

- (UIImageView *) moveViewScreenshot:(UIView *)aView inView:(UIView *)animationView from:(CGRect)start to:(CGRect)end withBeginAlpha:(CGFloat)bAlpha EndingAlpha:(CGFloat)eAlpha movingStartBackgroundColor:(UIColor *)startBg becomeEndBackgroundColor:(UIColor *) endBg {
    
    aView.alpha = bAlpha;
    UIColor *viewBackgroundColor =  [UIColor colorWithCGColor:aView.backgroundColor.CGColor];
    
    aView.backgroundColor = startBg;
    
    UIImage *screenshot = [self screenshotWithView:aView];

    aView.backgroundColor = [UIColor colorWithCGColor:viewBackgroundColor.CGColor];

    return [self moveImage:screenshot 
            inView:animationView 
            from:start 
            to:end 
            beginAlpha:bAlpha 
            endingAlpha:eAlpha
            movingStartBackgroundColor:startBg
            becomeEndBackgroundColor:endBg
     ];

}

- (void) action{
    UIImageView *imageView = [self moveViewScreenshot:self.beAnimation 
            inView:self.animationContext 
            from:self.startFrame 
            to:self.endFrame 
            withBeginAlpha:self.beginAlpha 
            EndingAlpha:self.endAlpha 
            movingStartBackgroundColor:self.startBgColor 
            becomeEndBackgroundColor:self.endBgColor];
    [self performSelector:@selector(releaseImageView:) withObject:imageView afterDelay:1.1];
}

- (void) releaseImageView:(UIImageView *)imageView{
    [imageView removeFromSuperview];
    imageView = nil;
    [imageView release];
}
@end
