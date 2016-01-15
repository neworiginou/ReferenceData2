//
//  HWPersonalHomePageDetailVC.m
//  Community
//
//  Created by niedi on 15/4/15.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：邻里圈 个人主页 个人话题 主题ViewController
//
//  修改记录：
//      姓名          日期                      修改内容
//      聂迪        2015-04-15                 创建文件
//


#import "HWPersonalHomePageDetailVC.h"
#import "HWDetailViewController.h"

@interface HWPersonalHomePageDetailVC ()<HWDetailViewControllerDelete>

@end

@implementation HWPersonalHomePageDetailVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _TaTitleArr = @[@"Ta的主题", @"Ta的话题"];
    _WoTitleArr = @[@"Wo的主题", @"Wo的话题"];
    
    NSArray *titleArr;
    if ([self.userId isEqualToString:[HWUserLogin currentUserLogin].userId])
    {
        titleArr = _WoTitleArr;
    }
    else
    {
        titleArr = _TaTitleArr;
    }
    
    HWCustomSegmentControl *segmentControl = [[HWCustomSegmentControl alloc]initWithTitles:titleArr fram: CGRectMake(0, 0, kScreenWidth - 150, 30)];
    segmentControl.selectedIndex = self.selectedIndex;
    segmentControl.delegate = self;
    self.navigationItem.titleView = segmentControl;
    
    _themeView = [[HWChannelView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT)];
    _themeView.userId = self.userId;
    _themeView.delegate = self;
    _themeView.personalVC = self.personalVC;
    _themeView.superVC = self;
    [_themeView queryListData];
    [self.view addSubview:_themeView];
    
    
    _topicView = [[HWChannelTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT)WithIsMoreRecommendWithPastRecord:NO personalUserId:self.userId];
    _topicView.delegate = self;
    [self.view addSubview:_topicView];
    
    if (self.selectedIndex == 0)
    {
        _topicView.hidden = YES;
    }
    else
    {
        _themeView.hidden = YES;
    }
}

- (void)segmentControl:(HWCustomSegmentControl *)sControl didSelectSegmentIndex:(int)index
{
    if (index == 0)
    {
        _topicView.hidden = YES;
        _themeView.hidden = NO;
    }
    else
    {
        _topicView.hidden = NO;
        _themeView.hidden = YES;
    }
}


#pragma mark -
#pragma mark - HWChannelViewDelegate
- (void)pushController:(id)controller
{
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didAddChannel
{
    HWAddChannelViewController *addVC = [[HWAddChannelViewController alloc]init];
    addVC.delegate = self;
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController pushViewController:addVC animated:YES];
}

- (void)pushToDetailViewController:(NSString *)topicId resourceType:(detailResource)type isChuanChuanMen:(BOOL)isChuan personalVC:(UIViewController *)personalVC channelId:(NSString *)channelId
{
    HWDetailViewController *detailVC = [[HWDetailViewController alloc]initWithCardId:topicId];
    detailVC.resourceType = type;
    detailVC.channelId = channelId;
    detailVC.chuanChuanMenCanNotHandle = isChuan;
    detailVC.delegate = self;
    detailVC.personalVC = personalVC;
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - 
#pragma mark - HWDetailViewControllerDelete
- (void)changeLike:(NSDictionary *)dict
{
    [_themeView changeLike:[dict stringObjectForKey:@"likeCount"] isPrise:[dict stringObjectForKey:@"isPraise"]];
}

- (void)changeComment:(NSDictionary *)dict
{
    [_themeView changeComment:[dict stringObjectForKey:@"commentCount"]];
}

#pragma mark -
#pragma mark - HWAddChannelViewControllerDelegate
- (void)didSelectChannel:(HWChannelModel *)model
{
    [_themeView selectChannel:model];
}

#pragma mark 
#pragma mark - HWChannelTableViewDelegate
- (void)channelTableView:(HWChannelTableView *)chanelTableView pushCtroller:(HWChannelModel *)model
{
    HWTopicListViewController *vc = [[HWTopicListViewController alloc]init];
    vc.channelModel = model;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
