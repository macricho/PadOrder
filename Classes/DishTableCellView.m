//
//  DishTableCellView.m
//  padOrder
//
//  Created by Macric Cho on 2010/10/18.
//  Copyright 2010 Macricho. All rights reserved.
//

#import "DishTableCellView.h"


@implementation DishTableCellView
@synthesize dishEntityInfo;
@synthesize dishTitle;
@synthesize descriptText;
@synthesize dishImageName;
@synthesize dataTableViewController;
@synthesize dishPrice;
@synthesize buttonBgPicName;
@synthesize hotValue;
@synthesize detailButtonBgPicName;

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.frame = CGRectMake(0, 0, 650, 200);
        [self assignSetup];
    }
    return self;
}

-(void) setDishImage:(UIImage *)image{
    
    CGFloat pSize = self.imageView.frame.size.width/image.size.width;
    CGFloat imgHeight = image.size.height * pSize;
    
    CGRect frame = CGRectMake(0, 0, self.imageView.frame.size.width, imgHeight);
    
    [self setImage: image inFrame:frame];
}

- (void) setDishPrice:(NSNumber *)price{
    [self setDishPrice:price andFontSize:20];
}

-(void) setDishImageName:(NSString *)imageName{
    
    UIImage *image = [UIImage imageNamed:imageName];
    CGFloat pSize = self.imageView.frame.size.width/image.size.width;
    CGFloat imgHeight = image.size.height * pSize;
    
    CGRect frame = CGRectMake(0, 0, self.imageView.frame.size.width, imgHeight);
    
    [self setImage: image inFrame:frame];
    [image release];
}

- (void) setDescriptText:(NSString *)description{
    [self setDescription:description andFontSize:14 withColor:[UIColor darkGrayColor]];
}

- (void) setDishTitle:(NSString *)title{
    [self setDishTitle:title andFontSize:30];
}

- (void) setHotValue:(NSInteger)value{
	self.hotSplider.value = value;
}

- (void) setButtonBgPicName:(NSString *)name{
    //@"order_add_bg.png"
    [self setSubmitButton: name withShadow:NO];
	self.submitButton.isDetail = NO;
    [self.submitButton setTitle:@"加點" forState:UIControlStateNormal];
    [self.submitButton addTarget:self.dataTableViewController action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setDetailButtonBgPicName:(NSString *)name{
    [self setDetailButton: name withShadow:NO];
	self.detailButton.isDetail = NO;
    [self.detailButton setTitle:@"介紹" forState:UIControlStateNormal];
    [self.detailButton addTarget:self.dataTableViewController action:@selector(buttonDetail:) forControlEvents:UIControlEventTouchUpInside];
     
}

@end
