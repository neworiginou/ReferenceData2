//
//  HWReLoginViewController.m
//  Community
//
//  Created by niedi on 15/8/3.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：游客登录后置 输手机号页面
//
//  修改记录：
//      姓名         日期               修改内容
//     聂迪       2015-08-03           创建文件
//

#import "HWReLoginViewController.h"
#import "HWReLoginView.h"
#import "HWReLoginLoginVC.h"
#import "HWReLoginRegistVC.h"

@interface HWReLoginViewController ()<HWReLoginViewDelegate>
{
    HWReLoginView *_mainView;
}
@end

@implementation HWReLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [Utility navTitleView:@"登录/注册"];
    
    _mainView = [[HWReLoginView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT)];
    _mainView.delegate = self;
    [self.view addSubview:_mainView];
}

- (void)backMethod
{
    [MobClick event:@"logreg_click_back"];//1.7
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - HWReLoginViewDelegate
- (void)goToLogin:(NSString *)mobilNum
{
    HWReLoginLoginVC *reLoginVC = [[HWReLoginLoginVC alloc] init];
    reLoginVC.telephone = mobilNum;
    if (self.childViewControllers.count != 0)
    {
        [reLoginVC addChildViewController:[self.childViewControllers pObjectAtIndex:0]];
    }
    [self.navigationController pushViewController:reLoginVC animated:YES];
}

- (void)goToRegist:(NSString *)mobilNum
{
    HWReLoginRegistVC *rvc = [[HWReLoginRegistVC alloc] init];
    rvc.mobilNum = mobilNum;
    if (self.childViewControllers.count != 0)
    {
        [rvc addChildViewController:[self.childViewControllers pObjectAtIndex:0]];
    }
    [self.navigationController pushViewController:rvc animated:YES];
}

- (void)pushViewController:(UIViewController *)vc
{
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
