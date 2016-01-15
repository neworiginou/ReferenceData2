//
//  HWInviteCustomRecordListlVC.m
//  Community
//
//  Created by niedi on 15/6/13.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWInviteCustomRecordListlVC.h"
#import "HWInviteCustomRecordListView.h"

@interface HWInviteCustomRecordListlVC ()
{
    HWInviteCustomRecordListView *_mainView;
}
@end

@implementation HWInviteCustomRecordListlVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.titleView = [Utility navTitleView:@"验证记录"];
    
    _mainView = [[HWInviteCustomRecordListView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT) tvId:_tvId];
    [self.view addSubview:_mainView];
    
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
