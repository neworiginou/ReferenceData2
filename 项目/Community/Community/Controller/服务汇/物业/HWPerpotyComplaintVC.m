//
//  HWPerpotyComplaintVC.m
//  Community
//
//  Created by niedi on 15/6/15.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWPerpotyComplaintVC.h"
#import "HWPerpotyComplaintView.h"
#import "HWStartRepairComplaintVC.h"

@interface HWPerpotyComplaintVC ()<HWStartRepairComplaintVCDelegate>
{
    HWPerpotyComplaintView *_mainView;
    BOOL _isNeedRefresh;
}
@end

@implementation HWPerpotyComplaintVC

- (void)viewWillAppear:(BOOL)animated
{
    if (_mainView && _isNeedRefresh == YES)
    {
        _isNeedRefresh = NO;
        [_mainView reQueryListData];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.titleView = [Utility navTitleView:@"投诉"];
    
    _isNeedRefresh = NO;
    
    _mainView = [[HWPerpotyComplaintView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT - 45.0f)];
    [self.view addSubview:_mainView];
    
    [self loadUI];
}

- (void)loadUI
{
    DButton *commitRepairBtn = [DButton btnTxt:@"发起投诉" txtFont:TF18 frameX:0 y:CONTENT_HEIGHT - 45.0f w:kScreenWidth h:45.0f target:self action:@selector(startComplaintBtnClick)];
    [commitRepairBtn setStyle:DBtnStyleMain];
    [self.view addSubview:commitRepairBtn];
}

//发起报修
- (void)startComplaintBtnClick
{
    if ([HWUserLogin verifyIsAuthenticationWithPopVC:self showAlert:YES])
    {
        HWStartRepairComplaintVC *sVC = [[HWStartRepairComplaintVC alloc] init];
        sVC.type = StartComplaint;
        sVC.delegate = self;
        [self pushViewController:sVC];
    }
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
