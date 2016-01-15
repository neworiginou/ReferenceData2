//
//  HWAuthenticateViewController.m
//  Community
//
//  Created by hw500027 on 15/6/15.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：个人资料 认证 添加门牌界面
//
//  修改记录：
//      姓名         日期               修改内容
//     陆晓波     2015-06-15           创建文件
//

#import "HWAuthenticateViewController.h"
#import "HWAuthenticateView.h"
#import "HWAuthenticateChoseVC.h"

@interface HWAuthenticateViewController ()<HWAuthenticateViewDelegate>

@end

@implementation HWAuthenticateViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.titleView = [Utility navTitleView:@"添加门牌"];
    
    HWAuthenticateView *view = [[HWAuthenticateView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT)];
    view.delegate = self;
    [self.view addSubview:view];
}

//跳转 添加门牌
- (void)didSelectAddAddressLabel:(UIViewController *)vc
{
    [self.navigationController pushViewController:vc animated:YES];
}

//添加门牌 提交申请
- (void)didSelectConfirmBtn
{
    HWAuthenticateChoseVC *chooseVC = [[HWAuthenticateChoseVC alloc] init];
    [self.navigationController pushViewController:chooseVC animated:YES];
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
