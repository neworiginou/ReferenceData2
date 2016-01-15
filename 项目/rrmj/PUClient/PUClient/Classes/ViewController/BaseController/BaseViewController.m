//
//  BaseViewController.m
//  PUClient
//
//  Created by RRLhy on 15/7/17.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "BaseViewController.h"
#import "MyPageVC.h"
#import "LoginVC.h"
@interface BaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_back_me_n"] style:UIBarButtonItemStylePlain target:self action:@selector(popViewController)];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
  
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [self netWorkReachabilityStatus];
   
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    
}
#pragma mark 监听网络变化
- (void)netWorkReachabilityStatus {
    
    __block BOOL reachable;
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"No Internet Connection");
                reachable = NO;
                [IanAlert showLoading:@"网络已断开"];
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WIFI");
                
                reachable = YES;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"3G");
                reachable = YES;
                break;
            default:
                NSLog(@"Unkown network status");
                reachable = NO;
                break;
                
        }
    }];
}

#pragma mark 返回上一个视图控制器
- (void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 返回到根视图控制器
- (void)popRootViewController
{
    NSArray * array = self.navigationController.viewControllers;
    MyPageVC * myPage = (MyPageVC*)array[0];
    [myPage reloadUIData];
    [self.navigationController popToViewController:array[0] animated:YES];
}

#pragma mark 跳转登录界面
- (void)skipToLoginVc
{
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginVC * loginVC = [storyboard instantiateViewControllerWithIdentifier:@"loginVC"];
    [self.navigationController pushViewController:loginVC animated:YES];
}

#pragma mark 请求数据
- (void)requestData
{
    
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
