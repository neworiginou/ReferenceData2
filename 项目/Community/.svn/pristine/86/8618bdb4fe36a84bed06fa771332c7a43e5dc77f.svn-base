//
//  HWReLoginForgetFirstVC.m
//  Community
//
//  Created by niedi on 15/8/3.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWReLoginForgetFirstVC.h"
#import "HWIdentifyingCodeButton.h"
#import "HWReLoginForgetSecdVC.h"

@interface HWReLoginForgetFirstVC ()<UITextFieldDelegate, HWIdentifyingCodeButtonDelegate>
{
    UIButton *_confirmBtn;
    UITextField *codeTF;
    HWIdentifyingCodeButton *_sendCodeBtn;
}
@end

@implementation HWReLoginForgetFirstVC
@synthesize telephoneNum;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.titleView = [Utility navTitleView:@"忘记密码"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    
    DView *backV = [DView viewFrameX:0 y:10.0f w:kScreenWidth h:CONTENT_HEIGHT - 10];
    backV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backV];
    
    DView *tFBackV = [DView viewFrameX:25.0f y:25.0f w:kScreenWidth - 2 * 25 h:45.0f];
    tFBackV.layer.borderColor = THEME_COLOR_LINE.CGColor;
    tFBackV.layer.cornerRadius = 2.5f;
    tFBackV.layer.borderWidth = 0.5f;
    [backV addSubview:tFBackV];
    
    codeTF = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth - 2 * 25 - 2 * 10 - 120, 45.0f)];
    codeTF.placeholder = @"输入验证码";
    codeTF.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
    codeTF.textColor = THEME_COLOR_SMOKE;
    codeTF.keyboardType = UIKeyboardTypeNumberPad;
    codeTF.delegate = self;
    codeTF.returnKeyType = UIReturnKeyDone;
    codeTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [tFBackV addSubview:codeTF];
    
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
    [_sendCodeBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:codeTF];
    [_sendCodeBtn autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.view withOffset:-35];
    [_sendCodeBtn addTarget:self action:@selector(sendFirstTime) forControlEvents:UIControlEventTouchUpInside];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.frame = CGRectMake(25.0f, CGRectGetMaxY(tFBackV.frame) + 40, kScreenWidth - 50, 45);
    [_confirmBtn setButtonOrangeStyle];
    [_confirmBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_confirmBtn addTarget:self action:@selector(sendVertifyCodeRequest) forControlEvents:UIControlEventTouchUpInside];
    [backV addSubview:_confirmBtn];
    [_confirmBtn setInactiveState];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doTap:)];
    [self.view addGestureRecognizer:tap];
}

- (void)backMethod
{
    [super backMethod];
    [MobClick event:@"verifycode_click_back"];//1.7
}

#pragma mark -
#pragma mark Private method

- (void)doTap:(id)sender
{
    [self.view endEditing:YES];
}

//首次发送验证码
- (void)sendFirstTime
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
    [Utility showMBProgress:self.view message:@"正在发送验证码"];
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setPObject:self.telephoneNum forKey:@"mobileNumber"];
    [dict setPObject:[Utility getUUID] forKey:@"mac"];
    [dict setPObject:@"1" forKey:@"smsType"];
    [manager POST:kForgetSendVertify parameters:dict queue:nil success:^(id responseObject){
        
        [Utility hideMBProgress:self.view];
        [ud setObject:[NSDate date] forKey:KLastSMSDate];
        
        //成功发送验证码，取消点击事件
        [_sendCodeBtn removeTarget:self action:@selector(sendFirstTime) forControlEvents:UIControlEventTouchUpInside];
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

/**
 *	@brief	重新发送验证码
 */
-(void)toPlaySound
{
    NSLog(@"toPlaySound");
    
    [self.view endEditing:YES];
    [MobClick event:@"verifycode_click_voicecode"];//1.7
    
    [Utility showMBProgress:self.view message:@"正在获取验证码"];
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setPObject:self.telephoneNum forKey:@"mobileNumber"];
    [dict setPObject:[Utility getUUID] forKey:@"mac"];
    [dict setPObject:@"2" forKey:@"smsType"];//smsType 1.短信验证码，2语音验证码
    
    [manager POST:kForgetSendVertify parameters:dict queue:nil success:^(id responseObject) {
        
        [Utility hideMBProgress:self.view];
        [Utility show3SecondToastWithMessage:@"验证码将以电话(号段为021)的\n形式通知到请您注意接听" inView:self.view];
        
        NSString *msgRegistPhone = [responseObject stringObjectForKey:@"data"];
        NSLog(@"验证码:%@",msgRegistPhone);
        
    } failure:^(NSString *code, NSString *error) {
        
        [Utility hideMBProgress:self.view];
        [Utility showToastWithMessage:error inView:self.view];
    }];
    
    [_sendCodeBtn btnFirstClick];
}

#pragma mark - 验证验证码
-(void)sendVertifyCodeRequest
{
    [MobClick event:@"verifycode_click_next"];//1.7
    
    [Utility showMBProgress:self.view message:LOADING_TEXT];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setPObject:codeTF.text forKey:@"verifyCode"];
    [dict setPObject:telephoneNum forKey:@"mobileNumber"];
    
    [manager POST:kForgetVertifyCode parameters:dict queue:nil success:^(id responseObject) {
        
        [Utility hideMBProgress:self.view];
        [self doConfirm];
        
    } failure:^(NSString *code, NSString *error) {
        
        [Utility hideMBProgress:self.view];
        [Utility showToastWithMessage:error inView:self.view];
        NSLog(@"error");
    }];
}
/**
 *	@brief	提交
 *
 *	@param 	sender
 *
 *	@return
 */
- (void)doConfirm
{
    HWReLoginForgetSecdVC *scdVC = [[HWReLoginForgetSecdVC alloc] init];
    scdVC.telephoneNum = telephoneNum;
    [self.navigationController pushViewController:scdVC animated:YES];
}


#pragma mark -
#pragma mark TextField Delegate method

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSMutableString *text = [textField.text mutableCopy];
    [text replaceCharactersInRange:range withString:string];
    if (text.length == 0)
    {
        [_confirmBtn setInactiveState];
    }
    else
    {
        [_confirmBtn setActiveState];
    }
    
    NSString *beStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (beStr.length > 20)
    {
        return NO;
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [MobClick event:@"verifycode_get_focus_code"];//1.7
    return YES;
}

- (void)dealloc
{
    [_sendCodeBtn.timer invalidate];
    _sendCodeBtn.timer = nil;
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
