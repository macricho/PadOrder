    //
//  GuideSetpViewController.m
//  padOrder
//
//  Created by 均諺 on 2010/12/5.
//  Copyright 2010 Macricho. All rights reserved.
//

#import "GuideSetpViewController.h"


@implementation GuideSetpViewController


- (void) actionToNext:(id)sender{
    UIButton *button = (UIButton *)sender;
    if (button.tag == 11) {
        //返回
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (button.tag == 12){
        //下一個
        button.tag = 0;
        [self.padOrderDelegate actionToNext:button];
    }
}

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id) init{
    self = [super initWithNibName:@"GuideSetpView" bundle:[NSBundle mainBundle]];
    if (self) {
    }
    return self;
}

/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.tag = 0;
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
        //self.navigationController.navigationBarHidden = NO;
    self.topTitleLabel.text = [NSString stringWithFormat:@"Step %d/5~",self.view.tag];
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated]; 
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
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
