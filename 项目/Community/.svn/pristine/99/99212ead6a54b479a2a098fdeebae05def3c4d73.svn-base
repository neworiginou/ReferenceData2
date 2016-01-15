//
//  HWMyOrderViewController.m
//  Community
//
//  Created by D on 14/12/9.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWMyOrderViewController.h"
#import "HWMyBargainOrderViewController.h"
#import "HWServiceListViewController.h"

@implementation HWMyOrderViewController

- (void)viewDidLoad {
    self.view.backgroundColor = UIColorFromRGB(0xf2f2f2);
    self.navigationItem.titleView = [Utility navTitleView:@"我的订单"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    
    [self LoadUI];
    //刷新钱包
    [self getWalletMoney];
}

- (void)LoadUI {
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT)];
    self.mainScrollView.contentSize = CGSizeMake(kScreenWidth, CONTENT_HEIGHT + 1);
    [self.view addSubview:self.mainScrollView];
    
    //创建按钮
    CGFloat originX = [self creatBtn];
    [self createServiceListBtn:originX];
}
#pragma - mark 获取钱包余额
- (void)getWalletMoney
{
    HWUserLogin *user = [HWUserLogin currentUserLogin];
    HWHTTPRequestOperationManager *manage = [HWHTTPRequestOperationManager accountManager];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setPObject:user.key forKey:@"key"];
    
    [manage POST:kWalletRemainMoney parameters:dict queue:nil success:^(id responseObject) {
        [Utility hideMBProgress:self.view];
        NSDictionary *respDic = (NSDictionary *)[responseObject dictionaryObjectForKey:@"data"];
        [HWUserLogin currentUserLogin].totalMoney = [respDic stringObjectForKey:@"amount"];
        NSString * _walletMoneyStr = [respDic stringObjectForKey:@"amount"];
        if([_walletMoneyStr length]==0)
        {
            _walletMoneyStr = @"0";
            [HWUserLogin currentUserLogin].totalMoney = _walletMoneyStr;
        }
        else
        {
            [HWUserLogin currentUserLogin].totalMoney = _walletMoneyStr;
        }
    } failure:^(NSString *code, NSString *error) {
        [HWUserLogin currentUserLogin].totalMoney = @"0";
    }];
}
- (CGFloat)creatBtn
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor whiteColor];
    btn.frame = CGRectMake(15, 15, 138, 150);
    btn.layer.cornerRadius = 3;
    btn.layer.masksToBounds = YES;
    btn.layer.borderColor = THEME_COLOR_LINE.CGColor;
    btn.layer.borderWidth = 0.5f;
    [btn setImage:[UIImage imageNamed:@"bargain"] forState:UIControlStateNormal];
    btn.imageEdgeInsets = UIEdgeInsetsMake(23, 30, 53, 33);
    
    [btn setTitle:@"无底线订单" forState:UIControlStateNormal];
    [btn setTitleColor:THEME_COLOR_SMOKE forState:UIControlStateNormal];
    
    btn.titleLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
    if (IPHONE6PLUS)
    {
        btn.titleEdgeInsets = UIEdgeInsetsMake(100, -110, 0, 0);
    }
    else
    {
        btn.titleEdgeInsets = UIEdgeInsetsMake(100, -85, 0, 0);
    }
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:btn];
    return CGRectGetMaxX(btn.frame);
}

- (void)createServiceListBtn:(CGFloat)originX
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor whiteColor];
    btn.frame = CGRectMake(15 + originX, 15, 138, 150);
    btn.layer.cornerRadius = 3;
    btn.layer.masksToBounds = YES;
    btn.layer.borderColor = THEME_COLOR_LINE.CGColor;
    btn.layer.borderWidth = 0.5f;
    [btn setImage:[UIImage imageNamed:@"bargain"] forState:UIControlStateNormal];
    btn.imageEdgeInsets = UIEdgeInsetsMake(23, 30, 53, 33);
    
    [btn setTitle:@"服务订单" forState:UIControlStateNormal];
    [btn setTitleColor:THEME_COLOR_SMOKE forState:UIControlStateNormal];
    
    btn.titleLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
    if (IPHONE6PLUS)
    {
        btn.titleEdgeInsets = UIEdgeInsetsMake(100, -110, 0, 0);
    }
    else
    {
        btn.titleEdgeInsets = UIEdgeInsetsMake(100, -85, 0, 0);
    }
    [btn addTarget:self action:@selector(serviceListbtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:btn];
}

- (void)btnClick:(UIButton *)btn
{
    [MobClick event:@"click_wodekanjiadingdan"];
    if ([HWUserLogin verifyBindMobileWithPopVC:self showAlert:YES])
    {
        HWMyBargainOrderViewController *bargainOrderVC = [[HWMyBargainOrderViewController alloc] init];
        [self.navigationController pushViewController:bargainOrderVC animated:YES];

    }
}

- (void)serviceListbtnClick:(UIButton *)btn
{
    HWServiceListViewController *serviceListVC = [[HWServiceListViewController alloc] init];
    [self.navigationController pushViewController:serviceListVC animated:YES];
}

@end
