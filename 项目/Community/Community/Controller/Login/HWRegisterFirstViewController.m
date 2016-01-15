//
//  HWRegisterFirstViewController.m
//  Community
//
//  Created by caijingpeng.haowu on 14-8-28.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//  功能描述：注册页面
//
//  修改记录
//      李中强 2015-01-28 修改进入此页，就能点击发送验证码的BUG
//

#import "HWRegisterFirstViewController.h"
#import "HWLoginViewController.h"
#import "HWRegisterSecondViewController.h"
#import "HWInputBackView.h"
#import "HWRequestConfig.h"
#import "HWHTTPRequestOperationManager.h"
#import "CustomerProtocolViewController.h"
#import "AppDelegate.h"

@interface HWRegisterFirstViewController ()
{
    UIButton *_sendCodeBtn;
    UIImageView *_cubeImgV;
}

@end

@implementation HWRegisterFirstViewController
@synthesize telephoneTF = _telephoneTF;

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
    
    self.navigationItem.titleView = [Utility navTitleView:@"注册"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    self.navigationController.navigationBarHidden = NO;
    
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
    _telephoneTF.keyboardType = UIKeyboardTypeNumberPad;
    _telephoneTF.delegate = self;
    [self.view addSubview:_telephoneTF];
    
    _sendCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _sendCodeBtn.frame = CGRectMake(15, CGRectGetMaxY(backView.frame) + 20, kScreenWidth - 30, 45);
    [_sendCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_sendCodeBtn setButtonOrangeStyle];
//    if (self.telephoneTF.text)
//    {
//        [_sendCodeBtn setActiveState];
//    }
//    else
//    {
//        [_sendCodeBtn setInactiveState];
//    }
    //修改默认状态
    if (_telephoneTF.text.length != 11 || ![Utility validateMobile:_telephoneTF.text])
    {
        [_sendCodeBtn setInactiveState];
    }
    else
    {
        [_sendCodeBtn setActiveState];
    }
    
    [_sendCodeBtn addTarget:self action:@selector(sendCodeRequest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_sendCodeBtn];
    
    float height = CGRectGetMaxY(_sendCodeBtn.frame) + 20;
    
    _cubeImgV = [[UIImageView alloc] initWithFrame:CGRectMake(15, height, 15, 15)];
    _cubeImgV.backgroundColor = [UIColor whiteColor];
    _cubeImgV.layer.borderColor = UIColorFromRGB(0xdfe0da).CGColor;
    _cubeImgV.layer.borderWidth = 0.5f;
    _cubeImgV.image = [UIImage imageNamed:@"check"];
    [self.view addSubview:_cubeImgV];
    
    UIButton *checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    checkButton.frame = CGRectMake(0, 0, 20, 20);
    checkButton.center = _cubeImgV.center;
    [checkButton addTarget:self action:@selector(toCheck:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:checkButton];
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:@"同意考拉社区用户协议"];
    [string addAttribute:NSForegroundColorAttributeName value:(id)THEME_COLOR_TEXT range:NSMakeRange(0, [string length])];
    [string addAttribute:NSUnderlineStyleAttributeName value:(id)[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(0, [string length])];
//    [string addAttribute:NSFontAttributeName value:(id)[UIFont fontWithName:FONTNAME size:15.0f] range:NSMakeRange(0, [string length])];
    [string addAttribute:NSFontAttributeName value:(id)[UIFont systemFontOfSize:15.0] range:NSMakeRange(0, [string length])];
    UIButton *treatyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    treatyBtn.frame = CGRectMake(CGRectGetMaxX(_cubeImgV.frame) + 5, height - 5, 155, 25);
    [treatyBtn setAttributedTitle:string forState:UIControlStateNormal];
    [treatyBtn addTarget:self action:@selector(pushTreatment:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:treatyBtn];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doTap:)];
    [self.view addGestureRecognizer:tap];
    
}
#pragma mark -
#pragma mark private method

- (void)doTap:(id)sender
{
    [self.view endEditing:YES];
}

//发送验证码请求
-(void)sendCodeRequest
{
    [MobClick event:@"verifycode_click_getcode"];//1.7
    
    [self.view endEditing:YES];
    
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
    }
    
    [Utility showMBProgress:self.view message:@"正在发送验证码"];
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setPObject:_telephoneTF.text forKey:@"mobileNumber"];
    [dict setPObject:[Utility getUUID] forKey:@"mac"];
    
    [manager POST:kRegisterSendVertify parameters:dict queue:nil success:^(id responseObject) {
        
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
        
        if (error.intValue == kStatusQiangQianBao)
        {
            HWLoginViewController *loginVC = [[HWLoginViewController alloc] init];
            loginVC.telephone = _telephoneTF.text;
            [self.navigationController pushViewController:loginVC animated:YES];
            
            AppDelegate *appDel = (AppDelegate *)SHARED_APP_DELEGATE;
//            [Utility showAlertWithMessage:@"亲，抢钱宝的用户可以直接登入考拉社区哦"];
            [Utility showToastWithMessage:@"亲，抢钱宝的用户可以直接登入考拉社区哦" inView:appDel.window];
        }
        else if ([error isEqualToString:@"该手机号码已注册过"])
        {
            HWLoginViewController *loginVC = [[HWLoginViewController alloc] init];
            loginVC.telephone = _telephoneTF.text;
            [self.navigationController pushViewController:loginVC animated:YES];
            
            AppDelegate *appDel = (AppDelegate *)SHARED_APP_DELEGATE;
            [Utility showToastWithMessage:@"该手机号码已注册过,请登录" inView:appDel.window];
        }
        else
        {
            [Utility showToastWithMessage:error inView:self.view];
        }
        
//        NSLog(@"error");
    }];
    
}
/**
 *	@brief	发送验证码
 *
 *	@param 	sender
 *
 *	@return	N/A
 */
- (void)sendCode:(NSString *)phoneNum shangXingMessagePhone:(NSString *)shangxingPhoneNum
{
    HWRegisterSecondViewController *secondVC = [[HWRegisterSecondViewController alloc] init];
    secondVC.telephoneNum = phoneNum;
    secondVC.shangxingMessagePhone = shangxingPhoneNum;
    [self.navigationController pushViewController:secondVC animated:YES];
}

/**
 *	@brief	查看用户注册协议
 *
 *	@param 	sender
 *
 *	@return	N/A
 */
- (void)pushTreatment:(id)sender
{
    CustomerProtocolViewController *treatyVC = [[CustomerProtocolViewController alloc] init];
    [self.navigationController pushViewController:treatyVC animated:YES];
}

/**
 *	@brief	已经注册 push登录界面
 *
 *	@return
 */
- (void)alreadyRegiste
{
    HWLoginViewController *loginVC = [[HWLoginViewController alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];
}

/**
 *	@brief	发送成功
 *
 *	@return
 */
- (void)sendSuccess
{
    HWRegisterSecondViewController *valideCodeVC = [[HWRegisterSecondViewController alloc] init];
    valideCodeVC.telephoneNum = _telephoneTF.text;
    [self.navigationController pushViewController:valideCodeVC animated:YES];
}

/**
 *	@brief	确认 同意用户协议
 *
 *	@param 	sender
 *
 *	@return
 */
- (void)toCheck:(id)sender
{
    [MobClick event:@"click_useragreement"];
    if (_cubeImgV.image == [UIImage imageNamed:@"login-select_icon1"])
    {
        _cubeImgV.image = [UIImage imageNamed:@"login-select_icon2"];
        
        if (_telephoneTF.text.length != 11 || ![Utility validateMobile:_telephoneTF.text])
        {
            [_sendCodeBtn setInactiveState];
        }
        else
        {
            [_sendCodeBtn setActiveState];
        }
        
    }
    else
    {
        _cubeImgV.image = [UIImage imageNamed:@"login-select_icon1"];
        [_sendCodeBtn setInactiveState];
    }
}

#pragma mark -
#pragma mark textfield delegate

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
        if (_cubeImgV.image != nil)
        {
            [_sendCodeBtn setActiveState];
        }
        else
        {
            [_sendCodeBtn setInactiveState];
        }
    }
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    [_sendCodeBtn setInactiveState];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [MobClick event:@"get_focus_phonenumberregister"]; //maidian_1.2.1
    [MobClick event:@"get_focus_phonenumber"];
    return YES;
}

#pragma mark -
#pragma mark system method

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
