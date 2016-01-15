//
//  HWGameSpreadRecordViewController.m
//  Community
//
//  Created by niedi on 15/1/15.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：推广记录页面
//
//  修改记录：
//      姓名          日期                      修改内容
//      聂迪          2015-1-16                 创建文件
//

#import "HWGameSpreadRecordViewController.h"

@interface HWGameSpreadRecordViewController ()

@end

@implementation HWGameSpreadRecordViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.titleView = [Utility navTitleView:@"推广记录"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    
    _gameSpreadRecordTableView = [[HWGameSpreadRecordTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT)];
    _gameSpreadRecordTableView.delegate = self;
    [self.view addSubview:_gameSpreadRecordTableView];
}

/**
 *	@brief  跳转佣金明细界面
 *
 *	@return
 */
- (void)pushToGameDetailViewController:(HWGameSpreadRecordModel *)model
{
    HWGameDetailViewController *gameDetailVC = [[HWGameDetailViewController alloc] init];
    gameDetailVC.gameId = model.gameId;
    gameDetailVC.gameName = model.gameName;
    [gameDetailVC switchToCommissionDetail];
    [self.navigationController pushViewController:gameDetailVC animated:YES];
}

/**
 *	@brief	跳转佣金说明界面
 *
 *	@return
 */
- (void)pushToYongJinDescriptionViewController
{
    [MobClick event:@"click_spreadintroduction"]; //maidian_1.2.1
    
    HWYongJinDescriptionViewController * yjVC = [[HWYongJinDescriptionViewController alloc] init];
    [self.navigationController pushViewController:yjVC animated:YES];
}

/**
 *	@brief	推广记录为空时 点击去推广按钮 pop VC
 *
 *	@return
 */
- (void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
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
