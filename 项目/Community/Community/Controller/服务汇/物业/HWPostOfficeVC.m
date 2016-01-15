//
//  HWPostOfficeVC.m
//  Community
//
//  Created by niedi on 15/6/12.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWPostOfficeVC.h"
#import "HWPostOfficeRecordVC.h"
#import "HWHWPostOfficeView.h"

@interface HWPostOfficeVC ()
{
    HWHWPostOfficeView *_mainView;
}
@end

@implementation HWPostOfficeVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.titleView = [Utility navTitleView:@"邮局"];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self title:@"历史" action:@selector(chechRecords)];
    
    _mainView = [[HWHWPostOfficeView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT)];
    [self.view addSubview:_mainView];
    
}

- (void)chechRecords
{
    HWPostOfficeRecordVC *recordVC = [[HWPostOfficeRecordVC alloc] init];
    [self pushViewController:recordVC];
}

- (void)pushViewController:(UIViewController *)VC
{
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
