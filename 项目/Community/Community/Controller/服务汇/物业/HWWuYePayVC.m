//
//  HWWuYePayVC.m
//  Community
//
//  Created by niedi on 15/6/11.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWWuYePayVC.h"
#import "HWWuYePayView.h"
#import "HWWuYePayRecordVC.h"

@interface HWWuYePayVC ()<HWWuYePayViewDelegate>
{
    HWWuYePayView *_mainView;
}
@end

@implementation HWWuYePayVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.titleView = [Utility navTitleView:@"物业缴费"];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self title:@"记录" action:@selector(chechRecords)];
    
    _mainView = [[HWWuYePayView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT)];
    _mainView.delegate = self;
    _mainView.fatherVC = self;
    [self.view addSubview:_mainView];
    
}

- (void)chechRecords
{
    if ([HWUserLogin verifyBindMobileWithPopVC:self showAlert:YES])
    {
        HWWuYePayRecordVC *recordVC = [[HWWuYePayRecordVC alloc] init];
        if ([HWUserLogin verifyIsLoginWithPresentVC:self toViewController:recordVC])
        {
            [self pushViewController:recordVC];
        }
    }
}


- (void)pushViewController:(UIViewController *)VC
{
    [self.navigationController pushViewController:VC animated:YES];
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
