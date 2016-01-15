//
//  HWCommondityListController.m
//  Community
//
//  Created by ryder on 7/30/15.
//  Copyright (c) 2015 caijingpeng. All rights reserved.
//
//  功能描述：
//      天天团商品列表页面
//  修改记录：
//      姓名         日期              修改内容
//     程耀均     2015-07-30           创建文件

#import "HWCommondityListController.h"
#import "HWCommodityListView.h"
#import "HWCommondityDetailViewController.h"

@interface HWCommondityListController ()<HWCommodityDelegate>
{
    HWCommodityListView *_commondityListView;
    BOOL isFirst;
}

@end

@implementation HWCommondityListController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        self.popType = -1;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    if (self.popType == listVCPopVCTypeOneVC)
    {
        MLNavigationController *navigation = (MLNavigationController *)self.navigationController;
        navigation.canDragBack = NO;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (self.popType == listVCPopVCTypeOneVC)
    {
        MLNavigationController *navigation = (MLNavigationController *)self.navigationController;
        navigation.canDragBack = YES;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    if (_commondityListView)
    {
        if (isFirst)
        {
            [_commondityListView queryListData];
        }
        isFirst = YES;
    }
}

- (void)backMethod
{
    if (self.popType == listVCPopVCTypeOneVC)
    {
        NSArray *vcArr = self.navigationController.viewControllers;
        UIViewController *lastScdVC = [vcArr pObjectAtIndex:vcArr.count - 3];
        [self.navigationController popToViewController:lastScdVC animated:YES];
    }
    else
    {
        [super backMethod];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.titleView = [Utility navTitleView:@"原产递团购"];
    
    _commondityListView = [[HWCommodityListView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT)];
    _commondityListView.delegate = self;
    [self.view addSubview:_commondityListView];
}

- (void)didShowCommondityDetailWithModel:(HWCommondityModel *)model
{
    [MobClick event:@"click_group_goods"];//1.7
    
    HWCommondityDetailViewController *controller = [[HWCommondityDetailViewController alloc] init];
    controller.model = model;
    [self.navigationController pushViewController:controller animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
