//
//  HWGameDetailView.h
//  Community
//
//  Created by niedi on 15/1/20.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseRefreshView.h"
#import "HWGameDetailModel.h"
#import "HWCommissionDetailView.h"

#import "HWCustomSegmentControl.h"
#import "WXImageView.h"

@protocol HWGameDetailViewDelegate <NSObject>

@optional
- (void)setNavTitleView:(NSString *)titleStr;
- (void)pushToShareVC:(HWGameDetailModel *)model;

@end

@interface HWGameDetailView : HWBaseRefreshView <HWCustomSegmentControlDelegate>
{
    
//    UIScrollView *_tableViewHeaderView;                   //总的View
    
    //segment及其以上的ui
    UIImageView *_headImageV;                   //游戏图标
    UILabel *_gameCommissionTitleLab;           //游戏推广头标题
    UILabel *_gameCommissionSubTLab;            //游戏推广副标题
    UILabel *_gameComissionEndDateLab;          //游戏推广结束日期标题
    HWCustomSegmentControl *_segmentControl;    //segmentControl
    UIView *_segmentAndUpView;                  //segment及以上的view
    
    
    //游戏详情下的segmet 之下的UI
    UILabel *_gameDetailLab;                    //游戏描述详情
    UIScrollView *_imgScrollView;               //图片墙
    UIScrollView *_belowSegmentViewForGameDetail;     //游戏详情的segment以下的view
    
    HWCommissionDetailView *_belowSegmentViewForCommission;     //佣金明细的segment以下view
    
    //推广按钮
    UIButton *_spreadBtn;
}

@property (nonatomic, strong) NSString *gameId;
@property (nonatomic, weak) id<HWGameDetailViewDelegate> delegate;
@property (nonatomic, strong) HWGameDetailModel *gameDetailModel;
@property (nonatomic, strong) HWCustomSegmentControl *segmentControl;

- (instancetype)initWithFrame:(CGRect)frame andGameId:(NSString *)gameId;
- (void)segmentControl:(HWCustomSegmentControl *)sControl didSelectSegmentIndex:(int)index;

@end
