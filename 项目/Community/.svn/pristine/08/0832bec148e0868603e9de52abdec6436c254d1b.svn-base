//
//  HWMyOrderViewController.m
//  Community
//
//  Created by D on 14/12/9.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWMyOrderViewController.h"
#import "HWMyOrderView.h"
#import "HWMyBargainOrderViewController.h"
#import "HWServiceListViewController.h"
#import "HWTianTianTuanListVC.h"

@interface HWMyOrderViewController ()<HWMyOrderViewDelegate>
{
    
}
@end

@implementation HWMyOrderViewController

- (void)viewDidLoad {
    self.view.backgroundColor = UIColorFromRGB(0xf2f2f2);
    self.navigationItem.titleView = [Utility navTitleView:@"我的订单"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    
    HWMyOrderView *mainView = [[HWMyOrderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT)];
    mainView.delegate = self;
    [self.view addSubview:mainView];
}

#pragma mark - HWMyOrderViewDelegate
- (void)didClickedWithRow:(NSInteger)row
{
    if (row == 0)
    {
        HWTianTianTuanListVC *ttTuanVC = [[HWTianTianTuanListVC alloc] init];
        [self.navigationController pushViewController:ttTuanVC animated:YES];
    }
    else if (row == 1)
    {
        HWServiceListViewController *serviceListVC = [[HWServiceListViewController alloc] init];
        [self.navigationController pushViewController:serviceListVC animated:YES];
    }
    else if (row == 2)
    {
        [MobClick event:@"click_wodekanjiadingdan"];
        if ([HWUserLogin verifyBindMobileWithPopVC:self showAlert:YES])
        {
            HWMyBargainOrderViewController *bargainOrderVC = [[HWMyBargainOrderViewController alloc] init];
            [self.navigationController pushViewController:bargainOrderVC animated:YES];
        }
    }
}

@end
