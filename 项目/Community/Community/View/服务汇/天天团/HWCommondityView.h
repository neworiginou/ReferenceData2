//
//  HWCommondityView.h
//  Community
//
//  Created by ryder on 7/29/15.
//  Copyright (c) 2015 caijingpeng. All rights reserved.
//

#import "HWOrderSuccessView.h"
#import "HWCommondityModel.h"

typedef NS_ENUM(NSInteger, HWCommondityStatus) //(0即将开始,1进行中,2已售完，3已下架，4未知状态)
{
    HWCommondityStatusWillStarting,
    HWCommondityStatusSelling,
    HWCommondityStatusSellOut,
    HWCommondityStatusOff,
    HWCommondityStatusNone,
};

@protocol HWCommondityViewDelegate <NSObject>

- (void)timerEndAction;

- (void)showGoodsDetailWithModel:(HWCommondityModel *)model;

@end

@interface HWCommondityView : UIView

@property (nonatomic, assign) id<HWCommodityDelegate> delegate;
@property (nonatomic, weak) id<HWCommondityViewDelegate> rdelegate;
@property (nonatomic, strong) HWCommondityModel *model;

- (void)invalidaTimer;

- (instancetype)initWithFrame:(CGRect)frame model:(HWCommondityModel *)model;

@end
