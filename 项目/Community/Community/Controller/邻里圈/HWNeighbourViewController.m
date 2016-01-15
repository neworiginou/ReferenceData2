//
//  HWNeighbourViewController.m
//  Community
//
//  Created by niedi on 15/4/14.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：邻里圈 首页ViewController
//
//  修改记录：
//      姓名          日期                      修改内容
//      聂迪        2015-04-15                 创建文件
//      陆晓波      2015-04-15                添加新手游客引导页相关initialGuideView initialGuideViewAfterPublish removeGuideView等方法
//      陆晓波      2015-04-27                 添加HWCustomGuideAlertView.h，改变引导页样式
//

#import "HWNeighbourViewController.h"
#import "AppDelegate.h"
#import "HWChannelTableView.h"
#import "HWCustomGuideAlertView.h"
#import "HWTreasureRuleViewController.h"
#import "HWGoodsDetailViewController.h"

@interface HWNeighbourViewController ()<hwsearchListTableDelegate>
{
    
}
@end

@implementation HWNeighbourViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshList) name:HWNeighbourDragRefresh object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshList) name:RELOAD_APP_DATA object:nil];
        //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initialGuideViewAfterPublish) name:InitialGuideViewAfterPublish object:nil];
    }
    return self;
}

/**
 *	@brief	刷新数据
 *
 *	@return	N/A
 */
- (void)refreshList
{
    [_recommendView refreshList];
    [_pastRecordView refreshList];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _recommendView = [[HWRecommendView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT - 49)];
    _recommendView.delegate = self;
    [self.view addSubview:_recommendView];
    
    _pastRecordView = [[HWChannelTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT - 49) WithIsMoreRecommendWithPastRecord:NO personalUserId:nil];
    _pastRecordView.delegate = self;
    _pastRecordView.hidden = YES;
    [self.view addSubview:_pastRecordView];
    
    HWSearchListTableView *searchListTableView = [_pastRecordView valueForKeyPath:@"searchView.searchListTableView"];
    searchListTableView.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}


#pragma mark -
#pragma mark - HWCustomSegmentControlDelegate
- (void)segmentControl:(HWCustomSegmentControl *)sControl didSelectSegmentIndex:(int)index
{
    _segmentSelectIndex = index;
    if (index == 0)
    {
        _recommendView.hidden = NO;
        _pastRecordView.hidden = YES;
    }
    else
    {
        _pastRecordView.hidden = NO;
        _recommendView.hidden = YES;
    }
}

#pragma mark - 
#pragma mark - HWRecommendViewDelegate
- (void)pushVC:(HWBaseViewController *)vc
{
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)recommendView:(HWRecommendView *)neighbourView pushVC:(HWChannelModel *)model
{
    HWTopicListViewController *vc = [[HWTopicListViewController alloc]init];
    vc.channelModel = model;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tableViewHeaderPictureClick:(HWNeighbourBannerModel *)model
{
    HWApplicationDetailViewController *appDetailVC = [[HWApplicationDetailViewController  alloc] init];
    appDetailVC.navigationItem.titleView = [Utility navTitleView:model.activityName];
    appDetailVC.appUrl = model.activityURL;
    [self.navigationController pushViewController:appDetailVC animated:YES];
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

- (void)delegatePushVC:(HWBaseViewController *)vc
{
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
