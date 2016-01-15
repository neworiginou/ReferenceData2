//
//  HWWuYePayRecordDetailVC.m
//  Community
//
//  Created by niedi on 15/6/26.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWWuYePayRecordDetailVC.h"
#import "HWWuYePayRecordDetailView.h"

@interface HWWuYePayRecordDetailVC ()
{
    HWWuYePayRecordDetailView *_mainView;
}
@end

@implementation HWWuYePayRecordDetailVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.titleView = [Utility navTitleView:@"详情"];
    
    _mainView = [[HWWuYePayRecordDetailView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT) model:self.model];
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
