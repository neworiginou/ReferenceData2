//
//  HWAuthenticateWaitMailViewController.m
//  Community
//
//  Created by hw500027 on 15/6/15.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：个人资料 认证门牌界面(等待收信)
//
//  修改记录：
//      姓名         日期               修改内容
//     陆晓波     2015-06-15           创建文件
//

#import "HWAuthenticateWaitMailViewController.h"
#import "HWAuthenticateWaitMailView.h"

@interface HWAuthenticateWaitMailViewController ()
{
    HWAuthenticateWaitMailView *_view;
}
@end

@implementation HWAuthenticateWaitMailViewController

- (void)viewWillAppear:(BOOL)animated
{
    if (self.isPopThreeVC)
    {
        MLNavigationController *navigation = (MLNavigationController *)self.navigationController;
        navigation.canDragBack = NO;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (self.isPopThreeVC)
    {
        MLNavigationController *navigation = (MLNavigationController *)self.navigationController;
        navigation.canDragBack = YES;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.titleView = [Utility navTitleView:@"认证门牌"];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 60.0f, 44.0f);
    [rightButton setTitleColor:THEME_COLOR_ORANGE forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
    [rightButton setTitle:@"取消认证" forState:UIControlStateNormal];
    rightButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -5);
    [rightButton addTarget:self action:@selector(toCancel) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    _view = [[HWAuthenticateWaitMailView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT)];
    [self.view addSubview:_view];
}

- (void)backMethod
{
    if (self.isPopThreeVC)
    {
        NSArray *vcArr = self.navigationController.viewControllers;
        UIViewController *lastScdVC = [vcArr pObjectAtIndex:vcArr.count - 5];
        [self.navigationController popToViewController:lastScdVC animated:YES];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

//取消认证
- (void)toCancel
{
    NSLog(@"%@",_view.dic);
    [Utility hideMBProgress:self.view];
    [Utility showMBProgress:self.view message:@"请求数据"];
    
    
    NSMutableDictionary *parame = [[NSMutableDictionary alloc] init];
    [parame setPObject:[_view.dic stringObjectForKey:@"applyId"] forKey:@"applyId"];
    [parame setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POST:kCancelForAuthentication parameters:parame queue:nil success:^(id responese)
     {
         [Utility hideMBProgress:self.view];
         if ([[responese stringObjectForKey:@"status"] isEqual:@"1"])
         {
             [Utility showToastWithMessage:@"取消成功" inView:self.view];
         }
         [self backMethod];
         
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
