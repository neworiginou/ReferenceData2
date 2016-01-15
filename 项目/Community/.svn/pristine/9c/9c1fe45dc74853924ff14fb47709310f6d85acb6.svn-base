//
//  HWGoodsListViewController.m
//  Community
//
//  Created by lizhongqiang on 15/4/13.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWGoodsListViewController.h"
#import "HWGoodsListView.h"
#import "HWGoodsListCell.h"
#import "HWHistoryViewController.h"

@interface HWGoodsListViewController ()<HWGoodsListViewDelegate>
{
    NSString *_wuDiXianChannelId;
}
@end

@implementation HWGoodsListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    self.navigationItem.titleView = [Utility navTitleView:@"无底线"];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self title:@"历史" action:@selector(historyRecord)];
    
    [self.view setBackgroundColor:[UIColor clearColor]];
    HWGoodsListView *goods = [[HWGoodsListView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT)];
    goods.delegate = self;
    [self.view addSubview:goods];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)historyRecord
{
    HWHistoryViewController *historyVC = [[HWHistoryViewController alloc] init];
    historyVC.popToViewController = self;
    historyVC.wuDiXianChannelId = _wuDiXianChannelId;
    [self.navigationController pushViewController:historyVC animated:YES];
}

#pragma - goodsListView delegate
- (void)cellSelectPushVC:(UIViewController *)vc
{
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)setWuDiXianChannelId:(NSString *)wuDiXianChannelId
{
    _wuDiXianChannelId = wuDiXianChannelId;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
