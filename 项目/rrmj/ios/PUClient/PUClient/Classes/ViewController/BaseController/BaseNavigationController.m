//
//  BaseNavigationController.m
//  PUClient
//
//  Created by RRLhy on 15/7/17.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = RGBACOLOR(0.973, 0.973, 0.973, 1);
    

}

+ (void)initialize
{
    //取出设置主题的对象
    UINavigationBar * navBar = [UINavigationBar appearance];
    //设置对象的背景
    NSString * navBarBg = @"nav_bg_home";
    UIImage * backgroundImage  = [UIImage stretchImageWithName:navBarBg];
    navBar.tintColor = [UIColor blackColor];
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
//    [navBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    [navBar setBackgroundImage:backgroundImage forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    //出去navbar上面的细线
    [navBar setShadowImage:[UIImage new]];
   
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
