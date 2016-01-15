//
//  HWOldUserPasswordViewController.m
//  Community
//
//  Created by caijingpeng.haowu on 15/1/9.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：老用户 确认关联 微信账号
//
//  修改记录：
//      姓名         日期               修改内容
//     蔡景鹏     2015-01-14           创建文件
//
//

#import "HWOldUserPasswordViewController.h"
#import "HWWeChatOldConfirmBindView.h"

@interface HWOldUserPasswordViewController ()<UITextFieldDelegate, HWWeChatOldConfirmBindViewDelegate>
{
    
}
@end

@implementation HWOldUserPasswordViewController
@synthesize weChatAccount;
@synthesize accountStr;
@synthesize passwordStr;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.titleView = [Utility navTitleView:@"绑定考拉账户"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    
    HWWeChatOldConfirmBindView *confirmView = [[HWWeChatOldConfirmBindView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT)];
    confirmView.weChatAccount = self.weChatAccount;
    confirmView.accountStr = self.accountStr;
    confirmView.passwordStr = self.passwordStr;
    confirmView.delegate = self;
    [confirmView initialView];
    [self.view addSubview:confirmView];
    
}

#pragma mark -
#pragma mark        HWWeChatOldConfirmBindView Delegate

- (void)didConfirmBindWeChatByUserInfo:(NSDictionary *)userInfo
{
    [[HWUserLogin currentUserLogin] handleLoginInfo:userInfo operationController:self];
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
