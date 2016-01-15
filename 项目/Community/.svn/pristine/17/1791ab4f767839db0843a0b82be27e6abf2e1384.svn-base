//
//  HWWuYePayRecordVC.m
//  Community
//
//  Created by niedi on 15/6/12.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWWuYePayRecordVC.h"
#import "HWWuYePayRecordView.h"
#import "HWWuYePayRecordDetailVC.h"

@interface HWWuYePayRecordVC ()<HWWuYePayRecordViewDelegate>
{
    HWWuYePayRecordView *_mainView;
}
@end

@implementation HWWuYePayRecordVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.titleView = [Utility navTitleView:@"记录"];
    
    _mainView = [[HWWuYePayRecordView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT)];
    _mainView.delegate = self;
    [self.view addSubview:_mainView];
    
}

- (void)pushViewController:(UIViewController *)VC
{
    [self.navigationController pushViewController:VC animated:YES];
}


#pragma mark - HWWuYePayRecordViewDelegate
- (void)pushToDetailVCWithModel:(HWWuYePayRecordModel *)model
{
    HWWuYePayRecordDetailVC *vc = [[HWWuYePayRecordDetailVC alloc] init];
    vc.model = model;
    [self pushViewController:vc];
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
