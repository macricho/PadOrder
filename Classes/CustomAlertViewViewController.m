//
//  CustomAlertViewViewController.m
//  padOrder
//
//  Created by 均諺 on 2010/11/19.
//  Copyright 2010 Macricho. All rights reserved.
//

#import "CustomAlertViewViewController.h"


@implementation CustomAlertViewViewController
-(IBAction) buttonPressed:(id)sender{
    myAlertView=[[UIAlertView alloc] initWithTitle:@"系統登入" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"登入",nil];
    [myAlertView show];
    [myAlertView release];
    
}

- (void)willPresentAlertView:(UIAlertView *)alertView
{
    CGRect frame = alertView.frame;
    if( alertView==myAlertView )
    {
        frame.origin.y -= 120;
        frame.size.height += 80;
        alertView.frame = frame;
        for( UIView * view in alertView.subviews )
        {
                //列舉alertView中所有的物件
            if( ![view isKindOfClass:[UILabel class]] )
            {
                    //若不UILable則另行處理
                if (view.tag==1)
                {
                        //處理第一個按鈕，也就是 CancelButton
                    CGRect btnFrame1 =CGRectMake(30, frame.size.height-65, 105, 40);
                    view.frame = btnFrame1;
                    
                } else if  (view.tag==2){
                        //處理第二個按鈕，也就是otherButton    
                    CGRect btnFrame2 =CGRectMake(142, frame.size.height-65, 105, 40);
                    view.frame = btnFrame2;               
                }
            }
        }
        
            //加入自訂的label及UITextFiled
        UILabel *lblaccountName=[[UILabel alloc] initWithFrame:CGRectMake( 30, 50,60, 30 )];;
        lblaccountName.text=@"帳號：";
        lblaccountName.backgroundColor=[UIColor clearColor];
        lblaccountName.textColor=[UIColor whiteColor];
        
        UITextField *accoutName = [[UITextField alloc] initWithFrame: CGRectMake( 85, 50,160, 30 )];   
        accoutName.placeholder = @"帳號名稱";
        accoutName.borderStyle=UITextBorderStyleRoundedRect;
        
        
        UILabel *lblaccountPassword=[[UILabel alloc] initWithFrame:CGRectMake( 30, 85,60, 30 )];;
        lblaccountPassword.text=@"密碼：";
        lblaccountPassword.backgroundColor=[UIColor clearColor];
        lblaccountPassword.textColor=[UIColor whiteColor];
        
        UITextField *accoutPassword = [[UITextField alloc] initWithFrame: CGRectMake( 85, 85,160, 30 )];   
        accoutPassword.placeholder = @"登入密碼";
        accoutPassword.borderStyle=UITextBorderStyleRoundedRect;
            //輸入的資料以星號顯示（密碼資料）
        accoutPassword.secureTextEntry=YES;
        
        [alertView addSubview:lblaccountName];
        [alertView addSubview:accoutName];         
        [alertView addSubview:lblaccountPassword];
        [alertView addSubview:accoutPassword];
    }
}

- (void)dealloc {
    [myAlertView release];
    [super dealloc];
}
@end
