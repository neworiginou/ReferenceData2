//
//  HWHomeServiceVC.m
//  Community
//
//  Created by niedi on 15/6/15.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWHomeServiceVC.h"
#import "HWHomeServiceView.h"
#import "HWCommitHomeServiceVC.h"

@interface HWHomeServiceVC ()<HWHomeServiceViewDelegate>
{
    HWHomeServiceView *_mainView;
}
@end

@implementation HWHomeServiceVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.titleView = [Utility navTitleView:self.navTitleStr];
    
    _mainView = [[HWHomeServiceView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT) serviceId:self.serviceId];
    _mainView.delegate = self;
    [self.view addSubview:_mainView];
    
}

- (void)pushViewController:(UIViewController *)vc
{
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - HWHomeServiceViewDelegate
- (void)bookingOrderBtnClick
{
    HWCommitHomeServiceVC *cVc = [[HWCommitHomeServiceVC alloc] init];
    cVc.serviceId = self.serviceId;
    [self pushViewController:cVc];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
