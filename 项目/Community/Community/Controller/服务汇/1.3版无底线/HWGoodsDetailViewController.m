//
//  HWGoodsDetailViewController.m
//  Community
//
//  Created by lizhongqiang on 15/4/13.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWGoodsDetailViewController.h"
#import "HWShareViewModel.h"
#import "HWCutPriceView.h"
#import "AppDelegate.h"

@interface HWGoodsDetailViewController ()<HWCutPriceViewDelegate,UITextFieldDelegate,HWShareViewModelDelegate>
{
    UIImageView *gView;
    HWCutPriceView *cutPrice;
}
@end

@implementation HWGoodsDetailViewController
@synthesize productId;
@synthesize joinedItem;
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [cutPrice getRemainTimes];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardwasShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardwasHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
//    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
//    self.navigationItem.titleView = [Utility navTitleView:@"无底线"];
//    self.navigationItem.rightBarButtonItem = [Utility navButton:self title:@"分享" action:@selector(share)];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardwasShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardwasHide:) name:UIKeyboardWillHideNotification object:nil];
    
    cutPrice = [[HWCutPriceView alloc] initWithFrame:CGRectMake(0, -20, kScreenWidth, CONTENT_HEIGHT + 64 + 20) productId:productId joinActivity:self.joinedItem];
    cutPrice.delegate = self;
    [self.view addSubview:cutPrice];
    
}

- (void)keyboardwasShown:(NSNotification *)aNottfication
{
    CGFloat keyboardHeight = [[aNottfication.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    NSLog(@"keyboardHeight==%f",keyboardHeight);
    [UIView animateWithDuration:0.3 animations:^{
//        [self.view setBounds:CGRectMake(self.view.bounds.origin.x, 0 + keyboardHeight, self.view.bounds.size.width, self.view.bounds.size.height)];
        self.view.frame = CGRectMake(self.view.frame.origin.x,- keyboardHeight,self.view.frame.size.width,self.view.frame.size.height);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)keyboardwasHide:(NSNotification *)aNottfication
{
    CGFloat keyboardHeight = [[aNottfication.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    NSLog(@"keyboardHeight==%f",keyboardHeight);
    [UIView animateWithDuration:0.3 animations:^{
//        [self.view setBounds:CGRectMake(self.view.bounds.origin.x, 0 , self.view.bounds.size.width, self.view.bounds.size.height)];
        self.view.frame = CGRectMake(self.view.frame.origin.x,0,self.view.frame.size.width,self.view.frame.size.height);
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - HWCutPriceViewDelegate
- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
    if (self.delegate && [self.delegate respondsToSelector:@selector(goodsListRefreshView)])
    {
        [self.delegate goodsListRefreshView];
    }
}

- (void)shareUrl:(NSString *)strUrl shareImage:(UIImage *)image ShareContent:(NSString *)strContent
{
    //分享内容 图片 url 需要从view传过来
    HWShareViewModel *share = [[HWShareViewModel alloc] initWithShareContent:strContent image:image shareUrl:strUrl];
    share.delegate = self;
    [share showInView:self.view presentController:self];
}

- (void)shareSuccessByWay:(NSString *)way
{
    [Utility showMBProgress:self.view message:@"获得砍价次数"];
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setPObject:way forKey:@"channel"];
    [param setPObject:@"1" forKey:@"source"];
    [param setPObject:productId forKey:@"productId"];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager cutManager];
    [manager POST:kShareGetTimes parameters:param queue:nil success:^(id responese) {
        [Utility hideMBProgress:self.view];
        [cutPrice getRemainTimes];
    } failure:^(NSString *code, NSString *error) {
        [Utility hideMBProgress:self.view];
        [Utility showToastWithMessage:error inView:self.view];
    }];
}

- (void)popToDetailViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)popToDetailViewControllerWithFefresh
{
    [self.navigationController popViewControllerAnimated:YES];
    if (self.delegate && [self.delegate respondsToSelector:@selector(goodsListRefreshView)])
    {
        [self.delegate goodsListRefreshView];
    }
}

- (void)pushViewControllerWithDelegate:(UIViewController *)vc
{
    [self.navigationController pushViewController:vc animated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)toBindMobile
{
    if ([HWUserLogin verifyBindMobileWithPopVC:self showAlert:YES])
    {
        if ([HWUserLogin verifyIsLoginWithPresentVC:self toViewController:nil])
        {
            
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
