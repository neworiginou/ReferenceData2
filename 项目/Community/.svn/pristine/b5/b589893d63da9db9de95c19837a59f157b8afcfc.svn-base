//
//  HWFuLiSheView.h
//  Community
//
//  Created by wuxiaohong on 15/1/15.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//  功能描述：福利社首页 View
//

#import "HWBaseRefreshView.h"
#import "HWGameSpreadVC.h"
#import "HWShareViewController.h"
#import "HWFulLiSheTableViewCell.h"
#import "HWActivityModel.h"
#import "HWDiscountViewController.h"


@protocol HWFuLiSheViewDelegate <NSObject>

@optional
- (void)cellSelectedPushVC:(UIViewController *)vc;
- (void)didSelectBanner:(HWActivityModel *)activity;

@end

@interface HWFuLiSheView : HWBaseRefreshView <UIScrollViewDelegate>
{
    NSArray *_titleArr;
    NSArray *_subTitleArr;
    NSArray *_imgArr;
    UIPageControl *_pageCtr;
}

@property (nonatomic, weak) id<HWFuLiSheViewDelegate> delegate;


@end
