//
//  HWRecommendView.h
//  Community
//
//  Created by niedi on 15/4/14.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseRefreshView.h"
#import "WXImageView.h"
#import "HWRecommendChannelCell.h"
#import "HWCoreDataManager.h"
#import "HWMoreRecommendVC.h"
#import "HWNeighbourBannerModel.h"

@class HWRecommendView;

@protocol HWRecommendViewDelegate <NSObject>

@optional
- (void)pushVC:(HWBaseViewController *)vc;
- (void)recommendView:(HWRecommendView *)neighbourView pushVC:(HWChannelModel *)model;
- (void)tableViewHeaderPictureClick:(HWNeighbourBannerModel *)model;
@end


@interface HWRecommendView : HWBaseRefreshView<UIScrollViewDelegate>
{
    NSTimer *_timer;
    UIPageControl *_pageCtr;
}

@property (nonatomic, weak) id<HWRecommendViewDelegate> delegate;
@property (nonatomic, strong) NSArray *colorArr;
@property (nonatomic, strong) NSArray *passVillageIdArr;
@property (nonatomic, strong) NSString *villageTalkCount;
@property (nonatomic, strong) NSString *cityTalkCount;
@property (nonatomic, strong) NSArray *bannerModelArr;

//刷新数据
- (void)refreshList;

@end
