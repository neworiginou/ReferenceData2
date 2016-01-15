//
//  HWAddHouseVC.m
//  Community
//
//  Created by niedi on 15/6/12.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWAddHouseVC.h"
#import "HWWuYeAddHouseView.h"
#import "HWAddHouse1VC.h"

@interface HWAddHouseVC ()<HWWuYeAddHouseViewDelegate>
{
    HWWuYeAddHouseView *_mainView;
}
@end

@implementation HWAddHouseVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.titleView = [Utility navTitleView:@"请选择"];
    
    _mainView = [[HWWuYeAddHouseView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT)];
    _mainView.delegate = self;
    [self.view addSubview:_mainView];
}

- (void)pushViewController:(UIViewController *)VC
{
    [self.navigationController pushViewController:VC animated:YES];
}


#pragma mark - HWWuYeAddHouseViewDelegate
- (void)didClickCellWithModel:(HWWuYeAddHouseModel *)model
{
    HWAddHouse1VC *avc = [[HWAddHouse1VC alloc] init];
    avc.model = model;
    [self pushViewController:avc];
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
