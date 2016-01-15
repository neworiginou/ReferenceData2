//
//  HWTianTianTuanDetailVC.m
//  Community
//
//  Created by niedi on 15/7/31.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWTianTianTuanDetailVC.h"
#import "HWTianTianTuanDetailView.h"
#import "AppDelegate.h"
#import "HWCommondityDetailViewController.h"
#import "HWConfirmPayViewController.h"

@interface HWTianTianTuanDetailVC ()<HWTianTianTuanDetailViewDelegate>
{
    HWTianTianTuanDetailView *_mainView;
}
@end

@implementation HWTianTianTuanDetailVC

- (UIBarButtonItem *)rightBarButtonItem
{
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 60.0f, 44.0f);
    [rightButton setTitleColor:THEME_COLOR_ORANGE forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
    [rightButton setTitle:@"取消订单" forState:UIControlStateNormal];
    rightButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -5);
    [rightButton addTarget:self action:@selector(cancleOrderQuery) forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        self.popType = -1;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    if (self.popType == ttTOrderDetailPopTypeOneVC)
    {
        MLNavigationController *navigation = (MLNavigationController *)self.navigationController;
        navigation.canDragBack = NO;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (self.popType == ttTOrderDetailPopTypeOneVC)
    {
        MLNavigationController *navigation = (MLNavigationController *)self.navigationController;
        navigation.canDragBack = YES;
    }
}

- (void)backMethod
{
    if (self.popType == ttTOrderDetailPopTypeOneVC)
    {
        NSArray *vcArr = self.navigationController.viewControllers;
        UIViewController *lastScdVC = [vcArr pObjectAtIndex:vcArr.count - 3];
        [self.navigationController popToViewController:lastScdVC animated:YES];
    }
    else
    {
        [super backMethod];
    }
    
    [_mainView invalidaTimer];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.titleView = [Utility navTitleView:@"订单详情"];
    
    _mainView = [[HWTianTianTuanDetailView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT) orderId:self.orderId];
    _mainView.delegate = self;
    [self.view addSubview:_mainView];
}

- (void)cancleOrderQuery
{
    /*url：http://172.16.10.110:8080/hw-sq-app-web/grpBuyOrder/cancelGrpBuyOrder.do
     输入参数说明：
     key：考拉社区登录成功用户被授权的key(必填)
     orderId：被取消的订单id(必填)*/
    [Utility hideMBProgress:self.view];
    [Utility showMBProgress:self.view message:LOADING_TEXT];
    
    NSMutableDictionary *parame = [[NSMutableDictionary alloc] init];
    [parame setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [parame setPObject:_orderId forKey:@"orderId"];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POST:KTianTianTuanCancleOrder parameters:parame queue:nil success:^(id responese)
     {
         [Utility hideMBProgress:self.view];
         NSLog(@"%@", responese);
         
         [Utility showToastWithMessage:@"取消成功" inView:[(AppDelegate *)SHARED_APP_DELEGATE window]];
         [self refreshListData];
         [self.navigationController popViewControllerAnimated:YES];
         
     } failure:^(NSString *code, NSString *error) {
         NSLog(@"code==%@  error==%@",code,error);
         
         [Utility hideMBProgress:self.view];
         [Utility showToastWithMessage:error inView:self.view];
     }];
}

- (void)refreshListData
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancleOrderReQueryList)])
    {
        [self.delegate cancleOrderReQueryList];
    }
}

#pragma mark - HWTianTianTuanDetailViewDelegate
- (void)showCancleOrderBtn:(BOOL)isShow
{
    if (isShow)
    {
        self.navigationItem.rightBarButtonItem = [self rightBarButtonItem];
    }
    else
    {
        self.navigationItem.rightBarButtonItem = nil;
    }
}

- (void)pushToTianTianTuanGoodsDetail:(NSString *)goodsId
{
    HWCommondityDetailViewController *dvc = [[HWCommondityDetailViewController alloc] init];
    HWCommondityModel *model = [[HWCommondityModel alloc] init];
    model.goodsId = goodsId;
    dvc.model = model;
    [self.navigationController pushViewController:dvc animated:YES];
}

- (void)pushToPayConfirmVC:(NSString *)orderId
{
    HWConfirmPayViewController *controller = [[HWConfirmPayViewController alloc] init];
    controller.orderId = orderId;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)timerEndPopToListVC
{
    [self refreshListData];
    [self.navigationController popViewControllerAnimated:YES];
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
