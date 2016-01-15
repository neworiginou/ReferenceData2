//
//  HWOrderSuccessViewController.m
//  Community
//
//  Created by ryder on 7/30/15.
//  Copyright (c) 2015 caijingpeng. All rights reserved.
//
//  功能描述：
//      天天团下单成功页面
//  修改记录：
//      姓名         日期              修改内容
//     程耀均     2015-07-30           创建文件

#import "HWOrderSuccessViewController.h"
#import "HWCommondityListController.h"

@interface HWOrderSuccessViewController ()

@end

@implementation HWOrderSuccessViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    self.orderSurccessView = [[HWOrderSuccessView alloc] init];
    [self.view addSubview:self.orderSurccessView];
    self.orderSurccessView.delegate = self;
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
    [MobClick event:@"click_continue_group"];//1.7
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

- (void)didShowOrderList
{
    [MobClick event:@"click_check_order_group"];//1.7
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    HWTianTianTuanDetailVC *dVC = [[HWTianTianTuanDetailVC alloc] init];
    dVC.orderId = self.orderId;
    dVC.popType = ttTOrderDetailPopTypeOneVC;
    [self.navigationController pushViewController:dVC animated:YES];
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
