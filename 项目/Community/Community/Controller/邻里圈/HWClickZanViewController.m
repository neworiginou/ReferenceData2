//
//  HWClickZanViewController.m
//  Community
//
//  Created by hw500029 on 15/1/20.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWClickZanViewController.h"
#import "HWClickZanRefreshView.h"

@interface HWClickZanViewController ()

@end

@implementation HWClickZanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = [Utility navTitleView:@"赞过的人"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    
    float height = 0.0f;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0 )
        height = CONTENT_HEIGHT - 20 ;
    else
        height = CONTENT_HEIGHT ;

    HWClickZanRefreshView *refresh = [[HWClickZanRefreshView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, height) andTopicId:_topicId];
//    __weak HWClickZanViewController *selfVC = self;
//    [refresh setChangeNavTitleView:^(NSString *title) {
//        selfVC.navigationItem.titleView = nil;
//        selfVC.navigationItem.titleView = [Utility navTitleView:title];
//    }];
    
    [self.view addSubview:refresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)backMethod
{
    [MobClick event:@"click_zantongderenfanhui"]; //maidian_1.2.1 MYP add
    [self.navigationController popViewControllerAnimated:YES];
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
