//
//  HWPayConfirmVC.m
//  Community
//
//  Created by niedi on 15/6/24.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWPayConfirmVC.h"
#import "HWPayConfirmView.h"

@interface HWPayConfirmVC () <HWPayConfirmViewDelegate>
{
    HWPayConfirmView *_mainView;
}
@end

@implementation HWPayConfirmVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.titleView = [Utility navTitleView:@"收银台"];
    
    _mainView = [[HWPayConfirmView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT)  model:self.model type:self.type];
    _mainView.delegate = self;
    [self.view addSubview:_mainView];
}

- (void)pushViewController:(UIViewController *)vc
{
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)popToWuYeFeeVC
{
    NSArray *vcArr = self.navigationController.viewControllers;
    UIViewController *lastScdVC = [vcArr pObjectAtIndex:vcArr.count - 2];
    [self.navigationController popToViewController:lastScdVC animated:YES];
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
