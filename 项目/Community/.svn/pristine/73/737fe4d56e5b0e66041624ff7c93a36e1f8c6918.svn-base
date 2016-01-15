//
//  HWRegisterThirdViewController.m
//  Community
//
//  Created by caijingpeng.haowu on 14-8-28.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//
//  功能描述：输入登录密码
//
//  修改记录：
//      姓名         日期               修改内容
//     蔡景鹏     2015-01-14           添加微信接口
//     蔡景鹏     2015-01-20           添加手机绑定流程中 输入密码
//

#import "HWRegisterThirdViewController.h"
#import "HWRegisterFourthViewController.h"
#import "HWInputBackView.h"
#import "HWHTTPRequestOperationManager.h"
#import "HWRequestConfig.h"
#import "HWCoreDataManager.h"
#import "HWLocationChangeViewController.h"

@interface HWRegisterThirdViewController ()
{
    UIButton *_confirmBtn;
    UITextField *_pwdTF;
}

@end

@implementation HWRegisterThirdViewController
@synthesize telephoneNum;
@synthesize isWeChat;
@synthesize weChatAccount;
@synthesize isBind;
@synthesize bindPopViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.isWeChat = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.titleView = [Utility navTitleView:@"设置登录密码"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    
    HWInputBackView *backView = [[HWInputBackView alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth - 50, 45.0f) withLineCount:1];
    [self.view addSubview:backView];
    
    _pwdTF = [[UITextField alloc] initWithFrame:CGRectMake(15, CGRectGetMinY(backView.frame) + 7.5f + (!IOS7 ? 5 : 0), kScreenWidth - 30.0f - 50, 30)];
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
    _confirmBtn.frame = CGRectMake(15.0f, CGRectGetMaxY(label.frame) + 20.0f + 40, kScreenWidth - 30.0f, 45.0f);
    
    [_confirmBtn setTitle:@"提交" forState:UIControlStateNormal];
    [_confirmBtn setButtonOrangeStyle];
    [_confirmBtn setInactiveState];
    [_confirmBtn addTarget:self action:@selector(setNewPassward) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_confirmBtn];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doTap:)];
    [self.view addGestureRecognizer:tap];
    
    _isShowPass = NO;
    _passButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _passButton.frame = CGRectMake(kScreenWidth - 54, 0, 44, 44);
    [_passButton setImage:[UIImage imageNamed:@"pass_show"] forState:UIControlStateNormal];
    _passButton.center = CGPointMake(kScreenWidth - (50 / 2.0), backView.frame.origin.y + backView.frame.size.height / 2.0f);
    [_passButton setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [_passButton addTarget:self action:@selector(doTap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_passButton];
}

- (void)doTap
{
    _isShowPass = !_isShowPass;
    if (_isShowPass) {
        _pwdTF.enabled = NO;
        _pwdTF.secureTextEntry = NO;
         _pwdTF.enabled = YES;
        [_pwdTF setText:_pwdTF.text];
        [_passButton setImage:[UIImage imageNamed:@"pass_hide"] forState:UIControlStateNormal];
    }else{
        _pwdTF.enabled = NO;
        _pwdTF.secureTextEntry = YES;
        _pwdTF.enabled = YES;
        [_pwdTF setText:_pwdTF.text];
        [_passButton setImage:[UIImage imageNamed:@"pass_show"] forState:UIControlStateNormal];
    }
}

#pragma mark -
#pragma mark Private method

- (void)doTap:(id)sender
{
    [self.view endEditing:YES];
}

//设置新密码
-(void)setNewPassward
{
    [MobClick event:@"click_changepersonalfilespassword_submit"]; //maidian_1.2.1
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
    
    [MobClick event:@"click_submit_newloginpassword"];
    
    [self.view endEditing:YES];
    
    
    
    if (isBind && [Utility isGuestLogin] == NO)
    {
        [Utility showMBProgress:self.view message:@"绑定中"];
        HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setPObject:self.telephoneNum forKey:@"mobileNumber"];
        [dict setPObject:_pwdTF.text forKey:@"password"];
        [dict setPObject:[HWUserLogin currentUserLogin].openId forKey:@"openid"];
        [dict setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
        [manager POST:kBindMobile parameters:dict queue:nil success:^(id responseObject){
            
            // 验证设置 昵称 设置 返回页面
//            // 保存key [dict objectForKey:@"key"];
            [Utility hideMBProgress:self.view];
            NSDictionary *dataDic = (NSDictionary *)[responseObject objectForKey:@"data"];
            //用户数据保存本地
            [[HWUserLogin currentUserLogin] initUserLogin:dataDic];
            [HWCoreDataManager saveUserInfo];

//            if (delegate && [delegate respondsToSelector:@selector(didBindMobileSuccess)])
//            {
//                [delegate didBindMobileSuccess];
//            }
            
            if (self.bindPopViewController != nil)
            {
                [self.navigationController popToViewController:self.bindPopViewController animated:YES];
            }
            else
            {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            
        }failure:^(NSString *code, NSString *error) {
            [Utility hideMBProgress:self.view];
            [Utility showToastWithMessage:error inView:self.view];
        }];
    }
    else if (isBind && [Utility isGuestLogin] == YES)
    {
        //游客绑定未注册手机 设置密码
        [self doConfirm];
#if 0
        [Utility showMBProgress:self.view message:@"绑定中"];
        HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setPObject:self.telephoneNum forKey:@"mobileNumber"];
        [dict setPObject:_pwdTF.text forKey:@"password"];
        [dict setPObject:[HWUserLogin currentUserLogin].openId forKey:@"openid"];
        [dict setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
        [manager POST:kGuestBindNewMobile parameters:dict queue:nil success:^(id responseObject){
            
            // 验证设置 昵称 设置 返回页面
            //            // 保存key [dict objectForKey:@"key"];
            [Utility hideMBProgress:self.view];
            NSDictionary *dataDic = (NSDictionary *)[responseObject objectForKey:@"data"];
            //用户数据保存本地
            [[HWUserLogin currentUserLogin] initUserLogin:dataDic];
            [HWCoreDataManager saveUserInfo];
            
            if (self.bindPopViewController != nil)
            {
                [self.navigationController popToViewController:self.bindPopViewController animated:YES];
            }
            else
            {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            
        }failure:^(NSString *code, NSString *error) {
            [Utility hideMBProgress:self.view];
            [Utility showToastWithMessage:error inView:self.view];
        }];
#endif
    }
    else
    {
        if (isWeChat)
        {
            // 微信 新用户登录
            
            /*
             接口名称：/hw-sq-app-web/weixin/bindMobileLogin.do
             输入参数：
             mobileNumber：用户手机号
             password：登录密码
             isNewUser：1：新用户；0：老用户
             openid： 普通用户的标识，对当前开发者帐号唯一
             unionid： 用户统一标识。针对一个微信开放平台帐号下的应用，同一用户的unionid是唯一的。
             nickname： 普通用户昵称
             sex： 普通用户性别，1为男性，2为女性
             headimgurl：用户头像，最后一个数值代表正方形头像大小（有0、46、64、96、132数值可 选，0代表640*640正方形头像），用户没有头像时该项为空
             province： 普通用户个人资料填写的省份
             city： 普通用户个人资料填写的城市
             
             成功：（与社区登录接口返回信息相同）
             {
             status: "1",
             data:
             { userId: "1076068076067", residentId: "2152136", telephoneNum: "18221398081", nickname: "小太阳", gender: "1", favorite: null, avatarUrl: "file/downloadByKey.do?mKey=54b386f573feaf09cf45c4b9", isGag: 0, key: "f3eeb12b-a17d-49b0-9318-aa3177e2b476", cityId: null, cityName: null, villageId: null, villageName: null, villageAddress: null, tenementId: null, shopId: null, isReceiveMsg: "1", isRecevieWy: "1", isRecevieShop: "1", isVoiceOn: "1", isShakeOn: "1", openid: "o6_bmasdasdsad6_2sgVt7hMZOPfL987654" }
             ,
             detail: "请求数据成功!",
             key: "f3eeb12b-a17d-49b0-9318-aa3177e2b476"
             }
             失败：
             { status: "0", data: "", detail: "请输入正确的手机号码", key: "edb86399-cb63-4dcd-b80e-2a712e973bed" } { status: "0", data: "", detail: "您的微信账号已经是考拉账号，可以直接登录", key: "edb86399-cb63-4dcd-b80e-2a712e973bed" }
             新用户：
             { status: "0", data: "", detail: "您的手机号已经是考拉账号，可以直接登录考拉社区", key: null }
             老用户：
             { status: "0", data: "", detail: "您输入的手机没有注册考拉考拉账号", key: null } { status: "0", data: "", detail: "登录密码错误", key: null } { "status": "0", "data": null, "detail": "登录失败", "key": "" }
             
             */
            
            [MobClick event:@"get_focus_wechatlogin_setinputpassword"];
            
            [Utility showMBProgress:self.view message:LOADING_TEXT];
            HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            [dict setPObject:telephoneNum forKey:@"mobileNumber"];
            [dict setPObject:_pwdTF.text forKey:@"password"];
            [dict setPObject:@"1" forKey:@"isNewUser"];
            [dict setPObject:self.weChatAccount.openId forKey:@"openid"];
            [dict setPObject:self.weChatAccount.unionId forKey:@"unionid"];
            [dict setPObject:self.weChatAccount.userName forKey:@"nickname"];
            [dict setPObject:self.weChatAccount.gender forKey:@"sex"];
            [dict setPObject:self.weChatAccount.headIconUrl forKey:@"headimgurl"];
            [dict setPObject:self.weChatAccount.location forKey:@"location"];
            
            [manager POST:kBindWeChat parameters:dict queue:nil success:^(id responseObject){
                //保存key [dict objectForK872588ey:@"key"];
                [Utility hideMBProgress:self.view];
                NSDictionary *dataDic = [responseObject objectForKey:@"data"];
                //用户数据保存本地
                [[HWUserLogin currentUserLogin] initUserLogin:dataDic];
                [HWCoreDataManager saveUserInfo]; // 保存数据库
                
                [[HWUserLogin currentUserLogin] registSucceed];
                
                HWLocationChangeViewController *selectCommunityView = [[HWLocationChangeViewController alloc]init];
                selectCommunityView.locationChangeFlag = NO;
                selectCommunityView.isNickVCPush = YES;
                selectCommunityView.isCheckIPBindVillageId = YES;
                [self.navigationController pushViewController:selectCommunityView animated:YES];
                
            } failure:^(NSString *code, NSString *error) {
                [Utility hideMBProgress:self.view];
                [Utility showToastWithMessage:error inView:self.view];
                NSLog(@"error");
            }];
            
        }
        else
        {
     //       [self doConfirm];

            
#if 1
            [Utility showMBProgress:self.view message:LOADING_TEXT];
            HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            [dict setPObject:telephoneNum forKey:@"mobileNumber"];
            [dict setPObject:_pwdTF.text forKey:@"password"];
            [manager POST:kSubmitRegister parameters:dict queue:nil success:^(id responseObject){
                //保存key [dict objectForK872588ey:@"key"];
                [Utility hideMBProgress:self.view];
                NSDictionary *dataDic = [responseObject objectForKey:@"data"];
                //用户数据保存本地
                
                // 注册成功
                [[HWUserLogin currentUserLogin] registSucceed];
                [[HWUserLogin currentUserLogin] initUserLogin:dataDic];
                [HWCoreDataManager saveUserInfo]; // 保存数据库
                
                [self doConfirm];
            } failure:^(NSString *code, NSString *error) {
                [Utility hideMBProgress:self.view];
                [Utility showToastWithMessage:error inView:self.view];
                NSLog(@"error");
            }];
#endif
        }
    }
    
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
    if (isWeChat)
    {
        [MobClick event:@"click_wechatlogin_inputpassword_sure"];
    }
    
    HWRegisterFourthViewController *regFourthVC = [[HWRegisterFourthViewController alloc] init];
    regFourthVC.telephoneNum = self.telephoneNum;
    regFourthVC.password = _pwdTF.text;
    regFourthVC.isGuest = self.isGuest;
    [self.navigationController pushViewController:regFourthVC animated:YES];
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
    [MobClick event:@"get_focus_changepersonalfilespassword"]; //maidian_1.2.1
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
