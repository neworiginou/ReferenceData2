//
//  HWCommitHomeServiceVC.m
//  Community
//
//  Created by niedi on 15/6/15.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWCommitHomeServiceVC.h"
#import "HWCommitHomeServiceView.h"
#import "HWStartRepairComplaintVC.h"

@interface HWCommitHomeServiceVC ()<HWCommitHomeServiceViewDelegate, HWStartRepairComplaintVCDelegate>
{
    BOOL _isGuest;
    HWCommitHomeServiceView *_mainView;
}
@end

@implementation HWCommitHomeServiceVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.titleView = [Utility navTitleView:@"提交订单"];
    
    _isGuest = [Utility isGuestLogin];
    
    _mainView = [[HWCommitHomeServiceView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT) serviceId:self.serviceId];
    _mainView.delegate = self;
    [self.view addSubview:_mainView];
    
}

- (void)pushViewController:(UIViewController *)vc
{
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - HWCommitHomeServiceViewDelegate
- (void)cellClickForAddLeaveMessage:(NSString *)beiZhuStr mongokeyArr:(NSArray *)mogokeyArr
{
    HWStartRepairComplaintVC *svc = [[HWStartRepairComplaintVC alloc] init];
    svc.type = AddRemark;
    svc.beiZhuStr = beiZhuStr;
    svc.beizhuImgArr = mogokeyArr;
    svc.delegate = self;
    [self pushViewController:svc];
}

- (void)pushVC:(UIViewController *)vc
{
    [self pushViewController:vc];
}

- (void)popVCAction
{
    NSArray *vcArr = self.navigationController.viewControllers;
    UIViewController *lastScdVC = [vcArr pObjectAtIndex:vcArr.count - 3];
    [self.navigationController popToViewController:lastScdVC animated:YES];
}

#pragma mark - HWStartRepairComplaintVCDelegate
- (void)didLeaveMessage:(NSString *)leaveMessage imgStr:(NSString *)imgStr mongokeyArr:(NSArray *)mongkeyArr
{
    [_mainView setLeaveMessage:leaveMessage imgStr:imgStr mongokeyArr:mongkeyArr];
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
