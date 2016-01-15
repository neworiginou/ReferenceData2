//
//  HWWeChatOldUserBindView.m
//  Community
//
//  Created by caijingpeng.haowu on 15/1/14.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：老用户绑定微信，填写手机号密码，关联按钮 调用登录接口 获取用户信息
//
//  修改记录：
//      姓名         日期               修改内容
//     蔡景鹏     2015-01-14           创建文件
//     杨庆龙     2015-01-19           修改当不是注册用户时跳转到注册页面
//

#import "HWWeChatOldUserBindView.h"
#import "HWCoreDataManager.h"
#import "HWCustomGuideAlertView.h"

@interface HWWeChatOldUserBindView()
@property (nonatomic, strong) UITextField * telephoneTF;

@end
@implementation HWWeChatOldUserBindView
@synthesize weChatAccount;
@synthesize delegate;

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

- (void)initialHeaderView
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                  0,
                                                                  kScreenWidth,
                                                                  10)];
    headerView.backgroundColor = [UIColor clearColor];
    self.baseTable.tableHeaderView = headerView;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                            10 - 0.5f,
                                                            kScreenWidth,
                                                            0.5f)];
    line.backgroundColor = THEME_COLOR_LINE;
    [headerView addSubview:line];
    
}

- (void)initialFooterView
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    footerView.backgroundColor = [UIColor clearColor];
    self.baseTable.tableFooterView = footerView;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                            0,
                                                            kScreenWidth,
                                                            0.5f)];
    line.backgroundColor = THEME_COLOR_LINE;
    [footerView addSubview:line];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(15, 20, kScreenWidth - 30, 45.0f);
    [button setButtonOrangeStyle];
    [button setTitle:@"绑定" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(toBind:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:button];
}

-(void)guestBindOldUser
{
    [Utility showMBProgress:self message:@"绑定中"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setPObject:self.telephoneTF.text forKey:@"mobileNumber"];
    [dict setPObject:_pwdTF.text forKey:@"password"];
    [dict setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [dict setPObject:[Utility getUUIDWithoutSymbol] forKey:@"deviceId"];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POST:kGuestBindOldMobile parameters:dict queue:nil success:^(id responese)
    {
        [Utility hideMBProgress:self];
        NSDictionary *dataDic = (NSDictionary *)[responese objectForKey:@"data"];
        //用户数据保存本地
        [[HWUserLogin currentUserLogin] initUserLogin:dataDic];
        [HWCoreDataManager saveUserInfo];
        
        NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"绑定成功，"];
        NSString *content = [[[responese objectForKey:@"detail"] componentsSeparatedByCharactersInSet:set]componentsJoinedByString:@""];
        HWCustomGuideAlertView *alertView = [[HWCustomGuideAlertView alloc]initWithAlertType:3 customContent:content];
        [alertView showCustomGuideAlertViewWithCompleteBlock:^(NSInteger buttonTag)
         {
             if (buttonTag == 0)
             {
                 NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                 [userDefault setObject:@"0" forKey:kAgreeProtocol];
                 [userDefault synchronize];
                 
                 if (delegate && [delegate respondsToSelector:@selector(didPopRootVC)])
                 {
                     [delegate didPopRootVC];
                 }
             }
         }];
    } failure:^(NSString *code, NSString *error)
    {
        [Utility hideMBProgress:self];
        if ([error isEqual: @"您今日已经连续5次输入密码错误，该账号已被冻结，请在明日尝试登录或者点击“忘记密码"])
        {
            HWCustomGuideAlertView *alert = [[HWCustomGuideAlertView alloc]initWithAlertType:2];
            [alert showCustomGuideAlertViewWithCompleteBlock:^(NSInteger buttonTag) {
                
            }];
        }
        else
        {
            [Utility showToastWithMessage:error inView:self];
        }
    }];
}

-(void)normalBindOldUser
{
    [Utility showMBProgress:self message:@"登录中"];
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setPObject:self.telephoneTF.text forKey:@"mobileNumber"];
    [dict setPObject:_pwdTF.text forKey:@"password"];
    [manager POST:kLogin parameters:dict queue:nil success:^(id responseObject){
        
        // 保存key [dict objectForKey:@"key"];
        [Utility hideMBProgress:self];
        NSDictionary *dataDic = (NSDictionary *)[responseObject objectForKey:@"data"];
        //用户数据保存本地
        [[HWUserLogin currentUserLogin] initUserLogin:dataDic];
        
        if (delegate && [delegate respondsToSelector:@selector(didGetUserInfoByAccount:password:)])
        {
            [delegate didGetUserInfoByAccount:self.telephoneTF.text password:_pwdTF.text];
        }
        
    }failure:^(NSString *code, NSString *error) {
        //2.您的微信账号已经是考拉账号，可以直接登录
        //3.您的手机号已经是考拉账号，可以直接登录考拉社区
        //4.您输入的手机没有注册考拉考拉账号
        //5.登录密码错误
        //6.您输入的手机号已绑定微信账号
        
        [Utility hideMBProgress:self];
        
        if (code.intValue == 2)
        {
            NSString *alertMessage = [NSString stringWithFormat:@"%@没有注册考拉账号,请注册",self.telephoneTF.text];
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:alertMessage delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alertView showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
                if (buttonIndex == 1)
                {
                    if ([self.delegate respondsToSelector:@selector(didNotRegister:)] && self.delegate != nil)
                    {
                        [self.delegate didNotRegister:self.telephoneTF.text];
                    }
                }
            }];
        }
        else
        {
            if ([error isEqual: @"密码输入错误"])
            {
                [Utility showToastMBProgress:self message:error imageName:@"login_error"];
            }
            else
            {
                [Utility showToastWithMessage:error inView:self];
            }
        }
    }];
}

#pragma mark -
#pragma mark        Button Action Method

- (void)toBind:(id)sender
{
    
    if (self.telephoneTF.text.length == 0)
    {
        [Utility showToastWithMessage:@"请输入手机号" inView:self];
        return;
    }
    if (_pwdTF.text.length == 0)
    {
        [Utility showToastWithMessage:@"请输入登录密码" inView:self];
        return;
    }
    [self endEditing:YES];
    
    //isGuest==YES 游客绑定老用户 isGuest==NO 微信绑定老用户
    if (self.isGuest == YES)
    {
        [self guestBindOldUser];
    }
    else
    {
        [self normalBindOldUser];
    }
}


#pragma mark -
#pragma mark        UITableView Delegate DataSource

- (UITextField *)telephoneTF
{
    if (_telephoneTF == nil)
    {
        _telephoneTF = [[HWTextField alloc] initWithFrame:CGRectMake(15, 0, kScreenWidth - 30, 45)] ;
        _telephoneTF.placeholder = @"请输入手机号";
        _telephoneTF.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
        _telephoneTF.textColor = THEME_COLOR_SMOKE;
        _telephoneTF.keyboardType = UIKeyboardTypeNamePhonePad;
        _telephoneTF.delegate = self;
        _telephoneTF.returnKeyType = UIReturnKeyDone;
        _telephoneTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _telephoneTF;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
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
    
    if (indexPath.row == 0)
    {
//        _telephoneTF = [[HWTextField alloc] initWithFrame:CGRectMake(15, 0, kScreenWidth - 30, 45)];
//        _telephoneTF.placeholder = @"请输入手机号";
//        _telephoneTF.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
//        _telephoneTF.textColor = THEME_COLOR_SMOKE;
//        _telephoneTF.keyboardType = UIKeyboardTypeNamePhonePad;
//        _telephoneTF.delegate = self;
//        
//        _telephoneTF.returnKeyType = UIReturnKeyDone;
//        _telephoneTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        [cell.contentView addSubview:self.telephoneTF];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                45 - 0.5f,
                                                                kScreenWidth,
                                                                0.5f)];
        line.backgroundColor = THEME_COLOR_LINE;
        [cell.contentView addSubview:line];
    }
    else
    {
        _pwdTF = [[HWTextField alloc] initWithFrame:CGRectMake(15, 0, kScreenWidth - 30, 45)];
        _pwdTF.placeholder = @"请输入登录密码";
        _pwdTF.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
        _pwdTF.textColor = THEME_COLOR_SMOKE;
        //        _telephoneTF.delegate = self;
        _pwdTF.returnKeyType = UIReturnKeyDone;
        _pwdTF.secureTextEntry = YES;
        _pwdTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        [cell.contentView addSubview:_pwdTF];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.0f;
}

#pragma mark -
#pragma mark        UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSMutableString *text = [textField.text mutableCopy];
    [text replaceCharactersInRange:range withString:string];
    
    if (text.length > 11 && range.length == 0)
    {
        return NO;
    }
    
    /*
     if (text.length != 11 && IOS7)
     {
     [_loginBtn setInactiveState];
     }
     else if (![Utility validateMobile:text])
     {
     [_loginBtn setInactiveState];
     }
     else if (_passwordTF.text.length == 0)
     {
     [_loginBtn setInactiveState];
     }
     else
     {
     [_loginBtn setActiveState];
     }
     */
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self endEditing:YES];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == _telephoneTF)
    {
        
    }
    else if (textField == _pwdTF)
    {
        [MobClick event:@"get_focus_wechatlogin_inputpassword"];
    }
    return YES;
}

#pragma mark - setterMethod

- (void)setTelNumber:(NSString *)telNumber
{
    _telNumber = telNumber;
    self.telephoneTF.text = _telNumber;
    NSLog(@"self.telphoneNum === %@",telNumber);

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
