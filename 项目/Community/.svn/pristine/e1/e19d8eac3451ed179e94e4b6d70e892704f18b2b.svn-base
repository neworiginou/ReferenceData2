//
//  HWMoreRecommendVC.m
//  Community
//
//  Created by niedi on 15/4/13.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：邻里圈 推荐-更多ViewController
//
//  修改记录：
//      姓名          日期                      修改内容
//      聂迪        2015-04-15                 创建文件
//


#import "HWMoreRecommendVC.h"
#import "HWTopicListViewController.h"
#import "HWPublishViewController.h"

@interface HWMoreRecommendVC ()

@end

@implementation HWMoreRecommendVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.titleView = [Utility navTitleView:@"更多推荐"];
    self.navigationItem.rightBarButtonItem = [Utility navPublishButton:self action:@selector(addTopicClick)];
    
    _moreRecommendView = [[HWChannelTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT ) WithIsMoreRecommendWithPastRecord:YES personalUserId:nil];
    _moreRecommendView.delegate = self;
    [self.view addSubview:_moreRecommendView];
    
    HWSearchListTableView *searchListTableView = [_moreRecommendView valueForKeyPath:@"searchView.searchListTableView"];
    searchListTableView.delegate = self;
}

- (void)addTopicClick
{
    if ([[HWUserLogin currentUserLogin].coStatus isEqualToString:@"0"])
    {
        if ([HWUserLogin verifyBindMobileWithPopVC:self showAlert:YES])
        {
            HWPublishViewController *publishVC = [[HWPublishViewController alloc] init];
            publishVC.publishRoute = NeighbourRoute;
            publishVC.isNeedAudio = NO;
            publishVC.isWriteAndPic = YES;
            if ([HWUserLogin verifyIsLoginWithPresentVC:self toViewController:nil])
            {
                if ([HWUserLogin verifyIsAuthenticationWithPopVC:self showAlert:YES])
                {
                    [self.navigationController pushViewController:publishVC animated:YES];
                }
            }
        }
    }
    else
    {
        if ([HWUserLogin verifyBindMobileWithPopVC:self showAlert:YES])
        {
            HWPublishViewController *publishVC = [[HWPublishViewController alloc] init];
            publishVC.publishRoute = NeighbourRoute;
            publishVC.isNeedAudio = NO;
            publishVC.isWriteAndPic = YES;
            if ([HWUserLogin verifyIsLoginWithPresentVC:self toViewController:publishVC])
            {
                [self.navigationController pushViewController:publishVC animated:YES];
            }
        }
    }
}

#pragma mark -
#pragma mark - HWChannelTableViewDelegate
- (void)channelTableView:(HWChannelTableView *)chanelTableView pushCtroller:(HWChannelModel *)model
{
    HWTopicListViewController *vc = [[HWTopicListViewController alloc]init];
    vc.channelModel = model;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)searchListTableView:(HWSearchListTableView *)searchListTableView pushCtroller:(HWChannelModel *)model
{
    HWTopicListViewController *vc = [[HWTopicListViewController alloc]init];
    vc.channelModel = model;
    vc.isSearchBarPush = YES;
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}



@end
