//
//  HWDiscountViewController.m
//  Community
//
//  Created by caijingpeng.haowu on 15/1/17.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：
//      优惠券 列表 viewcontroller
//  修改记录：
//      姓名         日期               修改内容
//     蔡景鹏     2015-01-21           创建文件
//

#import "HWDiscountViewController.h"
#import "HWDiscountRefreshView.h"
#import "HWPriviledgeDetailVC.h"

@interface HWDiscountViewController ()<HWDiscountRefreshViewDelegate>
{
    HWDiscountRefreshView *_discountView;
}
@end

@implementation HWDiscountViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    self.navigationItem.titleView = [Utility navTitleView:@"优惠券"];
    
    _discountView = [[HWDiscountRefreshView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT)];
    _discountView.delegate = self;
    [self.view addSubview:_discountView];
}

#pragma mark -
#pragma mark        HWDiscountRefreshView Delegate

- (void)didSelectDirectGetPriviledge:(HWPriviledgeModel *)priviledge
{
//     if ([priviledge.priviledgeType isEqualToString:@"2"])
//     {
         HWPriviledgeDetailVC *priviledgeView = [[HWPriviledgeDetailVC alloc] init];
         [priviledgeView setRefershPriviledgeData:^(NSString *priviledgeId) {
             //问题123   什么时候刷新状态
//             [_discountView refreshPriviledgeType:priviledgeId];
         }];
         priviledgeView.priviledgeId = priviledge.priviledgeId;
//         priviledgeView.priviledgeTypeStr = priviledge.priviledgeType;
         [self.navigationController pushViewController:priviledgeView animated:YES];
//     }
    
}

- (void)didSelectPriviledgeDetail:(HWPriviledgeModel *)priviledge activeTime:(int)aTime
{
    [MobClick event:@"click_youhuiquanliebiao"];
    [MobClick event:@"click_youhuiquantupian"];
//    [priviledgeTimer invalidate];
//    priviledgeTimer = nil;
    
    HWPriviledgeDetailVC *priviledgeView = [[HWPriviledgeDetailVC alloc]init];
    
    [priviledgeView setRefershPriviledgeData:^(NSString *priviledgeId) {
        //问题123   什么时候刷新状态
        //             [_discountView refreshPriviledgeType:priviledgeId];
    }];
    priviledgeView.priviledgeId = priviledge.priviledgeId;

//    priviledgeView.priviledgeTypeStr = priviledge.priviledgeType;
//    int remianTime = [priviledge.remainMsStr integerValue] / 1000.0f;
//    NSString *remainTimeStr = [NSString stringWithFormat:@"%d", remianTime - aTime];
    [self.navigationController pushViewController:priviledgeView animated:YES];
}

- (void)didReceiveMemoryWarning
{
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
