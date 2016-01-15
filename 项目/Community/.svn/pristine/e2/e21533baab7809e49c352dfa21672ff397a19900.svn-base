//
//  HWGameOneClickSpreadVC.m
//  Community
//
//  Created by WeiYuanlin on 15/1/16.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//  功能描述：全部游戏一键分享页面
//  修改记录
//      李中强 2015-01-17 添加头注释 相关人员补齐注释
//      魏远林 2015-01-16 创建文件
//

#import "HWGameOneClickSpreadVC.h"

@interface HWGameOneClickSpreadVC ()

@end

@implementation HWGameOneClickSpreadVC
@synthesize title;
- (id)init
{
    self = [super init];
    if (self)
    {
        self.gameName = [NSString string];
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.titleView = [Utility navTitleView:self.gameName];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    self.view.backgroundColor = THEME_COLOR_TEXTBACKGROUND;

    //游戏名tableview
    HWGameNameTableView *gameNameTV = [[HWGameNameTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT)];
    gameNameTV.delegate = self;
    gameNameTV.presentController = self;
    gameNameTV.backgroundColor = [UIColor clearColor];
    [self.view addSubview:gameNameTV];
    
}

#pragma mark - HWGameNameTableView Delegate
- (void)didSelectedCell:(HWGameAllNameModel *)model
{
    //跳转到游戏详情
    HWGameDetailViewController * vc = [[HWGameDetailViewController alloc] init];
    vc.gameId = model.gameId;
    vc.gameName = model.gameName;
    [self.navigationController pushViewController:vc animated:YES];
    
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
