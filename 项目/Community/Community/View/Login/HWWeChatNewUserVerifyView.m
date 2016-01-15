//
//  HWWeChatNewUserVerifyView.m
//  Community
//
//  Created by caijingpeng.haowu on 15/1/14.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：新用户绑定微信 填写验证码
//
//  修改记录：
//      姓名         日期               修改内容
//     蔡景鹏     2015-01-14           创建文件
//
//

#import "HWWeChatNewUserVerifyView.h"
#import "HWCountDownButton.h"
#import "HWIdentifyingCodeButton.h"

@interface HWWeChatNewUserVerifyView()
{
    HWIdentifyingCodeButton *_sendCodeBtn;
}
@end

@implementation HWWeChatNewUserVerifyView
@synthesize weChatAccount;
@synthesize telephoneStr;
@synthesize shangxingMessagePhone;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame telephoneNum:(NSString *)telNum
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.telephoneStr = telNum;
        self.isNeedHeadRefresh = NO;
        [self initialHeaderView];
        [self initialFooterView];
        
    }
    return self;
}

#pragma mark -
#pragma mark    Initial View

- (void)initialHeaderView
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    headerView.backgroundColor = [UIColor clearColor];
    self.baseTable.tableHeaderView = headerView;
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"已将验证码发送到 %@", self.telephoneStr]];
    [string addAttribute:NSForegroundColorAttributeName value:(id)THEME_COLOR_GRAY_MIDDLE range:NSMakeRange(9, self.telephoneStr.length)];
    [string addAttribute:NSFontAttributeName value:(id)[UIFont fontWithName:FONTNAME size:THEME_FONT_BIG] range:NSMakeRange(9, self.telephoneStr.length)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15,
                                                               0,
                                                               kScreenWidth - 30,
                                                               50)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL13];
    label.textColor = THEME_COLOR_TEXT;
    label.attributedText = string;
    [headerView addSubview:label];
    
    /*
    UILabel *numberLab = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                   CGRectGetMaxY(label.frame),
                                                                   kScreenWidth,
                                                                   50)];
    numberLab.backgroundColor = [UIColor clearColor];
    numberLab.font = [UIFont boldSystemFontOfSize:22.0f];
    numberLab.textColor = THEME_COLOR_SMOKE;
    numberLab.textAlignment = NSTextAlignmentCenter;
    numberLab.text = self.telephoneStr;
    
    [headerView addSubview:numberLab];
    */
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                            CGRectGetHeight(headerView.frame) - 0.5f,
                                                            kScreenWidth,
                                                            0.5f)];
    line.backgroundColor = THEME_COLOR_LINE;
    [headerView addSubview:line];
    
}

- (void)initialFooterView
{
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 130)];
    footerView.backgroundColor = [UIColor clearColor];
    self.baseTable.tableFooterView = footerView;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                            0,
                                                            kScreenWidth,
                                                            0.5f)];
    line.backgroundColor = THEME_COLOR_LINE;
    [footerView addSubview:line];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.frame = CGRectMake(15, 20.0f, kScreenWidth - 30.0f, 45.0f);
    [_confirmBtn setButtonOrangeStyle];
    [_confirmBtn setTitle:@"提交" forState:UIControlStateNormal];
    [_confirmBtn addTarget:self action:@selector(sendVertifyCodeRequest:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:_confirmBtn];
    
    UIButton *noAcceptBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    noAcceptBtn.backgroundColor = [UIColor clearColor];
    noAcceptBtn.frame = CGRectMake(0, CGRectGetMaxY(_confirmBtn.frame) + 10, 200, 22);
    [noAcceptBtn setTitle:@"收不到验证码？发送短信注册" forState:UIControlStateNormal];
    noAcceptBtn.titleLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL13];
    [noAcceptBtn setTitleColor:THEME_COLOR_TEXT forState:UIControlStateNormal];
    [noAcceptBtn addTarget:self action:@selector(doMessageRegister:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:noAcceptBtn];
}

#pragma mark -
#pragma mark    Button Action Method

- (void)sendAgain:(id)sender
{
    [MobClick event:@"click_reget_code"];
    [MobClick event:@"click_wechatlogin_resendnotifycode"];
    
    [Utility showMBProgress:self message:LOADING_TEXT];
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setPObject:self.telephoneStr forKey:@"mobileNumber"];
    [dict setPObject:[Utility getUUID] forKey:@"mac"];
    [dict setPObject:@"2" forKey:@"smsType"];

    [manager POST:kRegisterSendVertify parameters:dict queue:nil success:^(id responseObject) {
        [Utility hideMBProgress:self];
        [Utility show3SecondToastWithMessage:@"验证码将以电话(号段为021)的\n形式通知到请您注意接听" inView:self];
        NSString *msgRegistPhone = [responseObject stringObjectForKey:@"data"];
        NSLog(@"验证码:%@",msgRegistPhone);
    } failure:^(NSString *code, NSString *error) {
        [Utility hideMBProgress:self];
        [Utility showToastWithMessage:error inView:self];
        NSLog(@"error");
    }];
    [_sendCodeBtn btnFirstClick];
}

- (void)sendVertifyCodeRequest:(id)sender
{
    [MobClick event:@"click_changepersonalfilescertificatenumber_sure"]; //maidian_1.2.1
    [self endEditing:YES];
    //[self doConfirm];
#if 1
    [Utility showMBProgress:self message:LOADING_TEXT];
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setPObject:_codeTF.text forKey:@"verifyCode"];
    [dict setPObject:self.telephoneStr forKey:@"mobileNumber"];
    
    [manager POST:kVertifyCode parameters:dict queue:nil success:^(id responseObject) {
        [Utility hideMBProgress:self];
        [self doConfirm];
    } failure:^(NSString *code, NSString *error)  {
        NSLog(@"error");
        [Utility hideMBProgress:self];
        [Utility showToastWithMessage:error inView:self];
    }];
#endif
}

- (void)doConfirm
{
    [MobClick event:@"click_wechatlogin_notifycode_submit"];
    if (delegate && [delegate respondsToSelector:@selector(didConfirmVerifyCode)])
    {
        [delegate didConfirmVerifyCode];
    }
}

- (void)doMessageRegister:(id)sender
{
    [MobClick event:@"click_changepersonalfilescertificatenumber_cannotgetcode"]; //maidian_1.2.1
    [MobClick event:@"click_cannot_receivecode"];
    [MobClick event:@"click_wechatlogin_cannotgetnotifycode"];
    int a = arc4random()%1000000;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@" 发送短信：zcsq#6位数字字母密码到 %@直接注册 示例：zcsq#%d",self.shangxingMessagePhone,a] message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"短信注册", nil];
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
    if (delegate && [delegate respondsToSelector:@selector(didSendSMS:recipientList:)])
    {
        [delegate didSendSMS:bodyOfMessage recipientList:recipients];
    }
}

#pragma mark -
#pragma mark Alert delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [MobClick event:@"click_message_signin"];
        [MobClick event:@"click_wechatlogin_SMSregister"];
        
        if (self.shangxingMessagePhone != nil)
        {
            int a = arc4random()%1000000;
            [self sendSMS:[NSString stringWithFormat:@"zcsq#%d",a] recipientList:[NSArray arrayWithObjects:self.shangxingMessagePhone, nil]];
        }
        else
        {
            NSLog(@"上行号码为空");
        }
        
    }
    else
    {
        [MobClick event:@"click_cancel_cannotreceivecode"];
        [MobClick event:@"click_wechatlogin_cancelSMSregister"];
    }
}



#pragma mark -
#pragma mark    UITableView Delegate DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%d%d",(int)indexPath.section,(int)indexPath.row];
    HWBaseTableViewCell *cell = (HWBaseTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier]; //改为以下的方法
    if (cell == nil)
    {
        cell = [[HWBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _codeTF = [[HWTextField alloc] initWithFrame:CGRectMake(15, 0, kScreenWidth - 95 - 15 * 2 - 5, 45)];
    _codeTF.placeholder = @"输入验证码";
    _codeTF.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
    _codeTF.textColor = THEME_COLOR_SMOKE;
    _codeTF.delegate = self;
    _codeTF.returnKeyType = UIReturnKeyDone;
    _codeTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [cell.contentView addSubview:_codeTF];
    
//    HWCountDownButton *countDownBtn = [HWCountDownButton buttonWithType:UIButtonTypeCustom];
//    countDownBtn.frame = CGRectMake(kScreenWidth - 15 - 95, 7.5f, 95, 30);
//    [countDownBtn setButtonYellowStyle];
//    countDownBtn.freezeColor = THEME_COLOR_GRAY;
//    countDownBtn.titleLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
//    [countDownBtn setTime:60];
//    [countDownBtn setTimerStart:YES];
    
    _sendCodeBtn = [[HWIdentifyingCodeButton alloc]init];
    [cell.contentView addSubview:_sendCodeBtn];
    _sendCodeBtn.frame = CGRectMake(0, 0, 214 / 2, 70 / 2);
    _sendCodeBtn.layer.masksToBounds = YES;
    _sendCodeBtn.layer.cornerRadius = 3;
    [_sendCodeBtn setBackgroundImage:[Utility imageWithColor:THEBUTTON_GREEN_NORMAL andSize:_sendCodeBtn.frame.size] forState:UIControlStateNormal];
    [_sendCodeBtn setBackgroundImage:[Utility imageWithColor:THEBUTTON_GREEN_HIGHLIGHT andSize:_sendCodeBtn.frame.size] forState:UIControlStateHighlighted];
    _sendCodeBtn.titleLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
    _sendCodeBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [_sendCodeBtn autoSetDimensionsToSize:CGSizeMake(_sendCodeBtn.frame.size.width, _sendCodeBtn.frame.size.height)];
    [_sendCodeBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:cell.contentView];
    [_sendCodeBtn autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:cell.contentView withOffset:-15];
    [_sendCodeBtn btnFirstClick];
    [_sendCodeBtn addTarget:self action:@selector(sendAgain:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.0f;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [MobClick event:@"get_focus_changepersonalfilescertificatenumber"]; //maidian_1.2.1
    [MobClick event:@"get_focus_wechatlogin_inputnotifycode"];
    return YES;
}

-(void)dealloc
{
    [_sendCodeBtn.timer invalidate];
    _sendCodeBtn.timer = nil;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
