//
//  HWForgetViewController.m
//  Community
//
//  Created by caijingpeng.haowu on 14-8-28.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//
//  忘记密码 发送校验
//

#import "HWForgetFirstViewController.h"
#import "HWInputBackView.h"
#import "HWForgetSecondViewController.h"
#import "HWHTTPRequestOperationManager.h"
#import "HWRequestConfig.h"
@interface HWForgetFirstViewController ()
{
    UITextField *_telephoneTF;
    UIButton *_sendCodeBtn;
}
@end

@implementation HWForgetFirstViewController
@synthesize telephoneNum;
@synthesize isChangePwd;
@synthesize popToViewController;

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
//    self.navigationItem.titleView = [Utility navTitleView:@"修改密码"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    
    HWInputBackView *backView = [[HWInputBackView alloc] initWithFrame:CGRectMake(0, 10, kScreenWidth, 45) withLineCount:1];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    UILabel *prefixLab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMinY(backView.frame) + 0.5f, 57, CGRectGetHeight(backView.frame) - 1)];
    prefixLab.backgroundColor = THEME_COLOR_TEXTBACKGROUND;
    prefixLab.textAlignment = NSTextAlignmentCenter;
    prefixLab.textColor = THEME_COLOR_TEXT;
    prefixLab.text = @"+ 86";
    prefixLab.font = [UIFont fontWithName:FONTNAME size:15.0f];
    [self.view addSubview:prefixLab];
    
    UIView *verticalLine = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(prefixLab.frame), CGRectGetMinY(backView.frame), 0.5f, CGRectGetHeight(backView.frame))];
    verticalLine.backgroundColor = THEME_COLOR_LINE;
    [self.view addSubview:verticalLine];
    
    _telephoneTF = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetWidth(prefixLab.frame) + 10, CGRectGetMinY(backView.frame) + 7.5f + (!IOS7 ? 5 : 0), kScreenWidth - CGRectGetWidth(prefixLab.frame) - 20, 30)];
    _telephoneTF.backgroundColor = [UIColor clearColor];
    _telephoneTF.placeholder = @"请输入手机号";
    _telephoneTF.font = [UIFont fontWithName:FONTNAME size:15.0f];
    _telephoneTF.textColor = THEME_COLOR_SMOKE;
    _telephoneTF.clearButtonMode = UITextFieldViewModeWhileEditing;
//    if (!IOS8)
//    {
//        _telephoneTF.keyboardType = UIKeyboardTypeNamePhonePad;
//    }
    _telephoneTF.keyboardType = UIKeyboardTypeNumberPad;
    
    _telephoneTF.delegate = self;
    
    
    
    [self.view addSubview:_telephoneTF];
    
    _sendCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _sendCodeBtn.frame = CGRectMake(15, CGRectGetMaxY(backView.frame) + 20, kScreenWidth - 30, 45);
    [_sendCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    [_sendCodeBtn setButtonOrangeStyle];
    [_sendCodeBtn setInactiveState];
    [_sendCodeBtn addTarget:self action:@selector(sendCodeRequest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_sendCodeBtn];
    
    if (self.isChangePwd)
    {
        _telephoneTF.userInteractionEnabled = NO;
        _telephoneTF.text = [HWUserLogin currentUserLogin].telephoneNum;
        [_sendCodeBtn setActiveState];
    }
    
    if (self.telephoneNum != nil)
    {
        _telephoneTF.text = self.telephoneNum;
        [_sendCodeBtn setActiveState];
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doTap:)];
    [self.view addGestureRecognizer:tap];
    
}

#pragma mark -
#pragma mark Private method

- (void)doTap:(id)sender
{
    [self.view endEditing:YES];
}

//发送验证码请求
-(void)sendCodeRequest
{
    [MobClick event:@"click_forgot_password"];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSDate *lastSMSDate = [ud objectForKey:KLastSMSDate];
    if (lastSMSDate)
    {
        NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:lastSMSDate];
        if (interval < 60)
        {
            [Utility showToastWithMessage:@"爱卿~60秒内只能验证一次哟" inView:self.view];
            return;
        }
    }
    else
    {
        [ud setObject:[NSDate date] forKey:KLastSMSDate];
        [ud synchronize];
    }

    [self.view endEditing:YES];
    [MobClick event:@"click_get_code"];
    [Utility showMBProgress:self.view message:@"正在发送验证码"];
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setPObject:_telephoneTF.text forKey:@"mobileNumber"];
    [dict setPObject:[Utility getUUID] forKey:@"mac"];
    [dict setPObject:@"1" forKey:@"smsType"];
    [manager POST:kForgetSendVertify parameters:dict queue:nil success:^(id responseObject){
        
        [Utility hideMBProgress:self.view];
        [ud setObject:[NSDate date] forKey:KLastSMSDate];
        
        if (responseObject)
        {
            NSDictionary *dicTemp = (NSDictionary *)responseObject;
            NSString *shangxingMessagePhoneStr = [dicTemp objectForKey:@"data"];
            NSString *status = [dicTemp objectForKey:@"status"];
            if ([status isEqualToString:@"1"]) {
                [self sendCode:_telephoneTF.text shangXingMessagePhone:shangxingMessagePhoneStr];
                
            }
        }

    } failure:^(NSString *code, NSString *error) {
        [Utility hideMBProgress:self.view];
        [Utility showToastWithMessage:error inView:self.view];
    }];
    
}

- (void)sendCode:(NSString *)phoneNum shangXingMessagePhone:(NSString *)shangxingPhoneNum
{
    [MobClick event:@"click_finish_modify_password"];
    HWForgetSecondViewController *secondVC = [[HWForgetSecondViewController alloc] init];
    secondVC.telephoneNum = phoneNum;
    secondVC.shangxingMessagePhone = shangxingPhoneNum;
    secondVC.isChangePwd = self.isChangePwd;
    secondVC.popToViewController = self.popToViewController;
    [self.navigationController pushViewController:secondVC animated:YES];
}

- (void)sendCode
{
    HWForgetSecondViewController *secondVC = [[HWForgetSecondViewController alloc] init];
    secondVC.isChangePwd = YES;
    secondVC.popToViewController = self.popToViewController;
    [self.navigationController pushViewController:secondVC animated:YES];
}

#pragma mark -
#pragma mark TextField Delegate method

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSMutableString *text = [textField.text mutableCopy];
    [text replaceCharactersInRange:range withString:string];
    if (text.length > 11 && range.length == 0)
    {
        return NO;
    }
    
    if (text.length != 11 && IOS7)
    {
        [_sendCodeBtn setInactiveState];
    }
    else if (![Utility validateMobile:text])
    {
        [_sendCodeBtn setInactiveState];
    }
    else
    {
        [_sendCodeBtn setActiveState];
    }
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    [_sendCodeBtn setInactiveState];
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
