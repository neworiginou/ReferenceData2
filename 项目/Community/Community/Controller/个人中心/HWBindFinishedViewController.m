//
//  HWBindFinishedViewController.m
//  Community
//
//  Created by caijingpeng.haowu on 15/1/16.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：个人资料 已绑定微信 页面
//
//  修改记录：
//      姓名         日期               修改内容
//     蔡景鹏     2015-01-16           创建文件
//
//

#import "HWBindFinishedViewController.h"
#import "AppDelegate.h"

@interface HWBindFinishedViewController ()

@end

@implementation HWBindFinishedViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.titleView = [Utility navTitleView:@"微信号绑定"];
    if ([[HWUserLogin currentUserLogin].isBindMobile isEqualToString:@"1"])
    {
        self.navigationItem.rightBarButtonItem = [Utility navButton:self title:@"解绑" action:@selector(toUnbind:)];

    }
    else
    {
        self.navigationItem.rightBarButtonItem = [Utility navButton:self title:@"解绑" action:@selector(unBindTel:)];

    }

    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    
    UIImageView *iconImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 59, 59)];
    iconImgV.image = [UIImage imageNamed:@"associate_weixin"];
    iconImgV.center = CGPointMake(kScreenWidth / 2.0f, 65);
    [self.view addSubview:iconImgV];
    
    UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(iconImgV.frame) + 10, kScreenWidth, 25.0f)];
    infoLabel.backgroundColor = [UIColor clearColor];
    infoLabel.textAlignment = NSTextAlignmentCenter;
    infoLabel.textColor = THEME_COLOR_SMOKE;
    infoLabel.text = @"你已绑定微信";
    infoLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
    [self.view addSubview:infoLabel];
    
    UILabel *nicknameLab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(infoLabel.frame), kScreenWidth, 25)];
    nicknameLab.backgroundColor = [UIColor clearColor];
    nicknameLab.textAlignment = NSTextAlignmentCenter;
    nicknameLab.textColor = THEME_COLOR_TEXT;
    nicknameLab.text = [NSString stringWithFormat:@"昵称：%@", [HWUserLogin currentUserLogin].weixinNickname];
    nicknameLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL13];
    [self.view addSubview:nicknameLab];
}

- (void)unBindTel:(UIButton *)bte
{
    [Utility showToastWithMessage:@"未绑定手机,请先绑定手机" inView:self.view];
    
}

- (void)toUnbind:(id)sender
{
    [MobClick event:@"click_disconnet_wechat"]; //maidian_1.2.1
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"解绑后需要重新绑定才能使用微信登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
        if (buttonIndex == 1)
        {
            
            [Utility showMBProgress:self.view message:@"解绑中"];
            HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            [param setPObject:[HWUserLogin currentUserLogin].userId forKey:@"userId"];
            [param setPObject:[HWUserLogin currentUserLogin].openId forKey:@"openid"];
            [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
            
            [manager POST:kUnBindWeChat parameters:param queue:nil success:^(id responese) {
                
                [Utility hideMBProgress:self.view];
                
                [HWUserLogin currentUserLogin].isBindWeixin = @"0";
                [HWCoreDataManager saveUserInfo];
                
                AppDelegate *appDel = (AppDelegate *)SHARED_APP_DELEGATE;
                [Utility showToastWithMessage:@"解绑成功" inView:appDel.window];
                [self.navigationController popViewControllerAnimated:YES];
                
            } failure:^(NSString *code, NSString *error) {
                [Utility hideMBProgress:self.view];
                [Utility showToastWithMessage:error inView:self.view];
            }];
        }

        
    }];
    /*
     接口名称：/hw-sq-app-web/weixin/unbindWeixin.do
     输入参数：
     userId 考拉社区用户userId
     openid 普通用户的标识，对当前开发者帐号唯一
     输出参数：
     成功：
     { status: "1", data: null, detail: "解绑微信成功", key: "ad5d8829-fa15-44db-87be-00acecf67ee5" }
     失败：
     { status: "0", data: null, detail: "该账号未绑定手机号，无法解绑", key: "ad5d8829-fa15-44db-87be-00acecf67ee5" } { status: "0", data: null, detail: "该考拉账号未绑定此微信号，无需解绑", key: "ad5d8829-fa15-44db-87be-00acecf67ee5" } { status: "0", data: "", detail: "解绑微信失败", key: "ad5d8829-fa15-44db-87be-00acecf67ee5" }
     */
    
}

- (void)didReceiveMemoryWarning
{
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
