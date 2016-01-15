//
//  HWWuYeServiceVC.m
//  Community
//
//  Created by niedi on 15/6/11.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWWuYeServiceVC.h"
#import "HWWuYeServiceView.h"
#import "HWWuYePublishNoticeVC.h"

@interface HWWuYeServiceVC ()<HWWuYeServiceViewDelegate>
{
    HWWuYeServiceView *_mainView;
    
    BOOL isNeedRefresh;
}
@end

@implementation HWWuYeServiceVC

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    MLNavigationController *navigation = (MLNavigationController *)self.navigationController;
    navigation.canDragBack = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    MLNavigationController *navigation = (MLNavigationController *)self.navigationController;
    navigation.canDragBack = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    if (_mainView && isNeedRefresh)
    {
        isNeedRefresh = NO;
        [_mainView queryListData];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.titleView = [Utility navTitleView:@"物业服务"];
    
    isNeedRefresh = NO;
    
    _mainView = [[HWWuYeServiceView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT) isCompany:self.isCompany];
    _mainView.homePageIconArr = self.homePageIconArr;
    _mainView.delegate = self;
    _mainView.fatherVC = self;
    [self.view addSubview:_mainView];
    
}

- (void)pushViewController:(UIViewController *)VC
{
    if ([VC isMemberOfClass:[HWWuYePublishNoticeVC class]])
    {
        isNeedRefresh = YES;
    }
    
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
