//
//  ViewController.m
//  引导页动画一
//
//  Created by lizhongqiang on 15/7/21.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "ViewController.h"
#import "HWAnimationPageOne.h"
#import "HWAnimationPageTwo.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HWAnimationPageTwo *view = (HWAnimationPageTwo *)self.view;
    
    [view startAnimation];
}
- (void)loadView
{
    self.view = [[HWAnimationPageTwo alloc]init];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
