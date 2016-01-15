//
//  ViewController.m
//  引导页动画一
//
//  Created by lizhongqiang on 15/7/21.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "ViewController.h"
#import "HWLeadPageScroll.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:[[HWLeadPageScroll alloc]init]];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
