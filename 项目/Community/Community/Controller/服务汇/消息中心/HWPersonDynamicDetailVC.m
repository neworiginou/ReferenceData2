//
//  HWPersonDynamicDetailVC.m
//  Community
//
//  Created by hw500027 on 15/1/9.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：个人动态详情
//  修改记录：
//	姓名      日期         修改内容
//  陆晓波    2015-01-14   代码优化
//  陆晓波    2015-01-15   添加点击cell代理
//  陆晓波    2015-01-16   添加跳转邻里圈动态详情
//  陆晓波    2015-01-19   语音播放按钮修改
//  陆晓波    2015-01-20   播放语音通知修改
//  陆晓波    2015-01-21   播放语音通知修改
//  陆晓波    2015-01-22   viewWillAppear 刷新数据
//  陆晓波    2015-01-23   去除 viewWillAppear 刷新数据

#import "HWPersonDynamicDetailVC.h"
#import "HWAudioPlayCenter.h"
#import "HWPersonDynamicModel.h"
#import "HWPersonDynamicRefreshCell.h"
#import "HWPersonDynamicModel.h"
#import "HWDetailViewController.h"

@interface HWPersonDynamicDetailVC () <HWPersonDynamicRefreshViewDelegate>
{
    HWPersonDynamicRefreshView *dynamicRefreshView;
}

@end

@implementation HWPersonDynamicDetailVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    self.navigationItem.titleView = [Utility navTitleView:_navTitleName];

    dynamicRefreshView = [[HWPersonDynamicRefreshView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT) andDataType:self.dataType];
    dynamicRefreshView.delegate = self;
    
    [self.view addSubview:dynamicRefreshView];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [self addAudioPlayNotification];
}

- (void)viewWillDisappear:(BOOL)animated
{
    if ([[HWAudioPlayCenter shareAudioPlayCenter] isPlaying])
    {
        [[HWAudioPlayCenter shareAudioPlayCenter] stop];
    }
    [self removeAudioPlayNotification];
}

#pragma mark -
#pragma mark Audio Method

- (void)addAudioPlayNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadAudioFinish:) name:HWAudioDownloaderFinishedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadAudioFailed:) name:HWAudioDownloaderFailedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startPlayNotification:) name:HWAudioPlayCenterStartPlayNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pausePlayNotification:) name:HWAudioPlayCenterPausePlayNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopPlayNotification:) name:HWAudioPlayCenterStopPlayNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadingAudio:) name:HWAudioDownloaderDownloadindNotification object:nil];
}

- (void)removeAudioPlayNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:HWAudioDownloaderFinishedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:HWAudioDownloaderFailedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:HWAudioPlayCenterStartPlayNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:HWAudioPlayCenterPausePlayNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:HWAudioPlayCenterStopPlayNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:HWAudioDownloaderDownloadindNotification object:nil];
}

#pragma -
#pragma mark Play Audio

- (void)downloadingAudio:(NSNotification *)notification
{
    [dynamicRefreshView downloadingAudio:notification];
}

- (void)downloadAudioFinish:(NSNotification *)notificaiton
{
    [dynamicRefreshView downloadAudioFinish:notificaiton];
}

- (void)downloadAudioFailed:(NSNotification *)notificaiton
{
    [dynamicRefreshView downloadAudioFailed:notificaiton];
}

- (void)startPlayNotification:(NSNotification *)notificaiton
{
    [dynamicRefreshView startPlayNotification:notificaiton];
}

- (void)pausePlayNotification:(NSNotification *)notificaiton
{
    [dynamicRefreshView pausePlayNotification:notificaiton];
}

- (void)stopPlayNotification:(NSNotification *)notificaiton
{
    [dynamicRefreshView stopPlayNotification:notificaiton];
}

/**
 *	@brief	点击个人动态详情回调方法
 *
 *	@param 	model   数据模型
 *
 *	@return	N/A
 */
-(void)didSelectPersonDynamicRefreshView:(HWPersonDynamicModel *)model

{
    //手动改变未读状态
    model.isRead = @"1";
    [dynamicRefreshView.baseTable reloadData];
    
    NSLog(@"topicId==%@",model.topicId);
    
    HWDetailViewController *detailViewController = [[HWDetailViewController alloc]initWithCardId:model.topicId];
    [self.navigationController pushViewController:detailViewController animated:YES];
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
