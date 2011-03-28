    //
//  padOrderViewController.m
//  padOrder
//
//  Created by Macric Cho on 2010/11/2.
//  Copyright 2010 Macricho. All rights reserved.
//

#import "padOrderViewController.h"
#import "padOrderAppDelegate.h"

@implementation padOrderViewController
@synthesize topTitleLabel;
@synthesize imageBgView;
@synthesize padOrderDelegate;

- (UIImage*)imageWithShadow : (UIImage *)image{
    CGColorSpaceRef colourSpace = CGColorSpaceCreateDeviceRGB();
    
    size_t bitsPerComponent = CGImageGetBitsPerComponent(image.CGImage);
    if (bitsPerComponent == 0) bitsPerComponent = 8;
    
    CGContextRef shadowContext = CGBitmapContextCreate(NULL, image.size.width + 10, image.size.height + 10, bitsPerComponent, 0, 
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



 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
        //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg-pattern.png"]];
    }
    return self;
}


/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.padOrderDelegate = [[UIApplication sharedApplication] delegate];
    
    //UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:self.view.frame];
    //backgroundView.image = [UIImage imageNamed:@"tableViewBackground.png"];

    self.imageBgView.image = [self imageWithShadow:self.imageBgView.image];
    
        //[self.view insertSubview:backgroundView aboveSubview:self.view];
    //[self.view addSubview:backgroundView];
    self.topTitleLabel.transform = CGAffineTransformMakeRotation(-0.05f);
    self.topTitleLabel.font = [UIFont fontWithName:@"Zapfino" size:45];
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"bg-pattern.png"]];
    
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}




@end
