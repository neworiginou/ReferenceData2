//
//  HWRegisterViewController.m
//  Community
//
//  Created by hw500027 on 15/4/7.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：注册界面
//  修改记录：
//	姓名     日期         修改内容
//  陆晓波   2015-04-07   文件创建
//  陆晓波   2015-04-08   验证码按钮 添加语音播放


#import "HWRegisterViewController.h"
#import "HWRegisterThirdViewController.h"
#import "CustomerProtocolViewController.h"
#import "HWIdentifyingCodeButton.h"
#import "HWInputBackView.h"
#import "HWLoginViewController.h"
#import "AppDelegate.h"
#define kWidthDistance  15

@interface HWRegisterViewController ()<UITextFieldDelegate,HWIdentifyingCodeButtonDelegate>
{
    HWIdentifyingCodeButton *_sendCodeBtn;
    UIButton *_confirmBtn;
    UIImageView *_cubeImgV;
}
@end

@implementation HWRegisterViewController

-(void)dealloc
{
    [_sendCodeBtn.timer invalidate];
    _sendCodeBtn.timer = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.titleView = [Utility navTitleView:@"注册"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    self.navigationController.navigationBarHidden = NO;

    [self addTelphoneTextField];
    [self addCodeTextField];
    [self addCodeBtn];
    [self addConfirmBtn];
    [self addAgreeBtn];
    [self addTap];
    // Do any additional setup after loading the view.
}

#pragma mark -
#pragma mark 添加验证码按钮
-(void)addCodeBtn
{
    _sendCodeBtn = [[HWIdentifyingCodeButton alloc]init];
    _sendCodeBtn.identifyingCodeButtonDelegate = self;
    [self.view addSubview:_sendCodeBtn];

    _sendCodeBtn.frame = CGRectMake(0, 0, 214 / 2, 70 / 2);
    [_sendCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    _sendCodeBtn.layer.masksToBounds = YES;
    _sendCodeBtn.layer.cornerRadius = 3;
    //[_sendCodeBtn setBackgroundColor:BUTTON_COLOR_LIGHTGRAY];
    [_sendCodeBtn setBackgroundImage:[Utility imageWithColor:THEBUTTON_GREEN_NORMAL andSize:_sendCodeBtn.frame.size] forState:UIControlStateNormal];
    [_sendCodeBtn setBackgroundImage:[Utility imageWithColor:THEBUTTON_GREEN_HIGHLIGHT andSize:_sendCodeBtn.frame.size] forState:UIControlStateHighlighted];
    _sendCodeBtn.titleLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
    [_sendCodeBtn addTarget:self action:@selector(sendCodeRequest) forControlEvents:UIControlEventTouchUpInside];
    _sendCodeBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [_sendCodeBtn autoSetDimensionsToSize:CGSizeMake(_sendCodeBtn.frame.size.width, _sendCodeBtn.frame.size.height)];
    [_sendCodeBtn autoAlignAxis:ALAxisBaseline toSameAxisOfView:_codeTF];
    [_sendCodeBtn autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.view withOffset:-kWidthDistance];
    
    //修改默认状态
    if (_telphoneTF.text.length != 11 || ![Utility validateMobile:_telphoneTF.text])
    {
        [_sendCodeBtn setInactiveState];
    }
    else
    {
        //[_sendCodeBtn setActiveState];
        _sendCodeBtn.userInteractionEnabled = YES;
        _sendCodeBtn.titleLabel.alpha = 1.0f;
    }
}

-(void)sendCodeRequest
{
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
    [Utility showMBProgress:self.view message:@"正在获取验证码"];
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setPObject:_telphoneTF.text forKey:@"mobileNumber"];
    [dict setPObject:[Utility getUUID] forKey:@"mac"];
    [dict setPObject:@"1" forKey:@"smsType"];//smsType 1.短信验证码，2语音验证码
    [manager POST:kRegisterSendVertify parameters:dict queue:nil success:^(id responseObject) {
        [Utility hideMBProgress:self.view];
        [ud setObject:[NSDate date] forKey:KLastSMSDate];
        
        //成功发送验证码，取消点击事件
        [_sendCodeBtn removeTarget:self action:@selector(sendCodeRequest) forControlEvents:UIControlEventTouchUpInside];
        //按钮点击动画
        [_sendCodeBtn btnFirstClick];
    } failure:^(NSString *code, NSString *error) {
        [Utility hideMBProgress:self.view];
        if ([error isEqualToString:@"亲，抢钱宝的用户可以直接登入考拉社区哦"])
        {
            HWLoginViewController *loginVC = [[HWLoginViewController alloc] init];
            loginVC.telephone = _telphoneTF.text;
            [self.navigationController pushViewController:loginVC animated:YES];
            
            AppDelegate *appDel = (AppDelegate *)SHARED_APP_DELEGATE;
            [Utility showToastWithMessage:@"亲，抢钱宝的用户可以直接登入考拉社区哦" inView:appDel.window];
        }
        else if ([error isEqualToString:@"该手机号码已注册过"])
        {
            HWLoginViewController *loginVC = [[HWLoginViewController alloc] init];
            loginVC.telephone = _telphoneTF.text;
            [self.navigationController pushViewController:loginVC animated:YES];
            
            AppDelegate *appDel = (AppDelegate *)SHARED_APP_DELEGATE;
            [Utility showToastWithMessage:@"该手机号码已注册过,请登录" inView:appDel.window];
        }
        else
        {
            [Utility showToastWithMessage:error inView:self.view];
        }
    }];
}

#pragma mark -
#pragma mark 验证码按钮 代理
-(void)btnPlaySound
{
    [_sendCodeBtn addTarget:self action:@selector(toPlaySound) forControlEvents:UIControlEventTouchUpInside];
}

-(void)toPlaySound
{
    NSLog(@"toPlaySound");
    [MobClick event:@"click_get_code"];
    [Utility showMBProgress:self.view message:@"正在获取验证码"];
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setPObject:_telphoneTF.text forKey:@"mobileNumber"];
    [dict setPObject:[Utility getUUID] forKey:@"mac"];
    [dict setPObject:@"2" forKey:@"smsType"];//smsType 1.短信验证码，2语音验证码
    [manager POST:kRegisterSendVertify parameters:dict queue:nil success:^(id responseObject){
        [Utility hideMBProgress:self.view];
        [Utility show3SecondToastWithMessage:@"验证码将以电话(号段为021)的\n形式通知到请您注意接听" inView:self.view];
    } failure:^(NSString *code, NSString *error) {
        [Utility hideMBProgress:self.view];
        [Utility showToastWithMessage:error inView:self.view];
    }];
    
    [_sendCodeBtn btnFirstClick];

}

#pragma mark -
#pragma mark 配置textfield
-(void)configTextField:(UITextField *)textField
{
    textField.layer.masksToBounds = YES;
    textField.layer.cornerRadius = 3;
    textField.backgroundColor = [UIColor whiteColor];
    textField.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
    textField.textColor = THEME_COLOR_SMOKE;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    if (textField == _telphoneTF)
    {
        textField.keyboardType = UIKeyboardTypeNumberPad;
    }
    else
    {
        textField.keyboardType = UIKeyboardTypeDefault;
    }
    textField.delegate = self;
}

#pragma mark --添加 手机号textfield
-(void)addTelphoneTextField
{
    HWInputBackView *intputView = [[HWInputBackView alloc]initWithFrame:CGRectMake(0, 10, kScreenWidth, 45) withLineCount:1];
    intputView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:intputView];
    
    _telphoneTF = [UITextField newAutoLayoutView];
    [self.view addSubview:_telphoneTF];
    [self configTextField:_telphoneTF];
    _telphoneTF.placeholder = @"请输入手机号";
    
    [_telphoneTF autoAlignAxis:ALAxisHorizontal toSameAxisOfView:intputView];
    [_telphoneTF autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.view withOffset:kWidthDistance];
    [_telphoneTF autoSetDimension:ALDimensionHeight toSize:30];
    [_telphoneTF autoSetDimension:ALDimensionWidth toSize:kScreenWidth - kWidthDistance * 2];
}

#pragma mark --添加 验证码textfield
-(void)addCodeTextField
{
    HWInputBackView *intputView = [[HWInputBackView alloc]initWithFrame:CGRectMake(0, 10 + 45, kScreenWidth, 45) withLineCount:1];
    intputView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:intputView];
    
    _codeTF = [UITextField newAutoLayoutView];
    [self.view addSubview:_codeTF];
    [self configTextField:_codeTF];
    _codeTF.placeholder = @"输入验证码";
    
    [_codeTF autoAlignAxis:ALAxisHorizontal toSameAxisOfView:intputView];
    [_codeTF autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_telphoneTF];
    [_codeTF autoSetDimension:ALDimensionHeight toSize:30];
    [_codeTF autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:intputView withOffset:-125];
}

#pragma mark -
#pragma mark 添加收键盘手势
-(void)addTap
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doTap)];
    [self.view addGestureRecognizer:tap];
}

//实现收键盘手势
-(void)doTap
{
    [self.view endEditing:YES];
}

#pragma mark -
#pragma mark 添加提交按钮
-(void)addConfirmBtn
{
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.frame = CGRectMake(0, 0, kScreenWidth - kWidthDistance * 2, 45.0f);
    [_confirmBtn setButtonOrangeStyle];
    [_confirmBtn setTitle:@"提交" forState:UIControlStateNormal];
    [_confirmBtn setInactiveState];
    [_confirmBtn addTarget:self action:@selector(sendVertifyCodeRequest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_confirmBtn];
    
    _confirmBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [_confirmBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_codeTF withOffset:20];
    [_confirmBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.view withOffset:kWidthDistance];
}

-(void)sendVertifyCodeRequest
{
    //[self doConfirm];
    
#if 1
    [MobClick event:@"click_submit"];
    
    [Utility showMBProgress:self.view message:LOADING_TEXT];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setPObject:_codeTF.text forKey:@"verifyCode"];
    [dict setPObject:_telphoneTF.text forKey:@"mobileNumber"];
    
    [manager POST:kVertifyCode parameters:dict queue:nil success:^(id responseObject) {
        [Utility hideMBProgress:self.view];
        [self doConfirm];
    } failure:^(NSString *code, NSString *error) {
        [Utility hideMBProgress:self.view];
        [Utility showToastWithMessage:error inView:self.view];
    }];
#endif
}

- (void)doConfirm
{
    [MobClick event:@"click_submit"];
    HWRegisterThirdViewController *thirdVC = [[HWRegisterThirdViewController alloc] init];
    thirdVC.telephoneNum = _telphoneTF.text;
    [self.navigationController pushViewController:thirdVC animated:YES];
}

#pragma mark -
#pragma mark 同意协议按钮
-(void)addAgreeBtn
{
    CGFloat height = [_confirmBtn systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + [_telphoneTF systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + [_codeTF systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 15 + 10 + 15 + 20 + 10;
    _cubeImgV = [[UIImageView alloc] initWithFrame:CGRectMake(15, height, 15, 15)];
    _cubeImgV.backgroundColor = [UIColor whiteColor];
    _cubeImgV.layer.borderColor = UIColorFromRGB(0xdfe0da).CGColor;
    _cubeImgV.layer.borderWidth = 0.5f;
    _cubeImgV.image = [UIImage imageNamed:@"login-select_icon2"];
    [self.view addSubview:_cubeImgV];
    
    UIButton *checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    checkButton.frame = CGRectMake(0, 0, 20, 20);
    checkButton.center = _cubeImgV.center;
    [checkButton addTarget:self action:@selector(toCheck:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:checkButton];
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:@"同意考拉社区用户协议"];
    [string addAttribute:NSForegroundColorAttributeName value:(id)THEME_COLOR_TEXT range:NSMakeRange(0, [string length])];
    [string addAttribute:NSUnderlineStyleAttributeName value:(id)[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(0, [string length])];
    [string addAttribute:NSFontAttributeName value:(id)[UIFont systemFontOfSize:15.0] range:NSMakeRange(0, [string length])];
    UIButton *treatyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    treatyBtn.frame = CGRectMake(CGRectGetMaxX(_cubeImgV.frame) + 5, height - 5, 155, 25);
    [treatyBtn setAttributedTitle:string forState:UIControlStateNormal];
    [treatyBtn addTarget:self action:@selector(pushTreatment:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:treatyBtn];
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
    if (!_cubeImgV.image)
    {
        _cubeImgV.image = [UIImage imageNamed:@"login-select_icon2"];
        
        if (_telphoneTF.text.length != 11 || ![Utility validateMobile:_telphoneTF.text])
        {
            [_confirmBtn setInactiveState];
        }
        else
        {
            [_confirmBtn setActiveState];
        }
    }
    else
    {
        _cubeImgV.image = nil;
        [_confirmBtn setInactiveState];
    }
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

#pragma mark -
#pragma mark TextField Delegate method
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == _telphoneTF) {
        NSMutableString *text = [textField.text mutableCopy];
        [text replaceCharactersInRange:range withString:string];
        if (text.length > 11 && range.length == 0)
        {
            return NO;
        }
        if (text.length != 11 || ![Utility validateMobile:text])
        {
            [_sendCodeBtn setInactiveState];
            [_confirmBtn setInactiveState];
            if (![_sendCodeBtn.titleLabel.text  isEqual: @"语音播报"] && ![_sendCodeBtn.titleLabel.text  isEqual: @"获取验证码"])
            {
                _sendCodeBtn.backgroundColor = BUTTON_COLOR_LIGHTGRAY;
            }
        }
        else
        {
            if ([_sendCodeBtn.titleLabel.text  isEqual: @"语音播报"] || [_sendCodeBtn.titleLabel.text  isEqual: @"获取验证码"])
            {
                //[_sendCodeBtn setActiveState];
                _sendCodeBtn.userInteractionEnabled = YES;
                _sendCodeBtn.titleLabel.alpha = 1.0f;
            }
        }
    }
    else if (textField == _codeTF)
    {
        NSMutableString *text = [textField.text mutableCopy];
        [text replaceCharactersInRange:range withString:string];
        if (_cubeImgV.image != nil)
        {
            if (text.length > 0 && (_telphoneTF.text.length == 11 && [Utility validateMobile:_telphoneTF.text]))
            {
                [_confirmBtn setActiveState];
            }
            else
            {
                [_confirmBtn setInactiveState];
            }
        }
        else
        {
            [_confirmBtn setInactiveState];
        }
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    if (textField == _telphoneTF)
    {
        [_sendCodeBtn setInactiveState];
    }
    [_confirmBtn setInactiveState];

    return YES;
}

#pragma mark -
#pragma mark System method
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
