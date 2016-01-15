//
//  HWForgotMoneyPasswordController.m
//  HaoWu_4.0
//
//  Created by caijingpeng.haowu on 14-7-7.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//
//  功能描述：忘记提现密码和设置提现密码，验证登录密码页面
//  修改记录：
//

#import "HWForgotMoneyPasswordController.h"
#import "HWInputBackView.h"
#import "HWMoneyPasswordController.h"
#import "Define-OC.h"
#import "Partner_Swift-Swift.h"

@interface HWForgotMoneyPasswordController ()
{
    UITextField *_loginPwdTF;
}

@end

@implementation HWForgotMoneyPasswordController
@synthesize logic;
@synthesize popToController;

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
    
//    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self _selector:@selector(backMethod)];
    
    UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, self.view.frame.size.width - 30, 25)];
    infoLabel.font = [UIFont fontWithName:FONTNAME size:13.0f];
#warning color
//    infoLabel.textColor = THEME_COLOR_TEXT;
    
    infoLabel.text = @"请先设置提现密码，以保护您的资金安全。";
    [self.view addSubview:infoLabel];
    if (self.logic == 0)
    {
        infoLabel.hidden = YES;
    }
    
    HWInputBackView *backView = [[HWInputBackView alloc] initWithFrame:CGRectMake(0, (self.logic == 0 ? 10 : (CGRectGetMaxY(infoLabel.frame) + 10)), kScreenWidth, 45) withLineCount:1];
    [self.view addSubview:backView];
    
    
    _loginPwdTF = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(backView.frame) + 10, CGRectGetMinY(backView.frame) + 15, self.view.frame.size.width - 20, 20)];
    _loginPwdTF.font = [UIFont fontWithName:FONTNAME size:15.0f];
#warning color
//    _loginPwdTF.textColor = THEME_COLOR_SMOKE;
    _loginPwdTF.placeholder = @"输入登录密码以验证身份";
    _loginPwdTF.secureTextEntry = YES;
    [self.view addSubview:_loginPwdTF];
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.titleLabel.font = [UIFont fontWithName:FONTNAME size:18];
    nextBtn.frame = CGRectMake(15, CGRectGetMaxY(backView.frame) + 20, self.view.frame.size.width - 30, 50);
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [nextBtn setButtonRedAndOrangeBorderStyle];
    [nextBtn addTarget:self action:@selector(nextStep:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
    
}

#pragma mark ------- private method ----------

/**
 *	@brief	按钮下一步点击事件，验证登录密码
 *
 *	@param 	sender 	按钮变量
 *
 *	@return	N/A
 */
- (void)nextStep:(id)sender
{
    // 验证登录密码
    [Utility showMBProgress:self.view _message:LOADING_TEXT];
    HWHttpRequestOperationManager *manager = [HWHttpRequestOperationManager baseManager];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [param setPObject:_loginPwdTF.text forKey:@"passwd"];
    [param setPObject:@"1" forKey:@"channel"];
    
    [manager postHttpRequest:kCheckLoginPassword parameters:param queue:nil success:^(NSDictionary *responseObject) {
        [Utility hideMBProgress:self.view];
        
        // 验证成功 设置新提现密码
        
        HWMoneyPasswordController *moneyPwdVC = [[HWMoneyPasswordController alloc] init];
        if (self.logic == LogicLine_GetMoney)
        {
            moneyPwdVC.logic = LogicLine_GetMoney;
        }
        else if (self.logic == LogicLine_BindCard)
        {
            moneyPwdVC.logic = LogicLine_BindCard;
        }
        moneyPwdVC.pwdModel = Forgot_First_NewPassword;
        moneyPwdVC.tishiMode = Setting_Password;
        moneyPwdVC.popToViewController = self.popToController;
        [self.navigationController pushViewController:moneyPwdVC animated:YES];
    } failure:^(NSString *code, NSString *error) {
        [Utility hideMBProgress:self.view];
        [Utility showToastWithMessage:error _view:self.view];
    }];

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
