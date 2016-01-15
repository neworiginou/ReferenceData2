//
//  HWReLoginView.m
//  Community
//
//  Created by niedi on 15/8/3.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWReLoginView.h"
#import "AppDelegate.h"
#import "HWWeChatBindViewController.h"

@interface HWReLoginView ()<UITextFieldDelegate>
{
    HWTextField *_telephoneTF;
}
@end

@implementation HWReLoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.isNeedHeadRefresh = NO;
        [self loadUI];
    }
    return self;
}

- (void)confirmBtnClick
{
    [MobClick event:@"logreg_click_next"];//1.7
    
    [Utility showMBProgress:self message:@"验证中..."];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setPObject:_telephoneTF.text forKey:@"mobileNumber"];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POST:kVaildateMobile parameters:dict queue:nil success:^(id responese) {
        
        [Utility hideMBProgress:self];
        
        AppDelegate *appDel = (AppDelegate *)SHARED_APP_DELEGATE;
        [Utility showToastWithMessage:@"你还没注册，请注册新账号" inView:appDel.window];
        //游客绑定新账号
        
        if([self.delegate respondsToSelector:@selector(goToRegist:)] && self.delegate != nil)
        {
            [self.delegate goToRegist:_telephoneTF.text];
        }
        
    } failure:^(NSString *code, NSString *error) {
        
        [Utility hideMBProgress:self];
        //游客绑定旧账号
        if ([error isEqual: @"该手机号码已注册过"] || [error isEqual: @"亲，抢钱宝的用户可以直接登入考拉社区哦"])
        {
            AppDelegate *appDel = (AppDelegate *)SHARED_APP_DELEGATE;
            [Utility showToastWithMessage:@"你已注册过，请登录" inView:appDel.window];
            
            if([self.delegate respondsToSelector:@selector(goToLogin:)] && self.delegate != nil)
            {
                [self.delegate goToLogin:_telephoneTF.text];
            }
        }
        else
        {
            [Utility showToastWithMessage:error inView:self];
        }
    }];
}

- (void)weiXinLogin
{
    [MobClick event:@"click_Weichat"];//1.7
    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
    snsPlatform.loginClickHandler((UIViewController *)self.delegate,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        //          获取用户名、uid、token等
        
        if (response.responseCode == UMSResponseCodeSuccess)
        {
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToWechatSession];
            
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            // 调用接口 判断是否已授权过
            [self checkAuth:snsAccount];
        }
        else
        {
            [Utility showToastWithMessage:@"授权失败" inView:self];
        }
        
    });
}

- (void)checkAuth:(UMSocialAccountEntity *)account
{
    [Utility showMBProgress:self message:@"授权中"];
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setPObject:account.openId forKey:@"openid"];
    
    [manager POST:kCheckWeiXinAuth parameters:dict queue:nil success:^(id responseObject) {
        
        [Utility hideMBProgress:self];
        // 直接登录
        
        NSDictionary *dataDic = (NSDictionary *)[responseObject objectForKey:@"data"];
        //用户数据保存本地
        UIViewController *loginVC = (UIViewController *)self.delegate;
        [HWUserLogin currentUserLogin].isLoginToWeiXin = YES;
        [[HWUserLogin currentUserLogin] handleLoginInfo:dataDic operationController:loginVC];
        
    } failure:^(NSString *code, NSString *error) {
        [Utility hideMBProgress:self];
        if (code.intValue == 0)
        {
            //            // 未授权过
            [self bindWeChat:account];
        }
        else
        {
            [Utility showToastWithMessage:error inView:self];
        }
    }];
}
- (void)bindWeChat:(UMSocialAccountEntity *)snsAccount
{
    [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToWechatSession  completion:^(UMSocialResponseEntity *response){
        
        NSLog(@"SnsInformation is %@",response.data);
        
        HWWeChatAccountModel *wechatAccount = [[HWWeChatAccountModel alloc] init];
        wechatAccount.userName = snsAccount.userName;
        wechatAccount.gender = [response.data stringObjectForKey:@"gender"];
        wechatAccount.accessToken = snsAccount.accessToken;
        wechatAccount.openId = snsAccount.openId;
        wechatAccount.unionId = snsAccount.usid;
        wechatAccount.location = [response.data stringObjectForKey:@"location"];
        wechatAccount.headIconUrl = [response.data stringObjectForKey:@"profile_image_url"];
        
        HWWeChatBindViewController *wechatVC = [[HWWeChatBindViewController alloc] init];
        wechatVC.weChatAccount = wechatAccount;
        [self pushVC:wechatVC];
    }];
}

- (void)pushVC:(UIViewController *)vc
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(pushViewController:)])
    {
        [self.delegate pushViewController:vc];
    }
}

- (void)loadUI
{
    self.baseTable.scrollEnabled = NO;
    
    DView *tableHeaderV = [DView viewFrameX:0 y:0 w:kScreenWidth h:CONTENT_HEIGHT];
    
    DView *backV = [DView viewFrameX:0 y:10.0f w:kScreenWidth h:CONTENT_HEIGHT - 10];
    backV.backgroundColor = [UIColor whiteColor];
    [tableHeaderV addSubview:backV];
    
    DView *tFBackV = [DView viewFrameX:25.0f y:25.0f w:kScreenWidth - 2 * 25 h:45.0f];
    tFBackV.layer.borderColor = THEME_COLOR_LINE.CGColor;
    tFBackV.layer.cornerRadius = 2.5f;
    tFBackV.layer.borderWidth = 0.5f;
    [backV addSubview:tFBackV];
    
    _telephoneTF = [[HWTextField alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth - 2 * 25 - 2 * 10, 45)];
    _telephoneTF.placeholder = @"输入手机号";
    _telephoneTF.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
    _telephoneTF.textColor = THEME_COLOR_SMOKE;
    _telephoneTF.keyboardType = UIKeyboardTypeNumberPad;
    _telephoneTF.delegate = self;
    _telephoneTF.returnKeyType = UIReturnKeyDone;
    _telephoneTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [tFBackV addSubview:_telephoneTF];
    
    DButton *confirmBtn = [DButton btnTxt:@"下一步" txtFont:TF18 frameX:25.0f y:CGRectGetMaxY(tFBackV.frame) + 40 w:kScreenWidth - 2 * 25.0f h:45.0f target:self action:@selector(confirmBtnClick)];
    [confirmBtn setStyle:DBtnStyleMain];
    [confirmBtn setRadius:3.5f];
    [backV addSubview:confirmBtn];
    
    DView *buttomBackV = [DView viewFrameX:0 y:CONTENT_HEIGHT - 90.0f w:kScreenWidth h:90.0f];
    [backV addSubview:buttomBackV];
    
    NSString *weiXinStr = @"第三方账号登录";
    CGFloat width = [Utility calculateStringWidth:weiXinStr font:FONT(14) constrainedSize:CGSizeMake(10000, 15)].width;
    DLable *weiXinLab = [DLable LabTxt:weiXinStr txtFont:TF14 txtColor:UIColorFromRGB(0xeeeeee) frameX:0 y:0 w:kScreenWidth h:18];
    weiXinLab.textAlignment = NSTextAlignmentCenter;
    [buttomBackV addSubview:weiXinLab];
    
    CALayer *leftLine = [DView layerFrameX:25.0f y:7.5f w:(kScreenWidth - width - 25.0 * 2 - 8 * 2) / 2.0f h:0.5f];
    [buttomBackV.layer addSublayer:leftLine];
    
    CALayer *rightLine = [DView layerFrameX:kScreenWidth - 25.0f - CGRectGetWidth(leftLine.frame) y:CGRectGetMinY(leftLine.frame) w:CGRectGetWidth(leftLine.frame) h:0.5f];
    [buttomBackV.layer addSublayer:rightLine];
    
    if ([Utility isInstalledWX])
    {
        DImageV *weiXinImgV = [DImageV imagV:@"weiXinLogin" frameX:(kScreenWidth - 54) / 2.0f y:25.0f w:54.0f h:44.0f];
        weiXinImgV.userInteractionEnabled = YES;
        [buttomBackV addSubview:weiXinImgV];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(weiXinLogin)];
        [weiXinImgV addGestureRecognizer:tap];
    }
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEdit)];
    [tableHeaderV addGestureRecognizer:tap1];
    
    self.baseTable.tableHeaderView = tableHeaderV;
}

#pragma mark        UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [MobClick event:@"logreg_get_focus_phonenumber"];//1.7
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

#pragma mark - UIScrollViewDelegate
- (void)endEdit
{
    [self endEditing:YES];
}

@end
