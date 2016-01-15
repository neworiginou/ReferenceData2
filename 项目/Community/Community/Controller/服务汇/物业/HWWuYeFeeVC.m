//
//  HWWuYeFeeVC.m
//  Community
//
//  Created by niedi on 15/6/11.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWWuYeFeeVC.h"
#import "HWWuYeFeeView.h"
#import "HWAddHouseVC.h"
#import "HWRCustomSiftView.h"
#import "AppDelegate.h"

@interface HWWuYeFeeVC ()<HWWuYeFeeViewDelegate, HWRCustomSiftViewDelegate>
{
    HWWuYeFeeView *_mainView;
}
@end

@implementation HWWuYeFeeVC

- (void)viewWillAppear:(BOOL)animated
{
    if (_mainView)
    {
        [_mainView queryListData];
    }
    
    MLNavigationController *navigation = (MLNavigationController *)self.navigationController;
    navigation.canDragBack = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    MLNavigationController *navigation = (MLNavigationController *)self.navigationController;
    navigation.canDragBack = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.titleView = [Utility navTitleView:@"物业费"];
    self.navigationItem.rightBarButtonItem = [Utility navWalletButton:self action:@selector(addHouse)];
    
    _mainView = [[HWWuYeFeeView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT)];
    _mainView.delegate = self;
    [self.view addSubview:_mainView];
}

- (void)pushViewController:(UIViewController *)VC
{
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)addHouse
{
    NSArray *titleArr = @[@"添加住房"];
    NSArray *imgArr = @[@"icon_16_03"];
    HWRCustomSiftView *siftV = [[HWRCustomSiftView alloc] initWithTitle:titleArr image:imgArr andDependView:self.navigationItem.rightBarButtonItem.customView];
    siftV.delegate = self;
    AppDelegate *del = (AppDelegate *)SHARED_APP_DELEGATE;
    [siftV showInView:del.window byOffsetY:-3];
}

#pragma mark - HWRCustomSiftViewDelegate
- (void)siftView:(HWRCustomSiftView *)siftView didSelectedIndex:(NSInteger)index
{
    if (index == 0)
    {
        HWAddHouseVC *aVc = [[HWAddHouseVC alloc] init];
        [self pushViewController:aVc];
    }
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
