//
//  HWMoneyPasswordManagerController.m
//  HaoWu_4.0
//
//  Created by caijingpeng.haowu on 14-7-4.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//
//  功能描述：提现密码管理页面，功能包括修改密码，忘记密码
//  修改记录：
//      

#import "HWMoneyPasswordManagerController.h"
#import "HWMoneyPasswordController.h"
#import "HWForgotMoneyPasswordController.h"
#import "HWInputBackView.h"

@interface HWMoneyPasswordManagerController ()

@end

@implementation HWMoneyPasswordManagerController
@synthesize popToViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    self.navigationItem.titleView = [Utility navTitleView:@"提现密码"];
    
    HWInputBackView *backView = [[HWInputBackView alloc] initWithFrame:CGRectMake(0, 10, kScreenWidth, 90) withLineCount:2];
    [self.view addSubview:backView];
    
    for (int i = 0; i < 2; i++)
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(backView.frame) + 10, CGRectGetMinY(backView.frame) + 45*i, backView.frame.size.width - 60, 45)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont fontWithName:FONTNAME size:15.0f];
        label.textColor = THEME_COLOR_SMOKE;
        [self.view addSubview:label];
        
        UIImageView *accessoryImgV = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(backView.frame) - 20,CGRectGetMinY(backView.frame) + 17 + i * 45, 8, 14)];
        accessoryImgV.image = [UIImage imageNamed:@"arrow"];
        [self.view addSubview:accessoryImgV];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = label.frame;
        
        [self.view addSubview:button];
        
        if (i == 0)
        {
            label.text = @"修改提现密码";
            [button addTarget:self action:@selector(modifyPassword:) forControlEvents:UIControlEventTouchUpInside];
        }
        else
        {
            label.text = @"忘记提现密码";
            [button addTarget:self action:@selector(forgotPassword:) forControlEvents:UIControlEventTouchUpInside];
        }
        
    }
}

#pragma mark ------- private method --------------

/**
 *	@brief	修改提现密码
 *
 *	@param 	sender 	按钮实例
 *
 *	@return	N/A
 */
- (void)modifyPassword:(id)sender
{
    [MobClick event:@"click_modify_cash_password"];
    HWMoneyPasswordController *moneyPwdVC = [[HWMoneyPasswordController alloc] init];
    moneyPwdVC.pwdModel = Modify_First_OldPassword;
    [self.navigationController pushViewController:moneyPwdVC animated:YES];
}

/**
 *	@brief	忘记密码
 *
 *	@param 	sender
 *
 *	@return	N/A
 */
- (void)forgotPassword:(id)sender
{
    [MobClick event:@"click_forget_cash_password"];
    HWForgotMoneyPasswordController *moneyPwdVC = [[HWForgotMoneyPasswordController alloc] init];
    moneyPwdVC.navigationItem.titleView = [Utility navTitleView:@"忘记提现密码"];
    moneyPwdVC.popToController = self.popToViewController;
    [self.navigationController pushViewController:moneyPwdVC animated:YES];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
