//
//  HWServiceListDetailViewController.m
//  Community
//
//  Created by hw500027 on 15/6/18.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：我的订单 服务订单 订单详情
//  修改记录：
//	姓名   日期　　　　　　 修改内容
//  陆晓波  2015-01-15    文件创建

#import "HWServiceListDetailViewController.h"
#import "HWServiceListDetailView.h"

@interface HWServiceListDetailViewController () <HWServiceListDetailViewDelegate>
{
    HWServiceListDetailView *detailView;
}
@end

@implementation HWServiceListDetailViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    if (self.pushType == pushHomeServiceDetailTypeWY)
    {
        MLNavigationController *navigation = (MLNavigationController *)self.navigationController;
        navigation.canDragBack = NO;
    }
    
    if (detailView)
    {
        [detailView queryListData];
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    MLNavigationController *navigation = (MLNavigationController *)self.navigationController;
    navigation.canDragBack = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.titleView = [Utility navTitleView:@"订单详情"];

    detailView = [[HWServiceListDetailView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT) withOrderID:_orderID];
    detailView.delegate = self;
    detailView.pushType = self.pushType;
    [self.view addSubview:detailView];
}

- (void)backMethod
{
    if (self.pushType == pushHomeServiceDetailTypeWY)
    {
        NSArray *vcArr = self.navigationController.viewControllers;
        UIViewController *lastScdVC = [vcArr pObjectAtIndex:vcArr.count - 4];
        [self.navigationController popToViewController:lastScdVC animated:YES];
    }
    else
    {
        [super backMethod];
    }
}

#pragma mark - HWServiceListDetailViewDelegate
- (void)showRightBarButtonItem:(BOOL)isShow
{
    if (isShow)
    {
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        rightButton.frame = CGRectMake(0, 0, 60.0f, 44.0f);
        [rightButton setTitleColor:THEME_COLOR_ORANGE forState:UIControlStateNormal];
        rightButton.titleLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
        [rightButton setTitle:@"取消订单" forState:UIControlStateNormal];
        rightButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -5);
        [rightButton addTarget:self action:@selector(toCancelList) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    }
    else
    {
        self.navigationItem.rightBarButtonItem = nil;
    }
}

- (void)didClickBtnToCommentVC:(UIViewController *)vc
{
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)toCancelList
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确认要取消订单吗？" delegate:self cancelButtonTitle:@"返回" otherButtonTitles:@"确认取消", nil];
    [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
        if (buttonIndex == 1)
        {
            [self cancleQuery];
        }
    }];
}

- (void)cancleQuery
{
    NSLog(@"订单详情-取消订单");
    [Utility hideMBProgress:self.view];
    [Utility showMBProgress:self.view message:@"请求数据"];
    
    NSMutableDictionary *parame = [[NSMutableDictionary alloc] init];
    [parame setPObject:_orderID forKey:@"orderId"];
    [parame setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POST:kCancelServeOrder parameters:parame queue:nil success:^(id responese)
     {
         [Utility hideMBProgress:self.view];
         [Utility showToastWithMessage:@"请求成功" inView:self.view];
         
         if (self.pushType == pushHomeServiceDetailTypeList)
         {
             NSArray *vcArr = self.navigationController.viewControllers;
             UIViewController *lastScdVC = [vcArr pObjectAtIndex:vcArr.count - 2];
             [self.navigationController popToViewController:lastScdVC animated:YES];
         }
         else if (self.pushType == pushHomeServiceDetailTypeWY)
         {
             NSArray *vcArr = self.navigationController.viewControllers;
             UIViewController *lastScdVC = [vcArr pObjectAtIndex:vcArr.count - 4];
             [self.navigationController popToViewController:lastScdVC animated:YES];
         }
         else
         {
             [self.navigationController popViewControllerAnimated:YES];
         }
         
     } failure:^(NSString *code, NSString *error)
     {
         [Utility hideMBProgress:self.view];
         [Utility showToastWithMessage:error inView:self.view];
     }];
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
