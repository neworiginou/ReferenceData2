//
//  ViewController.m
//  HWWheel
//
//  Created by lizhongqiang on 15/9/22.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "ViewController.h"
#import "HWWheelActivityVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"幸运大转盘" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(100, 100, 100, 20);
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(turnToNext) forControlEvents:UIControlEventTouchUpInside];
}
- (void)turnToNext
{
    [self.navigationController pushViewController:[[HWWheelActivityVC alloc]init] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
