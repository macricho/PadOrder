//
//  TableCellViewClass.m
//  padOrder
//
//  Created by Macric Cho on 2010/10/18.
//  Copyright 2010 Macricho. All rights reserved.
//

#import "TableCellViewClass.h"

@implementation TableCellViewClass
@synthesize dishImage;
@synthesize dishImageView;
@synthesize submitButton;
@synthesize titleLabel;
@synthesize descriptTextView;
@synthesize priceLabel;
@synthesize hotSplider;
@synthesize detailButton;

#pragma mark -
#pragma mark self method

- (CGFloat) pointFromRightSide:(CGFloat) width{
    return self.frame.size.width - width;
}

- (CGFloat) pointFromButtomSide:(CGFloat) height{
    return self.frame.size.height - height;
}

- (void) assignSetup{
    //self.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    //加入背景覆蓋，讓cell被點選的時候，看不到藍色的Highlight狀態
    //取消，因為可以再需要點選的時候，短暫的允許再關掉，不然會不能跳到最上面
    //UITextView *bgCover = [[UITextView alloc] initWithFrame:self.frame];
    //bgCover.backgroundColor = [UIColor clearColor];
    //bgCover.editable = NO;
    //[self addSubview:bgCover];
	
    //加入按鈕
    self.submitButton = [VarsButton buttonWithType:UIButtonTypeCustom];
    self.submitButton.autoresizingMask = UIViewAutoresizingFlexibleWidth+UIViewAutoresizingFlexibleLeftMargin;
    self.submitButton.frame = CGRectMake(550, 50, 0, 0);
    [self addSubview:self.submitButton];
    
    self.detailButton = [VarsButton buttonWithType:UIButtonTypeCustom];
    self.detailButton.autoresizingMask = UIViewAutoresizingFlexibleWidth+UIViewAutoresizingFlexibleLeftMargin;
    self.detailButton.frame = CGRectMake(550, 90, 0, 0);
    [self addSubview:self.detailButton];
    
    //加入圖片的視圖，但還不含圖片
    self.dishImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    //[[self.dishImageView layer] set:10];
    self.dishImageView.layer.cornerRadius = 10;
    self.dishImageView.layer.masksToBounds = YES;
    [self addSubview:self.dishImageView];
    
    //設定標題標籤
    CGFloat imgOffset = self.dishImageView.frame.size.width + self.dishImageView.frame.origin.x;
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10+imgOffset, 20, 0, 0)];
    [self addSubview:self.titleLabel];
    
    //設定價錢標籤
    
    CGFloat xPoint = self.dishImageView.frame.origin.x + 96;
    CGFloat yPoint = self.dishImageView.frame.origin.y + (185*5/6);
    self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(xPoint, yPoint, 90, (180/6))];
    self.priceLabel.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
    self.priceLabel.shadowColor = [UIColor grayColor];
    self.priceLabel.shadowOffset = CGSizeMake(1, 1);
    self.priceLabel.textColor = [UIColor blackColor];
    self.priceLabel.textAlignment = UITextAlignmentCenter;
    //self.priceLabel.text = @"NT $ 100";
    [self addSubview:self.priceLabel];
    
    //加入描述的文字視圖區
    CGPoint point = self.titleLabel.frame.origin;
    CGFloat width = self.submitButton.frame.origin.x - imgOffset - 50;
    self.descriptTextView = [[UITextView alloc] initWithFrame:CGRectMake(point.x-5, point.y+30, width, 200)];
	//self.descriptTextView.editable = YES;
    [self addSubview:self.descriptTextView];
	
	self.hotSplider = [[UISlider alloc] init];
	[self addSubview:self.hotSplider];
    
}

- (void) setImage:(UIImage *)image inFrame:(CGRect)frame{
    UIImage *noImage = [UIImage imageNamed:@"no_image.png"];
    self.dishImageView.image = image;
    if (image.CGImage != noImage.CGImage) {
        self.dishImageView.image = [self imageWithShadow:image];
    }
    
}

- (void) setSubmitButton:(NSString *)normalImageName withShadow:(BOOL)canUseShowdow{    
    UIImage *buttonImage = [UIImage imageNamed:normalImageName];
    if(canUseShowdow) buttonImage = [self imageWithShadow:buttonImage];
    //[self.submitButton setImage:buttonImage forState:UIControlStateNormal];
    //[self.submitButton setImage:[self imageWithShadow:[UIImage imageNamed:pressed]] forState:UIControlStateHighlighted];
    //CGFloat xAfterTitle = self.titleLabel.frame.origin.x + self.titleLabel.frame.size.width;
    //CGFloat yEqualTitle = self.titleLabel.frame.origin.y;
    CGFloat buttonWidth = buttonImage.size.width;//self.submitButton.imageView.image.size.width;
    CGFloat buttonHeight = buttonImage.size.height;//self.submitButton.imageView.image.size.height;
    
    self.submitButton.frame = CGRectMake(self.submitButton.frame.origin.x, self.submitButton.frame.origin.y, buttonWidth , buttonHeight);
    [self.submitButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
}

- (void) setDetailButton:(NSString *)normalImageName withShadow:(BOOL)canUseShowdow{    
    UIImage *buttonImage = [UIImage imageNamed:normalImageName];
    if(canUseShowdow) buttonImage = [self imageWithShadow:buttonImage];
    //[self.submitButton setImage:buttonImage forState:UIControlStateNormal];
    //[self.submitButton setImage:[self imageWithShadow:[UIImage imageNamed:pressed]] forState:UIControlStateHighlighted];
    //CGFloat xAfterTitle = self.titleLabel.frame.origin.x + self.titleLabel.frame.size.width;
    //CGFloat yEqualTitle = self.titleLabel.frame.origin.y;
    CGFloat buttonWidth = buttonImage.size.width;//self.submitButton.imageView.image.size.width;
    CGFloat buttonHeight = buttonImage.size.height;//self.submitButton.imageView.image.size.height;
    
    self.detailButton.frame = CGRectMake(self.detailButton.frame.origin.x, self.detailButton.frame.origin.y, buttonWidth , buttonHeight);
    [self.detailButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
}

- (void) label:(UILabel *)label withPoint:(CGPoint)point setText:(NSString *)text andFontSize:(CGFloat)size{
    CGFloat strLen = text.length;
    //self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20+imgOffset, 20, strLen*(size)+1, size+5)]
    //label.frame = CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y, strLen*(size)+1, size+5);
    label.frame = CGRectMake(point.x, point.y, strLen*(size)+1, size+5);
    label.shadowOffset = CGSizeMake(1, 1);
    label.shadowColor = [UIColor whiteColor];
    label.text = text;
    label.font = [UIFont systemFontOfSize:size];
    label.backgroundColor = [UIColor clearColor];
    
}

- (void) setDishTitle:(NSString *)title andFontSize:(CGFloat)size{
    CGPoint point = CGPointMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y);
    [self label:self.titleLabel withPoint:point setText:title andFontSize:size];
    /*CGFloat strLen = title.length;
    //self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20+imgOffset, 20, strLen*(size)+1, size+5)]
    self.titleLabel.frame = CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y, strLen*(size)+1, size+5);
    self.titleLabel.shadowOffset = CGSizeMake(1, 1);
    self.titleLabel.shadowColor = [UIColor whiteColor];
    self.titleLabel.text = title;
    self.titleLabel.font = [UIFont systemFontOfSize:size];
    self.titleLabel.backgroundColor = [UIColor clearColor];*/
}

//重新安排DishPrice的標籤吧
- (void) setDishPrice:(NSNumber *)price andFontSize:(CGFloat)size{
    CGFloat xPoint = self.frame.size.width - 150;
    CGPoint point = CGPointMake(xPoint, self.titleLabel.frame.origin.y);
    NSString *priceString = [NSString stringWithFormat:@"NT $%@",price];
    self.priceLabel.text = priceString;
    
    self.priceLabel.font =[UIFont fontWithName:@"Chalkduster" size:18];
    //self.titleLabel.text = [NSString stringWithFormat:@"%@",price];
    //NSString *titleAndPrice = [self.titleLabel.text copy];
    //[self setDishTitle:[self.titleLabel.text stringByAppendingFormat:@" NT $%@",price] andFontSize:self.titleLabel.font.pointSize];
    //NSString *priceString = [NSString stringWithFormat:@"NT $%@",price];
    //[self.submitButton setTitle:@"MMM" forState:UIControlStateNormal];
    //[self.submitButton setTitle:priceString forState:UIControlStateNormal];
    //[self label:self.priceLabel withPoint: setText:priceString andFontSize:size];
}


- (void) setDescription:(NSString *)description andFontSize:(CGFloat)fontSize withColor:(UIColor *)color{
    self.descriptTextView.text = description;
    self.descriptTextView.font = [UIFont systemFontOfSize:fontSize];
    self.descriptTextView.editable = NO;
    self.descriptTextView.textColor = color;
    self.descriptTextView.backgroundColor = [UIColor clearColor];
}

#pragma mark -
#pragma mark TableViewCell init

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [super dealloc];
}


- (UIImage*)imageWithShadow : (UIImage *)image{
    CGColorSpaceRef colourSpace = CGColorSpaceCreateDeviceRGB();
	
	size_t bits = CGImageGetBitsPerComponent(image.CGImage);
	if( bits == 0 ) bits = 8;
    CGContextRef shadowContext = CGBitmapContextCreate(NULL, image.size.width + 10, image.size.height + 10, bits, 0, 
                                                       colourSpace, kCGImageAlphaPremultipliedLast);
    CGColorSpaceRelease(colourSpace);
    
    CGContextSetShadowWithColor(shadowContext, CGSizeMake(5, -5), 5, [UIColor blackColor].CGColor);
    CGContextDrawImage(shadowContext, CGRectMake(0, 10, image.size.width, image.size.height), image.CGImage);
    
    CGImageRef shadowedCGImage = CGBitmapContextCreateImage(shadowContext);
    CGContextRelease(shadowContext);
    
    UIImage * shadowedImage = [UIImage imageWithCGImage:shadowedCGImage];
    CGImageRelease(shadowedCGImage);
    
    return shadowedImage;
}

@end
