//
//  HWWeChatBindTelephoneView.m
//  Community
//
//  Created by caijingpeng.haowu on 15/1/14.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：新用户绑定 填写手机号 或 跳过绑定页面 view
//
//  修改记录：
//      姓名         日期               修改内容
//     蔡景鹏     2015-01-14           创建文件
//     蔡景鹏     2015-01-16           UI调整
//     杨庆龙     2015-01-19           添加了已经是注册用户跳转到olduser界面

#import "HWWeChatBindTelephoneView.h"
#import "AppDelegate.h"

@implementation HWWeChatBindTelephoneView
@synthesize weChatAccount;
@synthesize delegate;
@synthesize isBind;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.isNeedHeadRefresh = NO;
        [self initialHeaderView];
        [self initialFooterView];
    }
    return self;
}

#pragma mark -
#pragma mark    Initial View

/**
 *	@brief
 *
 *	@return
 */
- (void)initialHeaderView
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    headerView.backgroundColor = [UIColor clearColor];
    self.baseTable.tableHeaderView = headerView;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, kScreenWidth, 40)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = THEME_COLOR_TEXT;
    label.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
    label.text = @"绑定手机之后，可以使用考拉社区所有功能";
    [headerView addSubview:label];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(headerView.frame) - 0.5f, kScreenWidth, 0.5f)];
    line.backgroundColor = THEME_COLOR_LINE;
    [headerView addSubview:line];
}

- (void)initialFooterView
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 150.0f)];
    footerView.backgroundColor = [UIColor clearColor];
    self.baseTable.tableFooterView = footerView;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5f)];
    line.backgroundColor = THEME_COLOR_LINE;
    [footerView addSubview:line];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(15.0f, 20.0f, kScreenWidth - 30, 45.0f);
    [button setButtonOrangeStyle];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(toSure:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:button];
    
    _skipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _skipBtn.frame = CGRectMake(kScreenWidth - 75, CGRectGetMaxY(button.frame) + 10, 75, 30);
    [_skipBtn setTitle:@"跳过" forState:UIControlStateNormal];
    [_skipBtn setTitleColor:THEME_COLOR_GRAY_MIDDLE forState:UIControlStateNormal];
    _skipBtn.titleLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
    [_skipBtn addTarget:self action:@selector(toSkip:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:_skipBtn];
}

#pragma mark -
#pragma mark    Set Get

- (void)setIsBind:(BOOL)iBind
{
    isBind = iBind;
    if (isBind)
    {
        _skipBtn.hidden = YES;
    }
    else
    {
        _skipBtn.hidden = NO;
    }
}

-(void)normalBind
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSDate *lastSMSDate = [ud objectForKey:KLastSMSDate];
    if (lastSMSDate)
    {
        NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:lastSMSDate];
        if (interval < 60)
        {
            [Utility showToastWithMessage:@"爱卿~60秒内只能验证一次哟" inView:self];
            return;
        }
    }
    else
    {
        [ud setObject:[NSDate date] forKey:KLastSMSDate];
        [ud synchronize];
    }
    
    // 发送验证码
    [Utility showMBProgress:self message:@"正在发送验证码"];
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setPObject:_telephoneTF.text forKey:@"mobileNumber"];
    [dict setPObject:[Utility getUUID] forKey:@"mac"];
    [dict setPObject:@"1" forKey:@"smsType"];
    
    [manager POST:kRegisterSendVertify parameters:dict queue:nil success:^(id responseObject) {
        
        [Utility hideMBProgress:self];
        [ud setObject:[NSDate date] forKey:KLastSMSDate];
        
        if (responseObject)
        {
            NSDictionary *dicTemp = (NSDictionary *)responseObject;
            NSString *shangxingMessagePhoneStr = [dicTemp objectForKey:@"data"];
            NSString *status = [dicTemp objectForKey:@"status"];
            if ([status isEqualToString:@"1"])
            {
                [self sendCode:_telephoneTF.text shangXingMessagePhone:shangxingMessagePhoneStr];
            }
        }
        
    }
          failure:^(NSString *code, NSString *error)
     {
         //2.您的微信账号已经是考拉账号，可以直接登录
         //3.您的手机号已经是考拉账号，可以直接登录考拉社区
         //4.您输入的手机没有注册考拉考拉账号
         //5.登录密码错误
         //6.您输入的手机号已绑定微信账号
         [Utility hideMBProgress:self];
         
         if((code.integerValue == 2 || code.integerValue == 3 || code.integerValue == 0) && !isBind)
         {
             NSString *alertMessage = [NSString stringWithFormat:@"%@已经是考拉账号,可以直接登录",_telephoneTF.text];
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:alertMessage delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
             [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
                 if (buttonIndex == 1)
                 {
                     if([self.delegate respondsToSelector:@selector(didHaveRegister:)] && self.delegate != nil)
                     {
                         [self.delegate didHaveRegister:_telephoneTF.text];
                     }
                 }
             }];
         }
         else
         {
             [Utility showToastWithMessage:error inView:self];
         }
     }];
}

#pragma mark -
#pragma mark    Button Action Method

- (void)toSure:(id)sender
{
    [MobClick event:@"click_changepersonalfilesphonenumber_sure"]; //maidian_1.2.1
    [MobClick event:@"click_wechatlogin_inputphonenumber_sure"];
    
    if (_telephoneTF.text.length == 0)
    {
        [Utility showToastWithMessage:@"请输入手机号" inView:self];
        return;
    }
    if (_telephoneTF.text.length < 11) {
        [Utility showToastWithMessage:@"请输入正确的手机号" inView:self];
        return;
    }
    [self endEditing:YES];
    
    //游客绑定
    if (_isGuest == YES)
    {
        [Utility showMBProgress:self message:@"验证中..."];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setPObject:_telephoneTF.text forKey:@"mobileNumber"];

        HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
        [manager POST:kVaildateMobile parameters:dict queue:nil success:^(id responese) {
            [Utility hideMBProgress:self];
            [Utility showToastWithMessage:[responese stringObjectForKey:@"detail"] inView:self];
            //游客绑定新账号
            [self normalBind];
        } failure:^(NSString *code, NSString *error) {
            [Utility hideMBProgress:self];
            //游客绑定旧账号
            if ([error isEqual: @"该手机号码已注册过"] || [error isEqual: @"亲，抢钱宝的用户可以直接登入考拉社区哦"])
            {
                if([self.delegate respondsToSelector:@selector(didHaveRegister:)] && self.delegate != nil)
                {
                    [self.delegate didHaveRegister:_telephoneTF.text];
                    AppDelegate *appDel = (AppDelegate *)SHARED_APP_DELEGATE;
                    [Utility showToastWithMessage:error inView:appDel.window];
                }
            }
            else
            {
                [Utility showToastWithMessage:error inView:self];
            }
        }];
    }
    else
    {
        [self normalBind];
    }
}

- (void)toSkip:(id)sender
{
    /*
     接口名称：/hw-sq-app-web/weixin/skipBindLogin.do
     输入参数：
     openid： 普通用户的标识，对当前开发者帐号唯一
     unionid： 用户统一标识。针对一个微信开放平台帐号下的应用，同一用户的unionid是唯一的。
     nickname： 普通用户昵称
     sex： 普通用户性别，1为男性，2为女性
     headimgurl：用户头像，最后一个数值代表正方形头像大小（有0、46、64、96、132数值可 选，0代表640*640正方形头像），用户没有头像时该项为空
     province： 普通用户个人资料填写的省份
     city： 普通用户个人资料填写的城市
     输出参数：
     成功：
     {
     status: "1",
     data:
     { userId: "1076050076049", residentId: "2152100", telephoneNum: null, nickname: "小太阳", gender: "1", favorite: null, avatarUrl: "file/downloadByKey.do?mKey=54ade9d708c0462c1d48ef74", isGag: 0, key: "8b9a72c7-e198-42ae-9e60-082950623995", cityId: null, cityName: null, villageId: null, villageName: null, villageAddress: null, tenementId: null, shopId: null, isReceiveMsg: "1", isRecevieWy: "1", isRecevieShop: "1", isVoiceOn: "1", isShakeOn: "1", openid: "o6_bmasdasdsad6_2sgVt7hMZOPfL123456" }
     ,
     detail: "请求数据成功!",
     key: "8b9a72c7-e198-42ae-9e60-082950623995"
     }
     失败：
     { status: "0", data: "", detail: "微信授权用户对应的考拉账号不存在", key: "43c55c82-78d4-4db0-b116-f123ac267937" } { status: "0", data: "", detail: "你的考拉账号已被考拉君封禁", key: "43c55c82-78d4-4db0-b116-f123ac267937" } { status: "0", data: "", detail: "登录考拉社区失败", key: null }
     */
    
    [MobClick event:@"click_wechatlogin_jump"];
    
    [self endEditing:YES];
    
    [Utility showMBProgress:self message:@"加载中"];
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setPObject:self.weChatAccount.openId forKey:@"openid"];
    [dict setPObject:self.weChatAccount.unionId forKey:@"unionid"];
    [dict setPObject:self.weChatAccount.userName forKey:@"nickname"];
    [dict setPObject:self.weChatAccount.gender forKey:@"sex"];
    [dict setPObject:self.weChatAccount.headIconUrl forKey:@"headimgurl"];
    [dict setPObject:self.weChatAccount.location forKey:@"location"];
    
    [manager POST:kWeixinSkip parameters:dict queue:nil success:^(id responseObject) {
        
        [Utility hideMBProgress:self];
        
        NSDictionary *dataDic = (NSDictionary *)[responseObject objectForKey:@"data"];
        //用户数据保存本地
        [[HWUserLogin currentUserLogin] initUserLogin:dataDic];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:RELOAD_APP_DATA object:nil];
        
        if (delegate && [delegate respondsToSelector:@selector(didSkipBindSelectVillage)])
        {
            [delegate didSkipBindSelectVillage];
        }
        
        
        
    } failure:^(NSString *code, NSString *error) {
        [Utility hideMBProgress:self];
        [Utility showToastWithMessage:error inView:self];
    }];
}

- (void)sendCode:(NSString *)phoneNum shangXingMessagePhone:(NSString *)shangxingPhoneNum
{
    if (delegate && [delegate respondsToSelector:@selector(didSendVerifyCodePhone:shangxingNum:)])
    {
        [delegate didSendVerifyCodePhone:phoneNum shangxingNum:shangxingPhoneNum];
    }
}

#pragma mark -
#pragma mark        UITableView Delegate DataSource

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
    
    _telephoneTF = [[HWTextField alloc] initWithFrame:CGRectMake(15, 0, kScreenWidth - 30, 45)];
    _telephoneTF.placeholder = @"请输入手机号";
    _telephoneTF.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
    _telephoneTF.textColor = THEME_COLOR_SMOKE;
    _telephoneTF.keyboardType = UIKeyboardTypeNumberPad;
    _telephoneTF.delegate = self;
    _telephoneTF.text = _telNumber;
    _telephoneTF.returnKeyType = UIReturnKeyDone;
    _telephoneTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [cell.contentView addSubview:_telephoneTF];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.0f;
}

#pragma mark -
#pragma mark        UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [MobClick event:@"get_focus_changepersonalfilesphonenumber"]; //maidian_1.2.1
    [MobClick event:@"get_focus_wechatlogin_inputphonenumber"];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSMutableString *text = [textField.text mutableCopy];
    [text replaceCharactersInRange:range withString:string];
    
    if (text.length > 11 && range.length == 0)
    {
        return NO;
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self endEditing:YES];
    return YES;
}

#pragma mark - setterMethod
- (void)setTelNumber:(NSString *)telNumber
{
    _telNumber = telNumber;
    [self.baseTable reloadData];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
