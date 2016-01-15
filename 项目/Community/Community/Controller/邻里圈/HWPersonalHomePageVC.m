//
//  HWPersonalHomePageVC.m
//  Community
//
//  Created by niedi on 15/4/13.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：邻里圈 个人主页ViewController
//
//  修改记录：
//      姓名          日期                      修改内容
//      聂迪        2015-04-15                 创建文件
//


#import "HWPersonalHomePageVC.h"
#import "HWPersonalHomePageDetailVC.h"

@interface HWPersonalHomePageVC ()

@end

@implementation HWPersonalHomePageVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.titleView = [Utility navTitleView:@"个人主页"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    
    _personView = [[HWPersonalHomePageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT) userId:self.userId];
    _personView.delegate = self;
    [self.view addSubview:_personView];
    
}


- (void)personalHomePageClickIndex:(NSInteger)index
{
    HWPersonalHomePageDetailVC *detailVC = [[HWPersonalHomePageDetailVC alloc] init];
    detailVC.userId = self.userId;
    detailVC.selectedIndex = (int)index;
    detailVC.personalVC = self;
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)personalHomePageVcChangeTitle:(NSString *)title
{
    self.navigationItem.titleView = [Utility navTitleView:title];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
