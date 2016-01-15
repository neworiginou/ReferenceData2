//
//  HWForgetThirdViewController.m
//  Community
//
//  Created by caijingpeng.haowu on 14-8-28.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//


#import "HWForgetThirdViewController.h"
#import "HWInputBackView.h"
#import "HWHTTPRequestOperationManager.h"   
#import "HWRequestConfig.h"
#import "AppDelegate.h"
#import "HWHomePageViewController.h"
#import "HWLoginViewController.h"

@interface HWForgetThirdViewController ()
{
    UITextField *_pwdTF;
    UIButton *_confirmBtn;
}
@end

@implementation HWForgetThirdViewController
@synthesize telephoneNum,isChangePwd;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        isChangePwd = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.titleView = [Utility navTitleView:@"设置密码"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    
    HWInputBackView *backView = [[HWInputBackView alloc] initWithFrame:CGRectMake(0, 12, kScreenWidth, 45.0f) withLineCount:1];
    [self.view addSubview:backView];
    
    _pwdTF = [[UITextField alloc] initWithFrame:CGRectMake(15, CGRectGetMinY(backView.frame) + 7.5f + (!IOS7 ? 5 : 0), kScreenWidth - 30.0f, 30)];
    _pwdTF.textColor = THEME_COLOR_SMOKE;
    _pwdTF.placeholder = @"设置密码";
    _pwdTF.delegate = self;
    _pwdTF.secureTextEntry = YES;
    _pwdTF.font = [UIFont fontWithName:FONTNAME size:15.0f];
    _pwdTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_pwdTF];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(backView.frame) + 20, kScreenWidth - 30.0f, 15)];
    label.textColor = THEME_COLOR_TEXT;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:FONTNAME size:15.0f];
    label.text = @"密码长度6 ~ 20位密码，字母或数字";
    [self.view addSubview:label];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.frame = CGRectMake(15.0f, CGRectGetMaxY(label.frame) + 20.0f, kScreenWidth - 30.0f, 45.0f);
    [_confirmBtn setTitle:@"提交" forState:UIControlStateNormal];
    [_confirmBtn setButtonOrangeStyle];
    [_confirmBtn setInactiveState];
    [_confirmBtn addTarget:self action:@selector(setNewPassward) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_confirmBtn];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doTap:)];
    [self.view addGestureRecognizer:tap];
}

#pragma mark -
#pragma mark Private method

- (void)doTap:(id)sender
{
    [self.view endEditing:YES];
}

//设置新密码
- (void)setNewPassward
{
    [MobClick event:@"click_submit"];
    
    if (_pwdTF.text.length < 6 || _pwdTF.text.length > 20)
    {
        [Utility showToastWithMessage:@"密码必须为6-20位" inView:self.view];
        return;
    }
    
    if (![Utility validatePassword:_pwdTF.text])
    {
        [Utility showToastWithMessage:@"密码过于简单，请重新输入" inView:self.view];
        return;
    }
    [self.view endEditing:YES];
    
    [Utility showMBProgress:self.view message:LOADING_TEXT];
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setPObject:telephoneNum forKey:@"mobileNumber"];
    [dict setPObject:_pwdTF.text forKey:@"newPass"];
    [manager POST:kSettingNewPassward parameters:dict queue:nil success:^(id responseObject){
        [Utility hideMBProgress:self.view];
        AppDelegate *appDel = (AppDelegate *)SHARED_APP_DELEGATE;
        [Utility showToastWithMessage:@"修改成功" inView:appDel.window];
        [self doConfirm];
    } failure:^(NSString *code, NSString *error) {
        [Utility hideMBProgress:self.view];
        [Utility showToastWithMessage:error inView:self.view];
    }];
}
/**
 *	@brief	提交按钮
 *
 *	@param 	sender
 *
 *	@return
 */
- (void)doConfirm
{
    AppDelegate *appDel = (AppDelegate *)SHARED_APP_DELEGATE;
    if (self.isChangePwd)
    {
        HWHomePageViewController *homePageVC = [[HWHomePageViewController alloc] init];
        HWBaseNavigationController *nav = [[HWBaseNavigationController alloc] initWithRootViewController:homePageVC];
        [appDel.window.rootViewController presentViewController:nav animated:NO completion:nil];
//        [homePageVC toLogin:nil];
        [homePageVC gotoLogin:self.telephoneNum];
    }
    else
    {
        if (self.popToViewController != nil)
        {
            if ([self.popToViewController isKindOfClass:[HWLoginViewController class]])
            {
                HWLoginViewController *loginVC = (HWLoginViewController *)self.popToViewController;
                loginVC.usernameTF.text = self.telephoneNum;
            }
            [self.navigationController popToViewController:self.popToViewController animated:YES];
        }
    }
    
    
}

#pragma mark -
#pragma mark TextField Delegate method

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSMutableString *text = [textField.text mutableCopy];
    [text replaceCharactersInRange:range withString:string];
    if (text.length < 6)
    {
        [_confirmBtn setInactiveState];
    }
    else
    {
        [_confirmBtn setActiveState];
    }
    
    NSString *beStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (beStr.length > 20) {
        return NO;
    }
    return YES;
    
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [MobClick event:@"get_focus_password"];
    return YES;
}

#pragma mark -
#pragma mark System method

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
