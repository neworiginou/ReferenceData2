//
//  WYYCAccountViewController.m
//  无忧云车司机
//
//  Created by luosai19910103@163.com on 15/6/19.
//  Copyright (c) 2015年 wuyouyunche. All rights reserved.
//

#import "WYYCAccountViewController.h"
#import "WYYCAccountDetailViewController.h"
#import "WYYCBindingAccountViewController.h"
@interface WYYCAccountViewController ()
/**
 *  账户余额
 */
@property (weak, nonatomic) IBOutlet UILabel *accountBalance;
/**
 *  累计收入
 */
@property (weak, nonatomic) IBOutlet UILabel *totalIcome;
/**
 *  累计提现
 */
@property (weak, nonatomic) IBOutlet UILabel *cash;
/**
 *  账户明细
 */
- (IBAction)accountDetail:(UIButton *)sender;
/**
 *  提现
 */
- (IBAction)withdraw:(id)sender;

@end

@implementation WYYCAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

- (IBAction)accountDetail:(UIButton *)sender {
    
    WYYCAccountDetailViewController *accountDetailVC=[[WYYCAccountDetailViewController alloc]init];
    [self.navigationController pushViewController:accountDetailVC animated:YES];
}

- (IBAction)withdraw:(id)sender {
    WYYCBindingAccountViewController *bindingAccountVC=[[WYYCBindingAccountViewController alloc]init];
    [self.navigationController pushViewController:bindingAccountVC animated:YES];
}


- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden=YES;
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden=NO;
    
}
@end
