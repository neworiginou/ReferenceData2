//
//  HWAuthenticateChoseVC.m
//  Community
//
//  Created by niedi on 15/8/4.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWAuthenticateChoseVC.h"
#import "HWAuthenticateChoseView.h"
#import "HWAuthenticateStressAddressViewController.h"
#import "HWWuYeAuthenticateFirstVC.h"

@interface HWAuthenticateChoseVC ()<HWAuthenticateChoseViewDelegate>
{
    HWAuthenticateChoseView *_mainView;
}
@end

@implementation HWAuthenticateChoseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [Utility navTitleView:@"选择认证"];
    
    _mainView = [[HWAuthenticateChoseView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT)];
    _mainView.delegate = self;
    [self.view addSubview:_mainView];
}

#pragma mark - HWAuthenticateChoseViewDelegate
- (void)cellClickForRow:(NSInteger)row
{
    if (row == 0)
    {
        //认证门牌
        HWAuthenticateStressAddressViewController *vc = [[HWAuthenticateStressAddressViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (row == 1)
    {
        HWWuYeAuthenticateFirstVC *vc = [[HWWuYeAuthenticateFirstVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
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
