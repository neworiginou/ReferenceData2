//
//  HWPublicRepairVC.m
//  Community
//
//  Created by niedi on 15/6/14.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWPublicRepairVC.h"
#import "HWPublicRepairView.h"
#import "HWPublicRepairTotalVC.h"
#import "HWStartRepairComplaintVC.h"

@interface HWPublicRepairVC ()<HWStartRepairComplaintVCDelegate>
{
    HWPublicRepairView *_mainView;
    BOOL _isNeedRefresh;
}
@end

@implementation HWPublicRepairVC

- (void)viewWillAppear:(BOOL)animated
{
    if (_mainView != nil && _isNeedRefresh == YES)
    {
        _isNeedRefresh = NO;
        [_mainView reQueryListData];
    }
}

- (UIBarButtonItem *)rightBarButtonItem
{
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 60.0f, 44.0f);
    [rightButton setTitleColor:THEME_COLOR_ORANGE forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
    [rightButton setTitle:@"全部报修" forState:UIControlStateNormal];
    rightButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -5);
    [rightButton addTarget:self action:@selector(publicRepairTotalBtnClick) forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.titleView = [Utility navTitleView:@"我的报修"];
    self.navigationItem.rightBarButtonItem = [self rightBarButtonItem];
    
    _isNeedRefresh = NO;
    
    _mainView = [[HWPublicRepairView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT - 45.0f)];
    [self.view addSubview:_mainView];
    
    [self loadUI];
}

- (void)loadUI
{
    DButton *commitRepairBtn = [DButton btnTxt:@"发起报修" txtFont:TF18 frameX:0 y:CONTENT_HEIGHT - 45.0f w:kScreenWidth h:45.0f target:self action:@selector(startRepairBtnClick)];
    [commitRepairBtn setStyle:DBtnStyleMain];
    [self.view addSubview:commitRepairBtn];
}

//发起报修
- (void)startRepairBtnClick
{
    if ([HWUserLogin verifyIsAuthenticationWithPopVC:self showAlert:YES])
    {
        HWStartRepairComplaintVC *sVC = [[HWStartRepairComplaintVC alloc] init];
        sVC.type = StartRepair;
        sVC.delegate = self;
        [self pushViewController:sVC];
    }
}

//全部报修
- (void)publicRepairTotalBtnClick
{
    HWPublicRepairTotalVC *totalVC = [[HWPublicRepairTotalVC alloc] init];
    [self pushViewController:totalVC];
}

- (void)pushViewController:(UIViewController *)vc
{
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - HWStartRepairComplaintVCDelegate
- (void)setRefreshVC
{
    _isNeedRefresh = YES;
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
