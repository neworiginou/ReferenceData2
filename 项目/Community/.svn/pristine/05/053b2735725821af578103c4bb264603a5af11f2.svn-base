//
//  HWGameSpreadVC.m
//  KaoLa
//
//  Created by WeiYuanlin on 15/1/13.
//  Copyright (c) 2015年 WeiYuanlin. All rights reserved.
//  功能描述：游戏推广首页 页面
//
//  修改记录：
//      姓名          日期                      修改内容
//      魏远林        2015-01-15                创建文件
//      聂迪          2015-1-16                 修改接口
//      魏远林        2015-01-19                 规范代码
//

#import "HWGameSpreadVC.h"

@interface HWGameSpreadVC ()

@end

@implementation HWGameSpreadVC

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.titleView = [Utility navTitleView:@"游戏推广"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    
    HWGameSpreadTableView *gameSpreadView = [[HWGameSpreadTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT)];
    gameSpreadView.delegate = self;
    [self.view addSubview:gameSpreadView];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 60.0f, 44.0f);
    [rightButton setTitleColor:THEME_COLOR_ORANGE forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
    [rightButton setTitle:@"推广记录" forState:UIControlStateNormal];
    rightButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -5);
    [rightButton addTarget:self action:@selector(gameSpreadRecordBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

/**
 *	@brief	跳转推广记录页面
 *
 *	@return	N/A
 */
- (void)gameSpreadRecordBtnClick
{
    [MobClick event:@"click_spreadrecord"]; //maidian_1.2.1
    if ([HWUserLogin verifyBindMobileWithPopVC:self showAlert:YES])
    {
         HWGameSpreadRecordViewController *gameSpreadRecordVC =  [[HWGameSpreadRecordViewController alloc] init];
        
        if ([HWUserLogin verifyIsLoginWithPresentVC:self toViewController:gameSpreadRecordVC])
        {
            [self.navigationController pushViewController:gameSpreadRecordVC animated:YES];
        }
    }
}

#pragma mark -HWGameSpreadTableView Delegate
/**
 *	@brief	跳转分享页面
 *
 *	@param 	model
 *
 *	@return
 */
- (void)spreadBtnClickDelegate:(HWGameSpreadModel *)model
{
    if ([HWUserLogin verifyBindMobileWithPopVC:self showAlert:YES])
    {
        HWGamesDetailShareViewController *gdsVC = [[HWGamesDetailShareViewController alloc]init];
        gdsVC.gameId = model.gameId;
        gdsVC.appkey = model.appNumber;
        gdsVC.code = model.channelNumber;
        gdsVC.gameName = model.gameName;
        
        __weak HWGamesDetailShareViewController *weakDetailVC = gdsVC;
        [gdsVC.gameImgV setImageWithURL:[NSURL URLWithString:[Utility imageDownloadWithMongoDbKey:model.iconMongodbKey]] placeholderImage:[UIImage imageNamed:IMAGE_PLACE] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType)
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

/**
 *	@brief	跳转游戏详情
 *
 *	@param
 *
 *	@return
 */
- (void)cellClickDelegate:(HWGameSpreadModel *)model
{
    HWGameDetailViewController * vc = [[HWGameDetailViewController alloc] init];
    vc.gameName = model.gameName;
    vc.gameId = model.gameId;
    [self.navigationController pushViewController:vc animated:YES];
}

/**
 *	@brief	图片墙图片点击代理
 *
 *	@param 	model 	图片的gameid 和 gamename
 *
 *	@return
 */
- (void)tableHeaderImageClickDelegate:(HWGameSpreadPicModel *)model
{
    HWGameDetailViewController * vc = [[HWGameDetailViewController alloc] init];
    vc.gameId = model.gameId;
    vc.gameName = model.gameName;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)showGuideViewWhenHaveList
{
    HWGuideFactory *guide = [HWGuideFactory shareGuideFactory];
    [guide createGameSpreadGuide];
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
