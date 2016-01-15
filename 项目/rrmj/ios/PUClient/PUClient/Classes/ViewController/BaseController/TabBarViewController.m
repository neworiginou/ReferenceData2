//
//  TabBarViewController.m
//  PUClient
//
//  Created by RRLhy on 15/7/17.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "TabBarViewController.h"

@interface TabBarViewController ()<UINavigationControllerDelegate>

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 49)];
//    backView.backgroundColor = [UIColor blackColor];
//    [self.tabBarController.tabBar insertSubview:backView atIndex:0];
//    self.tabBarController.tabBar.opaque = YES;
    
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    
    return UIInterfaceOrientationMaskPortrait;//只支持这一个方向(正常的方向)
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
