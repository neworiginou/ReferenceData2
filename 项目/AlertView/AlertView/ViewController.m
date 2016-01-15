//
//  ViewController.m
//  AlertView
//
//  Created by lizhongqiang on 15/7/7.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "ViewController.h"

#import "HWAlertView.h"

@interface ViewController ()

@property (nonatomic, strong)HWAlertView *alertView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn addTarget:self action:@selector(show) forControlEvents:UIControlEventTouchUpInside];
    
    btn.frame = CGRectMake(100, 100, 40, 20);
    
    btn.backgroundColor = [UIColor blackColor];
    
    [btn setTitle:@"显示" forState:UIControlStateNormal];
    
    [self.view addSubview:btn];
    
    
}
- (void)show
{
    
//    if(_alertView)
//    {
//        [self.view addSubview:_alertView];
//        
//        [_alertView show];
//        
//        
//        return;
//    }
    
    HWAlertView *alertView = [[HWAlertView alloc]init];
    
    [alertView show];
    
    alertView.tipNumber = @"201412120012";
    
    alertView.projectName = @"项目";
    
    alertView.perpoleName = @"小强";
    
    alertView.telephone = @"1822222222";
    
    alertView.context = @"内容";
    
    alertView.money = @"100000";
    
    alertView.numberArr = @[@{@"number":@"2013083828",@"money":@"200000.1",@"time":@"2014/13/12  12:46"},@{@"number":@"2013083828",@"money":@"8.91",@"time":@"2014/13/12  12:46"}];
    
    alertView.getTime = @"2014年11月2日  12:25";
    
    _alertView = alertView;
//
//    [self.view addSubview:_alertView];
}
- (void)hide
{
    [_alertView hide];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
