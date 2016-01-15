//
//  HWAuthenticateMoreAddressViewController1.m
//  Community
//
//  Created by hw500027 on 15/6/24.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWAuthenticateMoreAddressViewController1.h"
#import "HWWuYeAddHouse1View.h"

@interface HWAuthenticateMoreAddressViewController1 () <HWWuYeAddHouse1ViewDelegate>

@end

@implementation HWAuthenticateMoreAddressViewController1

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.titleView = [Utility navTitleView:@"添加门牌"];
    
    HWWuYeAddHouse1View *view = [[HWWuYeAddHouse1View alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT) model:_model];
    view.delegate = self;
    view.isAddaddress = YES;
    [self.view addSubview:view];
}

- (void)didSelectAddressList:(HWWuYeAddHouseModel *)model
{
    if (_delegate && [_delegate respondsToSelector:@selector(popToMoreAddressVC:)])
    {
        [_delegate popToMoreAddressVC:model];
    }
    [self.navigationController popToViewController:[self.navigationController.viewControllers pObjectAtIndex:self.navigationController.viewControllers.count - 3] animated:YES];
}

- (void)doneAddHouse
{
    
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
