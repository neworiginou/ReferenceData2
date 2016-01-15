//
//  HWServiceMoreVC.m
//  Community
//
//  Created by niedi on 15/6/25.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWServiceMoreVC.h"
#import "HWServiceMoreView.h"

@interface HWServiceMoreVC ()<HWServiceMoreViewDelegate>
{
    HWServiceMoreView *_mainView;
}
@end

@implementation HWServiceMoreVC

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.titleView = [Utility navTitleView:@"更多服务"];
    
    _mainView = [[HWServiceMoreView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT) homePageIconArr:self.homepageIconArr];
    _mainView.delegate = self;
    _mainView.fatherVC = self;
    [self.view addSubview:_mainView];
}

- (void)pushViewController:(UIViewController *)vc
{
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - HWServiceMoreViewDelegate
- (void)setRefresh
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(setRefresh)])
    {
        [self.delegate setRefresh];
    }
}

- (void)pushVC:(UIViewController *)VC
{
    [self pushViewController:VC];
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
