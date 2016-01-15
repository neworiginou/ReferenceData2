//
//  HWServiceListViewController.m
//  Community
//
//  Created by hw500027 on 15/6/15.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWServiceListViewController.h"
#import "HWServiceListView.h"
#import "HWServiceEvaluateVC.h"

@interface HWServiceListViewController () <HWServiceListViewDelegate>
{
    HWServiceListView *_listView;
}
@end

@implementation HWServiceListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.titleView = [Utility navTitleView:@"服务订单"];
    
    _listView = [[HWServiceListView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT)];
    _listView.delegate = self;
    [self.view addSubview:_listView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    if (_listView)
    {
        [_listView reQueryListData];
    }
    
    MLNavigationController *navigation = (MLNavigationController *)self.navigationController;
    navigation.canDragBack = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    MLNavigationController *navigation = (MLNavigationController *)self.navigationController;
    navigation.canDragBack = YES;
}

#pragma mark - HWServiceListViewDelegate
- (void)didSelectListView:(UIViewController *)vc
{
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)pushToEvaluateVC:(NSString *)orderId
{
    HWServiceEvaluateVC *evc = [[HWServiceEvaluateVC alloc] init];
    evc.currentOrderId = orderId;
    evc.pushType = pushEvaluateTypeList;
    [self.navigationController pushViewController:evc animated:YES];
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
