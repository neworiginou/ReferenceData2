//
//  HWShopListViewController.m
//  Community
//
//  Created by lizhongqiang on 15/4/8.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWShopListViewController.h"
#import "HWShopListTableView.h"

@interface HWShopListViewController ()

@end

@implementation HWShopListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.titleView = [Utility navTitleView:self.shopName];
    
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    
    HWShopListTableView *shopView = [[HWShopListTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT) typeId:self.typeId];
    [self.view addSubview:shopView];
    
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
