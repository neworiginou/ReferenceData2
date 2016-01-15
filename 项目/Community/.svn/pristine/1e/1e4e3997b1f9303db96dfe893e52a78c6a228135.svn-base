//
//  HWCommondityDetailViewController.m
//  Community
//
//  Created by ryder on 7/30/15.
//  Copyright (c) 2015 caijingpeng. All rights reserved.
//
//  功能描述：
//      天天团商品详情页
//  修改记录：
//      姓名         日期              修改内容
//     程耀均     2015-07-30           创建文件



#import "HWCommondityDetailViewController.h"
#import "HWSubmitOrderViewController.h"
#import "AppDelegate.h"
#import "HWConfirmPayViewController.h"

@interface HWCommondityDetailViewController ()<HWShareViewDelegate, HWCommodityDetailViewDelegate>
{
    //分享相关
    UIView *_pushView;
    UIView *_popView;
    
    NSString *shareTitle;
    NSString *shareContent;
    NSString *shareUrl;
    UIImage *shareImg;
    
    //主视图
    HWCommondityDetailView *_mainView;
}
@end

@implementation HWCommondityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.titleView = [Utility navTitleView:@"商品详情"];
    
    _mainView = [[HWCommondityDetailView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT) goodsId:self.model.goodsId];
    _mainView.delegate = self;
    _mainView.rDelegate = self;
    _mainView.superVC = self;
    [self.view addSubview:_mainView];
}

#pragma mark -
#pragma Implementation HWCommondityDelegate
- (void)didSubmitOrder:(NSInteger)count price:(CGFloat)total orderId:(NSString *)orderId //金额等无用
{
    HWConfirmPayViewController *controller = [[HWConfirmPayViewController alloc] init];
    controller.orderId = orderId;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - HWCommodityDetailViewDelegate
- (void)pushToVC:(UIViewController *)vc
{
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)showShareBtn:(BOOL)isShow
{
    self.navigationItem.rightBarButtonItem = [Utility navButton:self image:@"分享" action:@selector(share)];
}

#pragma mark - 分享
- (void)share
{
    [MobClick event:@"click_group_share"];//1.7
    
    BOOL isNormalH = [Utility isInstalledQQ] || [Utility isInstalledWX];
    
    _popView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _popView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    AppDelegate *appDel = SHARED_APP_DELEGATE;
    [appDel.window addSubview:_popView];
    
    //灰色背景视图
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, [UIScreen mainScreen].bounds.size.height - 215.0f - 50.0f)];
    if (!isNormalH)
    {
        backView.frame = CGRectMake(0, 0, kScreenWidth, [UIScreen mainScreen].bounds.size.height - 50.0f - 115.0f);
    }
    backView.backgroundColor = [UIColor clearColor];
    backView.userInteractionEnabled = YES;
    [_popView addSubview:backView];
    UITapGestureRecognizer *grayGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeTheSuperView)];
    [backView addGestureRecognizer:grayGesture];
    
    _pushView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_popView.frame), kScreenWidth, isNormalH ? 265.0f : 165.0f)];
    _pushView.backgroundColor = [UIColor clearColor];
    [_popView addSubview:_pushView];
    
    shareTitle = [NSString stringWithFormat:@"%@只要%@元！快来和我一起团！", _mainView.detailModel.goodsName , _mainView.detailModel.sellPrice];
    shareContent = @"所有美食均由原产地直接配送，顶级品质，超低价格！";
    shareUrl = [NSString stringWithFormat:@"%@%@", KTianTianTuanShareUrl, self.model.goodsId];
    
    HWShareView *shareView = [[HWShareView alloc] initWithShareTitile:shareTitle content:shareContent image:_mainView.shareImg.image shareUrl:shareUrl];
    shareView.frame = CGRectMake(0, 0, kScreenWidth, 215.0f);
    if (!isNormalH)
    {
        shareView.frame = CGRectMake(0, 0, kScreenWidth, 115.0f);
    }
    shareView.backgroundColor = [UIColor whiteColor];
    shareView.copiesUrl = shareUrl;
    shareView.superView = self.view;
    shareView.gameId = @"";
    shareView.shareSource = tianTianTuan;
    [shareView showInView:self.view presentController:self];
    shareView.delegate = self;
    [_pushView addSubview:shareView];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(shareView.frame) - 0.5f, kScreenWidth, 0.5f)];
    line.backgroundColor = THEME_COLOR_LINE;
    [_pushView addSubview:line];
    
    //取消
    UILabel *cancleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(line.frame), kScreenWidth, 50.f)];
    cancleLabel.backgroundColor = [UIColor whiteColor];
    cancleLabel.text = @"取消";
    cancleLabel.font = [UIFont fontWithName:FONTNAME size:18.0f];
    cancleLabel.textColor = THEME_COLOR_ORANGE;
    cancleLabel.textAlignment = NSTextAlignmentCenter;
    cancleLabel.userInteractionEnabled = YES;
    [_pushView addSubview:cancleLabel];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeTheSuperView)];
    [cancleLabel addGestureRecognizer:gesture];
    
    [UIView animateWithDuration:0.25 animations:^{
        _pushView.frame = CGRectMake(0, CGRectGetMaxY(backView.frame), kScreenWidth, _pushView.frame.size.height);
    }];
}

- (void)removeTheSuperView
{
    [UIView animateWithDuration:0.5 animations:^{
        _pushView.frame = CGRectMake(0, CGRectGetMaxY(_popView.frame), kScreenWidth, 265.0f);
    } completion:^(BOOL finished) {
        [_popView removeFromSuperview];
    }];
}

#pragma mark - HWShareViewDelegate
- (void)removeSuperView
{
    [_popView removeFromSuperview];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
