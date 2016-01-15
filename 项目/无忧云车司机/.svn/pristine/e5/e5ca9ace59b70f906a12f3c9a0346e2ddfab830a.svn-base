//
//  WYYCTabBarViewController.m
//  无忧云车司机
//
//  Created by luosai19910103@163.com on 15/6/18.
//  Copyright (c) 2015年 wuyouyunche. All rights reserved.
//
//RGB颜色
#define WYColor(r,g,b)     [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#import "WYYCTabBarViewController.h"
#import "WYYCHomeViewController.h"
#import "WYYCProfileTableViewController.h"
#import "SwipableViewController.h"
#import "WYYCGrabOrderTableViewController.h"
#import "WYYCFinishedOrderViewController.h"
#import "WYYCNavViewController.h"
@interface WYYCTabBarViewController ()

@end

@implementation WYYCTabBarViewController

+ (void)initialize
{
    //[[UITabBar appearance] setBarTintColor:WYColor(30, 179, 219)];
    
    //[[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}
      //                                       forState:UIControlStateSelected];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    WYYCGrabOrderTableViewController *grabOrderVC=[[WYYCGrabOrderTableViewController alloc]init];
    WYYCFinishedOrderViewController *finishedOrderVC=[[WYYCFinishedOrderViewController alloc]init];
    
    WYYCHomeViewController *homeVC=[[WYYCHomeViewController alloc]init];
    SwipableViewController *orderVC=[[SwipableViewController alloc]initWithTitle:@"订单" andSubTitles:@[@"抢单",@"已完成"] andControllers:@[grabOrderVC,finishedOrderVC]underTabbar:YES];
    
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    WYYCProfileTableViewController *profileVC=[storyboard instantiateViewControllerWithIdentifier:@"profile"];
    
    self.viewControllers=@[[self addNavigationItemForViewController:homeVC],
                           [self addNavigationItemForViewController:orderVC],
                           [self addNavigationItemForViewController:profileVC]];
    
   // self.viewControllers=@[homeVC,orderVC,profileVC];
   
    UITabBarItem *homeTabBarItem = [[UITabBarItem alloc]initWithTitle:@"首页" image:[UIImage imageNamed:@"home_icon"] tag:0];
    UITabBarItem *orderTabBarItem = [[UITabBarItem alloc]initWithTitle:@"订单" image:[UIImage imageNamed:@"orderCenter_icon"] tag:1];
   // [UITabBarItem alloc]initWithTitle:<#(NSString *)#> image:<#(UIImage *)#> selectedImage:<#(UIImage *)#>
   
    UITabBarItem *profileTabBarItem = [[UITabBarItem alloc]initWithTitle:@"我的" image:[UIImage imageNamed:@"profile_icon"] tag:1];

    orderVC.tabBarItem = orderTabBarItem;
    homeVC.tabBarItem = homeTabBarItem;
    profileVC.tabBarItem = profileTabBarItem;
}


#pragma mark -

- (UINavigationController *)addNavigationItemForViewController:(UIViewController *)viewController
{
    
    WYYCNavViewController *navigationController = [[WYYCNavViewController alloc] initWithRootViewController:viewController];
    return navigationController;
}

- (void) popoverController{
    
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
