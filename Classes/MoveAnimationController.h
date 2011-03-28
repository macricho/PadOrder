//
//  MoveAnimationController.h
//  padOrder
//
//  Created by Macric Cho on 2010/11/13.
//  Copyright 2010 Macricho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface MoveAnimationController : NSObject {
    UIView *beAnimation;
    UIColor *startBgColor;
    UIColor *endBgColor;
    CGRect startFrame;
    CGRect endFrame;
    UIView *animationContext;
    CGFloat beginAlpha;
    CGFloat endAlpha; 
}

@property (nonatomic, retain) UIView *beAnimation;
@property (nonatomic) CGRect startFrame;
@property (nonatomic) CGRect endFrame;
@property (nonatomic, retain) UIColor *startBgColor;
@property (nonatomic, retain) UIColor *endBgColor;
@property (nonatomic, retain) UIView *animationContext;
@property (nonatomic) CGFloat beginAlpha;
@property (nonatomic) CGFloat endAlpha; 

- (id) initWithView:(UIView *)aView;

- (UIImageView *) moveImage:(UIImage *)image inView:(UIView *)animationView  from:(CGRect)start to:(CGRect)end beginAlpha:(CGFloat) bAlpha endingAlpha:(CGFloat)eAlpha movingStartBackgroundColor:(UIColor *)startBg becomeEndBackgroundColor:(UIColor *)endBg;

- (UIImageView *) moveViewScreenshot:(UIView *)aView inView:(UIView *)animationView from:(CGRect)start to:(CGRect)end withBeginAlpha:(CGFloat)bAlpha EndingAlpha:(CGFloat)eAlpha movingStartBackgroundColor:(UIColor *)startBg becomeEndBackgroundColor:(UIColor *) endBg;

- (UIImage *)screenshotWithView:(UIView *)view;
- (CGRect) relativeToAbsolute:(UIView *)view;
- (void) action;
- (void) releaseImageView:(UIImageView *)imageView;
@end
