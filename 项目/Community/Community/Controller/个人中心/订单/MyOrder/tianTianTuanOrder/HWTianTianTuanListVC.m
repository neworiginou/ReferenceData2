//
//  HWTianTianTuanListVC.m
//  Community
//
//  Created by niedi on 15/7/31.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWTianTianTuanListVC.h"
#import "HWTianTianTuanListView.h"
#import "HWTianTianTuanDetailVC.h"
#import "HWConfirmPayViewController.h"

@interface HWTianTianTuanListVC ()<HWTianTianTuanListViewDelegate, HWTianTianTuanDetailVCDelegate>
{
    HWTianTianTuanListView *_mainView;
    BOOL isNeedRefresh;
}
@end

@implementation HWTianTianTuanListVC

- (void)viewDidAppear:(BOOL)animated
{
    if (isNeedRefresh)
    {
        isNeedRefresh = NO;
        
        if (_mainView)
        {
            [_mainView requeryData];
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.titleView = [Utility navTitleView:@"原产递团购订单"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isNeedRefresh) name:@"tiantianTuanRefreshList" object:nil];
    
    _mainView = [[HWTianTianTuanListView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT)];
    _mainView.delegate = self;
    [self.view addSubview:_mainView];
}

- (void)isNeedRefresh
{
    isNeedRefresh = YES;
}


#pragma mark - HWTianTianTuanListViewDelegate
- (void)pushToOrderDetail:(NSString *)orderId
{
    HWTianTianTuanDetailVC *dVC = [[HWTianTianTuanDetailVC alloc] init];
    dVC.orderId = orderId;
    dVC.delegate = self;
    [self.navigationController pushViewController:dVC animated:YES];
}

- (void)pushToPayConfirmVC:(NSString *)orderId
{
    HWConfirmPayViewController *controller = [[HWConfirmPayViewController alloc] init];
    controller.orderId = orderId;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - HWTianTianTuanDetailVCDelegate
- (void)cancleOrderReQueryList
{
    [_mainView requeryData];
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
