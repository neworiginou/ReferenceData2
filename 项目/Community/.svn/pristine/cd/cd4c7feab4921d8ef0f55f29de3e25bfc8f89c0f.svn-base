//
//  HWForgetSecondViewController.m
//  Community
//
//  Created by caijingpeng.haowu on 14-8-28.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//


#import "HWForgetSecondViewController.h"
#import "HWCountDownButton.h"
#import "HWInputBackView.h"
#import "HWForgetThirdViewController.h"
#import "HWRequestConfig.h"
#import "HWHTTPRequestOperationManager.h"
#import "HWIdentifyingCodeButton.h"
@interface HWForgetSecondViewController ()
{
    UIButton *_confirmBtn;
    HWIdentifyingCodeButton *_sendCodeBtn;
}
@end

@implementation HWForgetSecondViewController
@synthesize telephoneNum,shangxingMessagePhone,isChangePwd;
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
    self.navigationItem.titleView = [Utility navTitleView:@"填写验证码"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    
    UILabel *msgLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, kScreenWidth - 30, 40)];
    msgLab.backgroundColor = [UIColor clearColor];
    msgLab.font = [UIFont fontWithName:FONTNAME size:15.0f];
    msgLab.text = [NSString stringWithFormat:@"已将验证码发送至您的手机 %@",[Utility securePhoneNumber:self.telephoneNum]];
    msgLab.textColor = THEME_COLOR_TEXT;
    [self.view addSubview:msgLab];
    
    HWInputBackView *backView = [[HWInputBackView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(msgLab.frame), kScreenWidth, 45) withLineCount:1];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    codeTF = [[UITextField alloc] initWithFrame:CGRectMake(15, CGRectGetMinY(backView.frame) + 7.5f + (!IOS7 ? 5 : 0), kScreenWidth - 30 - 120, 30)];
    codeTF.placeholder = @"请输入验证码";
    codeTF.textColor = THEME_COLOR_SMOKE;
    codeTF.font = [UIFont fontWithName:FONTNAME size:15.0f];
    codeTF.delegate = self;
    codeTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:codeTF];
    
//    HWCountDownButton *countDownBtn = [HWCountDownButton buttonWithType:UIButtonTypeCustom];
//    [countDownBtn setTime:60];
//    [countDownBtn setTimerStart:YES];
//    [countDownBtn setTitleColor:THEME_COLOR_TEXT forState:UIControlStateNormal];
//    countDownBtn.titleLabel.font = [UIFont fontWithName:FONTNAME size:15.0f];
//    countDownBtn.backgroundColor = THEME_COLOR_TEXTBACKGROUND;
//    countDownBtn.frame = CGRectMake(CGRectGetMaxX(verticalLine.frame), CGRectGetMinY(backView.frame) + 0.5f, 120, 44);
//    [countDownBtn addTarget:self action:@selector(sendAgain:) forControlEvents:UIControlEventTouchUpInside];
    //[self.view addSubview:countDownBtn];
    
    _sendCodeBtn = [[HWIdentifyingCodeButton alloc]init];
    [self.view addSubview:_sendCodeBtn];
    _sendCodeBtn.frame = CGRectMake(0, 0, 214 / 2, 70 / 2);
    _sendCodeBtn.layer.masksToBounds = YES;
    _sendCodeBtn.layer.cornerRadius = 3;
    [_sendCodeBtn setBackgroundImage:[Utility imageWithColor:THEBUTTON_GREEN_NORMAL andSize:_sendCodeBtn.frame.size] forState:UIControlStateNormal];
    [_sendCodeBtn setBackgroundImage:[Utility imageWithColor:THEBUTTON_GREEN_HIGHLIGHT andSize:_sendCodeBtn.frame.size] forState:UIControlStateHighlighted];
    _sendCodeBtn.titleLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
    _sendCodeBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [_sendCodeBtn autoSetDimensionsToSize:CGSizeMake(_sendCodeBtn.frame.size.width, _sendCodeBtn.frame.size.height)];
    [_sendCodeBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:backView];
    [_sendCodeBtn autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.view withOffset:-15];
    [_sendCodeBtn btnFirstClick];
    [_sendCodeBtn addTarget:self action:@selector(sendAgain:) forControlEvents:UIControlEventTouchUpInside];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.frame = CGRectMake(15, CGRectGetMaxY(backView.frame) + 20.0f, kScreenWidth - 30.0f, 45.0f);
    [_confirmBtn setButtonOrangeStyle];
    [_confirmBtn setTitle:@"提交" forState:UIControlStateNormal];
    [_confirmBtn setInactiveState];
    [_confirmBtn addTarget:self action:@selector(sendVertifyCodeRequest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_confirmBtn];
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:@"收不到验证码 ?"];
    [string addAttribute:NSForegroundColorAttributeName value:(id)THEME_COLOR_TEXT range:NSMakeRange(0, [string length])];
    [string addAttribute:NSUnderlineStyleAttributeName value:(id)[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(0, [string length])];
    //[string addAttribute:NSFontAttributeName value:(id)[UIFont fontWithName:FONTNAME size:15.0f] range:NSMakeRange(0, [string length])];
    [string addAttribute:NSFontAttributeName value:(id)[UIFont systemFontOfSize:15.0f] range:NSMakeRange(0, [string length])];
    UIButton *noAcceptBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    noAcceptBtn.frame = CGRectMake(15, CGRectGetMaxY(_confirmBtn.frame) + 20, 120, 25);
    [noAcceptBtn setAttributedTitle:string forState:UIControlStateNormal];
    [noAcceptBtn addTarget:self action:@selector(doMessageRegister:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:noAcceptBtn];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doTap:)];
    [self.view addGestureRecognizer:tap];
}

#pragma mark -
#pragma mark Private method

- (void)doTap:(id)sender
{
    [self.view endEditing:YES];
}

/**
 *	@brief	重新发送验证码
 *
 *	@param 	sender
 *
 *	@return
 */
- (void)sendAgain:(id)sender
{
    [MobClick event:@"click_reget_code"];
    
    [self.view endEditing:YES];
    
    [Utility showMBProgress:self.view message:LOADING_TEXT];
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setPObject:telephoneNum forKey:@"mobileNumber"];
    [dict setPObject:[Utility getUUID] forKey:@"mac"];
    [dict setPObject:@"2" forKey:@"smsType"];
    [manager POST:kForgetSendVertify parameters:dict queue:nil success:^(id responseObject)  {
        [Utility hideMBProgress:self.view];
        [Utility show3SecondToastWithMessage:@"验证码将以电话(号段为021)的\n形式通知到请您注意接听" inView:self.view];

        NSString *msgRegistPhone = [responseObject stringObjectForKey:@"data"];
        NSLog(@"验证码:%@",msgRegistPhone);
    } failure:^(NSString *code, NSString *error)  {
        
        [Utility hideMBProgress:self.view];
        [Utility showToastWithMessage:error inView:self.view];
        NSLog(@"error");
    }];
    [_sendCodeBtn btnFirstClick];
}
//验证验证码请求
-(void)sendVertifyCodeRequest
{
    [MobClick event:@"click_submit"];
    
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
    HWForgetThirdViewController *thirdVC = [[HWForgetThirdViewController alloc] init];
    thirdVC.telephoneNum = telephoneNum;
    thirdVC.isChangePwd = self.isChangePwd;
    thirdVC.popToViewController = self.popToViewController;
    [self.navigationController pushViewController:thirdVC animated:YES];
}

/**
 *	@brief	收不到验证码 点击事件
 *
 *	@param 	sender
 *
 *	@return
 */
- (void)doMessageRegister:(id)sender
{
    [MobClick event:@"click_cannot_getcode"];
    
    int a = arc4random()%1000000;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"发送短信：czmm#新密码到%@即可重置密码。示例：czmm#%d",self.shangxingMessagePhone,a] message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"重置密码", nil];
    [alert show];
}

/**
 *	@brief	发送短信
 *
 *	@param 	bodyOfMessage 	短信内容
 *	@param 	recipients 	发送对象
 *
 *	@return
 */
- (void)sendSMS:(NSString *)bodyOfMessage recipientList:(NSArray *)recipients
{
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    if([MFMessageComposeViewController canSendText])
    {
        controller.body = bodyOfMessage;
        
        controller.recipients = recipients;
        
        controller.messageComposeDelegate = self;
        
        [self presentViewController:controller animated:YES completion:nil];
    }
}

#pragma mark -
#pragma mark Alert delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [MobClick event:@"click_reset_code"];
        if (self.shangxingMessagePhone != nil)
        {
            int a = arc4random()%1000000;
            [self sendSMS:[NSString stringWithFormat:@"czmm#%d",a] recipientList:[NSArray arrayWithObjects:self.shangxingMessagePhone, nil]];
        }
        else
        {
            NSLog(@"上行号码为空");
        }
        
    }
    else
    {
        [MobClick event:@"click_cancel_cannotgetcode"];
    }
}

#pragma mark -
#pragma mark MFMessage delegate

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [controller dismissViewControllerAnimated:YES completion:nil];
    
    if (result == MessageComposeResultCancelled)
    {
        NSLog(@"Message cancelled");
        
    }
    else if (result == MessageComposeResultSent)
    {
        NSLog(@"Message sent");
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else
    {
        NSLog(@"Message failed");
        // 提示发送失败
    }
    
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
    if (beStr.length > 20) {
        return NO;
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [MobClick event:@"get_focus_code"];
    return YES;
}

- (void)dealloc
{
    [_sendCodeBtn.timer invalidate];
    _sendCodeBtn.timer = nil;
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
