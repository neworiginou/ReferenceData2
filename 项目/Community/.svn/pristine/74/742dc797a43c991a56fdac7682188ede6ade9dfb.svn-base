//
//  HWReLoginRegistVC.m
//  Community
//
//  Created by niedi on 15/8/3.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWReLoginRegistVC.h"
#import "HWIdentifyingCodeButton.h"

@interface HWReLoginRegistVC ()<UITextFieldDelegate, HWIdentifyingCodeButtonDelegate>
{
    UIButton *_loginBtn;
    UITextField *_passwordTF;
    UITextField *_verfiyCodeTF;
    HWIdentifyingCodeButton *_sendCodeBtn;
}
@end

@implementation HWReLoginRegistVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [Utility navTitleView:@"注册"];
    
    DView *backV = [DView viewFrameX:0 y:10.0f w:kScreenWidth h:CONTENT_HEIGHT - 10];
    backV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backV];
    
    DView *tFBackV = [DView viewFrameX:25.0f y:25.0f w:kScreenWidth - 2 * 25 h:45.0f * 2];
    tFBackV.layer.borderColor = THEME_COLOR_LINE.CGColor;
    tFBackV.layer.cornerRadius = 2.5f;
    tFBackV.layer.borderWidth = 0.5f;
    [backV addSubview:tFBackV];
    
    _passwordTF = [[HWTextField alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth - 2 * 25 - 2 * 10, 45)];
    _passwordTF.placeholder = @"设置密码";
    _passwordTF.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
    _passwordTF.textColor = THEME_COLOR_SMOKE;
    _passwordTF.secureTextEntry = YES;
    _passwordTF.keyboardType = UIKeyboardTypeDefault;
    _passwordTF.delegate = self;
    _passwordTF.returnKeyType = UIReturnKeyDone;
    _passwordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [tFBackV addSubview:_passwordTF];
    
    CALayer *middleLine = [DView layerFrameX:0 y:45.0f w:CGRectGetWidth(tFBackV.frame) h:0.5f];
    [tFBackV.layer addSublayer:middleLine];
    
    _verfiyCodeTF = [[UITextField alloc] initWithFrame:CGRectMake(10, 45.0f, CGRectGetWidth(_passwordTF.frame) - 120, 45.0f)];
    _verfiyCodeTF.placeholder = @"输入验证码";
    _verfiyCodeTF.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
    _verfiyCodeTF.textColor = THEME_COLOR_SMOKE;
    _verfiyCodeTF.keyboardType = UIKeyboardTypeNumberPad;
    _verfiyCodeTF.delegate = self;
    _verfiyCodeTF.returnKeyType = UIReturnKeyDone;
    _verfiyCodeTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [tFBackV addSubview:_verfiyCodeTF];
    
    _sendCodeBtn = [[HWIdentifyingCodeButton alloc]init];
    [self.view addSubview:_sendCodeBtn];
    _sendCodeBtn.identifyingCodeButtonDelegate = self;
    _sendCodeBtn.frame = CGRectMake(0, 0, 214 / 2, 70 / 2);
    _sendCodeBtn.layer.masksToBounds = YES;
    _sendCodeBtn.layer.cornerRadius = 3;
    [_sendCodeBtn setBackgroundImage:[Utility imageWithColor:THEBUTTON_GREEN_NORMAL andSize:_sendCodeBtn.frame.size] forState:UIControlStateNormal];
    [_sendCodeBtn setBackgroundImage:[Utility imageWithColor:THEBUTTON_GREEN_HIGHLIGHT andSize:_sendCodeBtn.frame.size] forState:UIControlStateHighlighted];
    _sendCodeBtn.titleLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
    [_sendCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    _sendCodeBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [_sendCodeBtn autoSetDimensionsToSize:CGSizeMake(_sendCodeBtn.frame.size.width, _sendCodeBtn.frame.size.height)];
    [_sendCodeBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_verfiyCodeTF];
    [_sendCodeBtn autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.view withOffset:-35];
    [_sendCodeBtn addTarget:self action:@selector(sendCodeRequest) forControlEvents:UIControlEventTouchUpInside];
    
    _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _loginBtn.frame = CGRectMake(25.0f, CGRectGetMaxY(tFBackV.frame) + 40, kScreenWidth - 50, 45);
    [_loginBtn setButtonOrangeStyle];
    [_loginBtn setTitle:@"注册" forState:UIControlStateNormal];
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(doLogin) forControlEvents:UIControlEventTouchUpInside];
    [backV addSubview:_loginBtn];
    [_loginBtn setInactiveState];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doTap)];
    [self.view addGestureRecognizer:tap];
    
    [_passwordTF becomeFirstResponder];
}

- (void)doLogin
{
    /*接口名称：
     http://localhost:8080/hw-sq-app-web/reg/commit2.do?mobileNumber=18222222222&password=123456&verifyCode=340112&villageId=1
     
     输入参数：
     mobileNumber 用户手机号
     password 用户密码
     verifyCode 验证码
     villageId 小区ID
     
     输出参数：
     成功：
     {
     status: "1",
     data:
     { userId: "1034861034860", residentId: "2069722", telephoneNum: "18222222222", nickname: "进贤小区第112位用户", gender: null, favorite: null, avatarUrl: null, isGag: 0, key: "1f0c7119-d268-4f87-9d7a-0ccf956c1d2f", cityId: "310100", cityName: "上海市", villageId: "1", villageName: "进贤小区", villageAddress: "陕西南路25弄1-12号", tenementId: "1012499488", coStatus: 1, shopId: null, isReceiveMsg: null, isRecevieWy: null, isRecevieShop: null, isVoiceOn: null, isShakeOn: null, openid: null, weixinNickname: null, isBindMobile: "1", isBindWeixin: "0", deviceId: null, disabled: 0, source: 0, isAuth: 1 }
     
     ,
     detail: "请求数据成功!",
     key: "1f0c7119-d268-4f87-9d7a-0ccf956c1d2f"
     }
     
     失败：
     { status: "0", data: "", detail: "请输入正确的手机号码", key: "" } { status: "0", data: "", detail: "该手机号码已注册过", key: "" } { status: "0", data: "", detail: "你的帐号已被考拉君封禁", key: "" } { status: "2", data: "", detail: "亲，抢钱宝的用户可以直接登入考拉社区哦", key: "" } { status: "0", data: "", detail: "注册失败", key: "" } */
    
    [self.view endEditing:YES];
    
    [MobClick event:@"register_click_register"];//1.7
    
    if(_passwordTF.text.length < 6)
    {
        [Utility showToastWithMessage:@"密码长度不能小于6位" inView:self.view];
        return;
    }
    [Utility showMBProgress:self.view message:@"登录中"];
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setPObject:self.mobilNum forKey:@"mobileNumber"];
    [dict setPObject:_passwordTF.text forKey:@"password"];
    [dict setPObject:_verfiyCodeTF.text forKey:@"verifyCode"];
    [dict setPObject:[HWUserLogin currentUserLogin].villageId forKey:@"villageId"];
    
    [manager POST:KReLoginRegist parameters:dict queue:nil success:^(id responseObject) {
        
        [Utility hideMBProgress:self.view];
        
        //普通登录 关闭新手游客引导
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setInteger:-1 forKey:kGuideStep];
        [defaults synchronize];
        
        NSDictionary *dataDic = (NSDictionary *)[responseObject objectForKey:@"data"];
        //用户数据保存本地
        [[HWUserLogin currentUserLogin] handleLoginInfo:dataDic operationController:self];
        
    } failure:^(NSString *code, NSString *error) {
        
        [Utility hideMBProgress:self.view];
        [Utility showToastWithMessage:error inView:self.view];
        NSLog(@"error %@",error);
    }];
}

-(void)sendCodeRequest
{
    [MobClick event:@"register_click_resent"];//1.7
    
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
    [dict setPObject:self.mobilNum forKey:@"mobileNumber"];
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
        [Utility showToastWithMessage:error inView:self.view];
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
    [MobClick event:@"register_click_voicecode"];//1.7
    
    [Utility showMBProgress:self.view message:@"正在获取验证码"];
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setPObject:self.mobilNum forKey:@"mobileNumber"];
    [dict setPObject:[Utility getUUID] forKey:@"mac"];
    [dict setPObject:@"2" forKey:@"smsType"];//smsType 1.短信验证码，2语音验证码
    
    [manager POST:kRegisterSendVertify parameters:dict queue:nil success:^(id responseObject) {
        
        [Utility hideMBProgress:self.view];
        [Utility show3SecondToastWithMessage:@"验证码将以电话(号段为021)的\n形式通知到请您注意接听" inView:self.view];
        
    } failure:^(NSString *code, NSString *error) {
        
        [Utility hideMBProgress:self.view];
        [Utility showToastWithMessage:error inView:self.view];
    }];
    
    [_sendCodeBtn btnFirstClick];
}

- (void)doTap
{
    [self.view endEditing:YES];
}

#pragma mark -  UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == _passwordTF)
    {
        NSMutableString *text = [textField.text mutableCopy];
        [text replaceCharactersInRange:range withString:string];
        if (text.length > 11 && range.length == 0)
        {
            return NO;
        }
        if (text.length > 0 && _verfiyCodeTF.text.length > 0)
        {
            [_loginBtn setActiveState];
        }
        else
        {
            [_loginBtn setInactiveState];
        }
    }
    else if (textField == _verfiyCodeTF)
    {
        NSMutableString *text = [textField.text mutableCopy];
        [text replaceCharactersInRange:range withString:string];
        
        if (text.length > 0 && _passwordTF.text.length > 0)
        {
            [_loginBtn setActiveState];
        }
        else
        {
            [_loginBtn setInactiveState];
        }
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == _verfiyCodeTF)
    {
        [MobClick event:@"register_get_focus_code"];//1.7
    }
    else
    {
        [MobClick event:@"register_get_focus_password"];//1.7
    }
    return YES;
}

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
