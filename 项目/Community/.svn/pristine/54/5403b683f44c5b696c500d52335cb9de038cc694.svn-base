//
//  HWAuthenticateStressAddressViewController.m
//  Community
//
//  Created by hw500027 on 15/6/15.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：个人资料 认证门牌界面
//
//  修改记录：
//      姓名         日期               修改内容
//     陆晓波     2015-06-15           创建文件
//

#import "HWAuthenticateStressAddressViewController.h"
#import "HWAuthenticateStressAddressView.h"
#import "HWAuthenticateWaitMailViewController.h"

@interface HWAuthenticateStressAddressViewController () <HWAuthenticateStressAddressViewDelegate>

@end

@implementation HWAuthenticateStressAddressViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.titleView = [Utility navTitleView:@"认证门牌"];
    HWAuthenticateStressAddressView * view = [[HWAuthenticateStressAddressView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT)];
    view.delegate = self;
    [self.view addSubview:view];
}

- (void)didSelectConfirmBtn
{
    HWAuthenticateWaitMailViewController *vc = [[HWAuthenticateWaitMailViewController alloc] init];
    vc.isPopThreeVC = YES;
    [self.navigationController pushViewController:vc animated:YES];
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
