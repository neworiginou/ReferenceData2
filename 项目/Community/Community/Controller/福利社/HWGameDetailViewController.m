//
//  HWGameDetailViewController.m
//  Community
//
//  Created by niedi on 15/1/20.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：游戏详情页面
//
//  修改记录：
//      姓名          日期                      修改内容
//      聂迪          2015-1-20                 创建文件
//

#import "HWGameDetailViewController.h"

@interface HWGameDetailViewController ()

@end

@implementation HWGameDetailViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        _isSwitchToCommissionDetail = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.titleView = [Utility navTitleView:self.gameName];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    
    HWGameDetailView *gameDetailView = [[HWGameDetailView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT) andGameId:self.gameId];
    gameDetailView.delegate = self;
    [self.view addSubview:gameDetailView];
    
    if (_isSwitchToCommissionDetail)
    {
        [gameDetailView segmentControl:nil didSelectSegmentIndex:1];
        gameDetailView.segmentControl.selectedIndex = 1;
    }
}

- (void)switchToCommissionDetail
{
    _isSwitchToCommissionDetail = YES;
}

#pragma mark - HWGameDetailViewDelegate

- (void)setNavTitleView:(NSString *)titleStr
{
    self.navigationItem.titleView = [Utility navTitleView:titleStr];
}

- (void)pushToShareVC:(HWGameDetailModel *)model
{
    if ([HWUserLogin verifyBindMobileWithPopVC:self showAlert:YES])
    {
        HWGamesDetailShareViewController *gdsVC = [[HWGamesDetailShareViewController alloc]init];
        gdsVC.gameId = model.gameInfoModel.gameId;
        gdsVC.gameName = model.gameInfoModel.gameName;
        gdsVC.appkey = model.gameInfoModel.appNumber;
        gdsVC.code = model.gameInfoModel.channelNumber;
        
        __weak HWGamesDetailShareViewController *weakDetailVC = gdsVC;
        [gdsVC.gameImgV setImageWithURL:[NSURL URLWithString:[Utility imageDownloadWithMongoDbKey:model.gameInfoModel.iconMongodbKey]] placeholderImage:[UIImage imageNamed:IMAGE_PLACE] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType)
         {
             if (error != nil)
             {
                 weakDetailVC.gameImgV.image = [UIImage imageNamed:IMAGE_BREAK_CUBE];
             }
             else
             {
                 weakDetailVC.gameImgV.image = image;
             }
         }];
        if ([HWUserLogin verifyIsLoginWithPresentVC:self toViewController:gdsVC])
        {
            [self.navigationController pushViewController:gdsVC animated:YES];
        }
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
