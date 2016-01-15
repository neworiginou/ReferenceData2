//
//  HWCommonditySellUpViewController.m
//  Community
//
//  Created by ryder on 7/30/15.
//  Copyright (c) 2015 caijingpeng. All rights reserved.
//
//  功能描述：
//      天天团商品售完页面
//  修改记录：
//      姓名         日期              修改内容
//     程耀均     2015-07-30           创建文件

#import "HWCommonditySellUpViewController.h"
#import "HWCommondityListController.h"

@interface HWCommonditySellUpViewController ()

@end

@implementation HWCommonditySellUpViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    self.sellupView = [[HWCommonditySellUpView alloc] init];
    [self.view addSubview:self.sellupView];
    self.sellupView.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)didShowCommodityList
{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    BOOL isHaveListVC = NO;
    NSArray *naVCS = self.navigationController.viewControllers;
    for (UIViewController *vc in naVCS)
    {
        if ([vc isKindOfClass:[HWCommondityListController class]])
        {
            isHaveListVC = YES;
            [self.navigationController popToViewController:vc animated:YES];
            break;
        }
    }
    
    if (!isHaveListVC)
    {
        HWCommondityListController *controller = [[HWCommondityListController alloc] init];
        controller.popType = listVCPopVCTypeOneVC;
        [self.navigationController pushViewController:controller animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
