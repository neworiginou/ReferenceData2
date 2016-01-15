//
//  HWGamesDetailShareViewController.m
//  Community
//
//  Created by WeiYuanlin on 15/1/15.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：个人推广页
//
//  修改记录
//      姓名          日期                      修改内容
//      李中强         2015-01-17              添加头注释 相关人员补齐注释
//      魏远林         2015-01-15              创建文件
//      魏远林         2015-01-19              规范代码

#define ShareContent @"这个游戏真好玩，一起来战吧"

#import "HWGamesDetailShareViewController.h"

@interface HWGamesDetailShareViewController ()
{
    UIScrollView *myScrollView;
}
@end

@implementation HWGamesDetailShareViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        self.gameId = [NSString string];
        self.appkey = [NSString string];
        self.code = [NSString string];
        self.gameImgV = [[UIImageView alloc] init];
        self.gameName = [NSString string];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.titleView = [Utility navTitleView:self.gameName];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    
    myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT)];
    myScrollView.backgroundColor = [UIColor clearColor];
    myScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:myScrollView];
    
    HWGameNameView *gameNameView = [[HWGameNameView alloc]initWithGameId:self.gameId appkey:self.appkey code:self.code];
    gameNameView.frame = CGRectMake(0, 0, kScreenWidth, 238.0f);
    gameNameView.gameId = self.gameId;
    gameNameView.appkey = self.appkey;
    gameNameView.code = self.code;
    gameNameView.backgroundColor = [UIColor clearColor];
    gameNameView.delegate = self;
    [myScrollView addSubview:gameNameView];
    
    
}

/**
 *	@brief	一键推广、个人专属游戏推广页
 *
 *	@return	N/A
 */
- (void)singleClickSpread
{
    [MobClick event:@"click_personalgamelist"]; //maidian_1.2.1
    HWGameOneClickSpreadVC *goc = [[HWGameOneClickSpreadVC alloc]init];
    goc.gameName = self.gameName;
    [self.navigationController pushViewController:goc animated:YES];
}

#pragma mark - HWGameNameView Delegate
- (void)getModelValue:(HWGameNameModel *)model
{
//    if ([self.gameImgV.image isEqual:[UIImage imageNamed:IMAGE_BREAK_CUBE]] ||
//        [self.gameImgV.image isEqual:[UIImage imageNamed:IMAGE_PLACE]])
//    {
//        self.gameImgV.image = [UIImage imageNamed:@"Icon"];
//    }
    //拼接分享地址
    /*
     http://172.16.10.35/kaola/game_detail?popularizeUserId=77&gameId=2
     */
    NSString *shareStr = [NSString stringWithFormat:@"%@?popularizeUserId=%@&gameId=%@",model.gameShareUrl,[HWUserLogin currentUserLogin].userId,model.gameId];
    HWShareView *shareView = [[HWShareView alloc]initWithShareTitile:self.gameName content:ShareContent image:self.gameImgV.image shareUrl:shareStr];
    shareView.shareSource = 1;
    shareView.frame = CGRectMake(0, 238.0f, kScreenWidth, 430 / 2.0f);
    shareView.superView = self.view;
    shareView.backgroundColor = [UIColor clearColor];
    shareView.gameId = self.gameId;
    shareView.copiesUrl = shareStr;
    [shareView showInView:self.view presentController:self];
    [myScrollView addSubview:shareView];
    
    UILabel *infoLabel = [[UILabel alloc]init];
    infoLabel.text = @"专属推广页：一键推广所有游戏";
    infoLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALLTITLE];
    infoLabel.textColor = THEME_COLOR_TEXT;
    infoLabel.textAlignment = NSTextAlignmentCenter;
    infoLabel.backgroundColor = [UIColor clearColor];
    [infoLabel sizeToFit];
    infoLabel.frame = CGRectMake(0, 0, infoLabel.frame.size.width, infoLabel.frame.size.height);
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 17.0f - 0.5f,infoLabel.frame.size.width , 0.5f )];
    line.backgroundColor = THEME_COLOR_TEXT;
    [infoLabel addSubview:line];
    
    UIButton *singleCLickSpreadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    singleCLickSpreadBtn.backgroundColor = [UIColor clearColor];
    singleCLickSpreadBtn.frame = CGRectMake((kScreenWidth - infoLabel.frame.size.width)/2, CGRectGetMaxY(shareView.frame) + 20.0f, infoLabel.frame.size.width, infoLabel.frame.size.height + 1.0f);
    [singleCLickSpreadBtn addTarget:self action:@selector(singleClickSpread) forControlEvents:UIControlEventTouchUpInside];
    [myScrollView addSubview:singleCLickSpreadBtn];
    [singleCLickSpreadBtn addSubview:infoLabel];
    
    myScrollView.contentSize = CGSizeMake(kScreenWidth,CGRectGetMaxY(singleCLickSpreadBtn.frame) + 20.0f);
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
