//
//  HWAuthenticateMoreAddressViewController.m
//  Community
//
//  Created by hw500027 on 15/6/24.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWAuthenticateMoreAddressViewController.h"
#import "HWWuYeAddHouseView.h"
#import "HWAuthenticateMoreAddressViewController1.h"
@interface HWAuthenticateMoreAddressViewController () <HWWuYeAddHouseViewDelegate,HWAuthenticateMoreAddressViewController1Delegate>

@end

@implementation HWAuthenticateMoreAddressViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.titleView = [Utility navTitleView:@"添加门牌"];
    
    HWWuYeAddHouseView *view = [[HWWuYeAddHouseView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT)];
    view.delegate = self;
    [self.view addSubview:view];
}

- (void)didClickCellWithModel:(HWWuYeAddHouseModel *)model
{
    HWAuthenticateMoreAddressViewController1 *vc = [[HWAuthenticateMoreAddressViewController1 alloc] init];
    vc.delegate = self;
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)popToMoreAddressVC:(HWWuYeAddHouseModel *)model
{
    if (_delegate && [_delegate respondsToSelector:@selector(popToAuthenticateStressAddressViewController:)])
    {
        [_delegate popToAuthenticateStressAddressViewController:model];
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
