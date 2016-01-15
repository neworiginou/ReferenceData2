//
//  HWGuideFactory.m
//  Community
//
//  Created by caijingpeng.haowu on 15/1/20.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：生成 引导页 类  自动控制只显示一次
//
//  修改记录：
//      姓名         日期               修改内容
//     蔡景鹏     2015-01-20           创建文件
//

#import "HWGuideFactory.h"
#import "AppDelegate.h"

#define GUIDEVIEW_TAG   100001

@implementation HWGuideFactory

static HWGuideFactory *_guideFactory = nil;

+ (HWGuideFactory *)shareGuideFactory
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _guideFactory = [[HWGuideFactory alloc] init];
    });
    return _guideFactory;
}

- (void)createGameSpreadGuide
{
    
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    
    if (![userdefault objectForKey:@"game_spread_guide"])
    {
        [userdefault setObject:@"1" forKey:@"game_spread_guide"];
        AppDelegate *appDel = SHARED_APP_DELEGATE;
        
        UIView *guideView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        guideView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6f];
        guideView.tag = GUIDEVIEW_TAG;
        [appDel.window addSubview:guideView];
        
        UIImageView *alertImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 304 * kScreenRate, 338 * kScreenRate)];
        alertImgV.image = [UIImage imageNamed:@"instruction_pic02new"];
        alertImgV.center = CGPointMake(CGRectGetWidth(guideView.frame) / 2.0f, CGRectGetHeight(guideView.frame) / 2.0f);
        [guideView addSubview:alertImgV];
        
        UIControl *coverCtrl = [[UIControl alloc] initWithFrame:guideView.bounds];
        coverCtrl.backgroundColor = [UIColor clearColor];
        [coverCtrl addTarget:self action:@selector(removeGameGuide1:) forControlEvents:UIControlEventTouchUpInside];
        [guideView addSubview:coverCtrl];
    }
}

- (void)createSecondGameSpreadGuide
{
    AppDelegate *appDel = SHARED_APP_DELEGATE;
    
    UIView *guideView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    guideView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6f];
    guideView.tag = GUIDEVIEW_TAG;
    guideView.alpha = 0.0f;
    [appDel.window addSubview:guideView];
    
    UIImageView *alertImgV = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 276 * kScreenRate) / 2.0f, 165 * kScreenRate + 100, 276 * kScreenRate, 94 * kScreenRate)];
    alertImgV.image = [UIImage imageNamed:@"instruction_pic03"];
    [guideView addSubview:alertImgV];
    
    UIControl *coverCtrl = [[UIControl alloc] initWithFrame:guideView.bounds];
    coverCtrl.backgroundColor = [UIColor clearColor];
    [coverCtrl addTarget:self action:@selector(removeGameGuide2:) forControlEvents:UIControlEventTouchUpInside];
    [guideView addSubview:coverCtrl];
}

- (void)removeGameGuide1:(id)sender
{
    AppDelegate *appDel = SHARED_APP_DELEGATE;
    UIView *view = [appDel.window viewWithTag:GUIDEVIEW_TAG];
    
    [UIView animateWithDuration:0.5f animations:^{
        
        view.alpha = 0.0f;
        
    } completion:^(BOOL finished) {
        [view removeFromSuperview];
        
        [self createSecondGameSpreadGuide];
        
        AppDelegate *appDel = SHARED_APP_DELEGATE;
        UIView *view = [appDel.window viewWithTag:GUIDEVIEW_TAG];
        
        [UIView animateWithDuration:0.5f animations:^{
            view.alpha = 1.0f;
        }];
        
    }];
}

- (void)removeGameGuide2:(id)sender
{
    AppDelegate *appDel = SHARED_APP_DELEGATE;
    UIView *view = [appDel.window viewWithTag:GUIDEVIEW_TAG];
    
    [UIView animateWithDuration:0.5f animations:^{
        view.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [view removeFromSuperview];
    }];
}

@end






