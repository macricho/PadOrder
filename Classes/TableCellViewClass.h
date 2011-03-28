//
//  TableCellViewClass.h
//  padOrder
//
//  Created by Macric Cho on 2010/10/18.
//  Copyright 2010 Macricho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreGraphics/CGAffineTransform.h>
#import <QuartzCore/QuartzCore.h>
#import "VarsButton.h"

@interface TableCellViewClass : UITableViewCell <UITableViewDelegate>{
    UIImageView *dishImageView;
    UILabel *titleLabel;
    UITextView *descriptTextView;
    UIImage *dishImage;
    VarsButton *submitButton;
    VarsButton *detailButton;
    UILabel *priceLabel;
	UISlider *hotSplider;
}
@property (nonatomic, retain) UIImage *dishImage;
@property (nonatomic, retain) UIImageView *dishImageView;
@property (nonatomic, retain) VarsButton *submitButton;
@property (nonatomic, retain) VarsButton *detailButton;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UITextView *descriptTextView;
@property (nonatomic, retain) UILabel *priceLabel;
@property (nonatomic, retain) UISlider *hotSplider;

- (void) assignSetup;
- (void) setImage:(UIImage *)image inFrame:(CGRect)frame; 
//- (void) setButton:(UIButton *)button;
- (void) setDescription:(NSString *)description andFontSize:(CGFloat)fontSize withColor:(UIColor *)color;
- (void) setDishTitle:(NSString *)title andFontSize:(CGFloat)size;
- (void) setSubmitButton:(NSString *)normalImageName withShadow:(BOOL)canUseShowdow;
- (void) setDetailButton:(NSString *)normalImageName withShadow:(BOOL)canUseShowdow;

- (void) label:(UILabel *)label withPoint:(CGPoint)point setText:(NSString *)text andFontSize:(CGFloat)size;
- (void) setDishPrice:(NSNumber *)price andFontSize:(CGFloat)size;
- (UIImage*)imageWithShadow : (UIImage *)image;
- (CGFloat) pointFromRightSide:(CGFloat) width;
- (CGFloat) pointFromButtomSide:(CGFloat) height;

@end
