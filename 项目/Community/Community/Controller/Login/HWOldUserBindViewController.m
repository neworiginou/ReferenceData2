//
//  HWOldUserBindViewController.m
//  Community
//
//  Created by caijingpeng.haowu on 15/1/9.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：老用户绑定微信，填写手机号密码，关联按钮 调用登录接口 获取用户信息
//
//  修改记录：
//      姓名         日期               修改内容
//     蔡景鹏     2015-01-14           创建文件
//     杨庆龙     2015-01-19           修改了oldUserView初始化时机
//

#import "HWOldUserBindViewController.h"
#import "HWOldUserPasswordViewController.h"
#import "HWWeChatOldUserBindView.h"
#import "HWNewUserBindViewController.h"
@interface HWOldUserBindViewController ()<UITextFieldDelegate, HWWeChatOldUserBindViewDelegate>
{
    
}
@end

@implementation HWOldUserBindViewController
@synthesize weChatAccount;

- (id)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.navigationItem.titleView = [Utility navTitleView:@"绑定考拉账号"];
    
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];

    HWWeChatOldUserBindView *oldUserView = [[HWWeChatOldUserBindView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT)];
    oldUserView.weChatAccount = self.weChatAccount;
    oldUserView.delegate = self;
    oldUserView.telNumber = self.telphoneNum;
    oldUserView.isGuest = self.isGuest;
    NSLog(@"self.telphoneNum === %@",self.telphoneNum);
    [self.view addSubview:oldUserView];
}

#pragma mark -
#pragma mark            HWWeChatOldUserBindViewDeleagate

-(void)didPopRootVC
{
    [[NSNotificationCenter defaultCenter] postNotificationName:RELOAD_APP_DATA object:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
//    [self.navigationController popToViewController:[self.navigationController.viewControllers pObjectAtIndex:self.navigationController.viewControllers.count - 3] animated:YES];
}

- (void)didGetUserInfoByAccount:(NSString *)account password:(NSString *)pwd
{
    HWOldUserPasswordViewController *oldPwdVC = [[HWOldUserPasswordViewController alloc] init];
    oldPwdVC.weChatAccount = self.weChatAccount;
    oldPwdVC.accountStr = account;
    oldPwdVC.passwordStr = pwd;
    [self.navigationController pushViewController:oldPwdVC animated:YES];
}

- (void)didBindMobileSuccess
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didNotRegister:(NSString *)telNumber
{
    HWNewUserBindViewController *newUserBindCtrl = [[HWNewUserBindViewController alloc]init];
    newUserBindCtrl.telephoneNum = telNumber;
    newUserBindCtrl.weChatAccount = self.weChatAccount;
    [self.navigationController pushViewController:newUserBindCtrl animated:YES];
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
