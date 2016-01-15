//
//  HWCommondityDetailView.h
//  Community
//
//  Created by ryder on 7/30/15.
//  Copyright (c) 2015 caijingpeng. All rights reserved.
//

#import "HWBaseRefreshView.h"
#import "HWCommondityView.h"
#import "HWCommondityDetailModel.h"

typedef NS_ENUM(NSInteger, HWCommonditySaleStatus)  //(0即将开始,1进行中,2已售完，3已下架，4未知状态)
{
    HWCommonditySaleStatusWillStarting = 0,      // 即将开始
    HWCommonditySaleStatusPurchase,           //进行中
    HWCommonditySaleStatusSellOut,           // 已售完
    HWCommonditySaleStatusOff,           // 已下架
    HWCommonditySaleStatusUnKonwn       //未知状态
};

@protocol HWCommodityDetailViewDelegate <NSObject>

- (void)pushToVC:(UIViewController *)vc;

- (void)showShareBtn:(BOOL)isShow;

@end

@interface HWCommondityDetailView : HWBaseRefreshView<HWCommodityDelegate>

@property (nonatomic, assign) HWCommonditySaleStatus status;
@property (nonatomic,assign)  id<HWCommodityDelegate> delegate;
@property (nonatomic, weak) id<HWCommodityDetailViewDelegate> rDelegate;
@property (nonatomic, strong) HWCommondityDetailModel *detailModel;
@property (nonatomic, strong) UIImageView *shareImg;
@property (nonatomic, weak) UIViewController *superVC;

- (instancetype)initWithFrame:(CGRect)frame goodsId:(NSString *)goodsId;


@end
