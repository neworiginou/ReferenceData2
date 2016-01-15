//
//  HWTianTianTuanDetailView.h
//  Community
//
//  Created by niedi on 15/7/31.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseRefreshView.h"

@protocol HWTianTianTuanDetailViewDelegate <NSObject>

@optional
- (void)showCancleOrderBtn:(BOOL)isShow;

- (void)pushToTianTianTuanGoodsDetail:(NSString *)goodsId;

- (void)pushToPayConfirmVC:(NSString *)orderId;

- (void)refreshList;

- (void)timerEndPopToListVC;

@end

@interface HWTianTianTuanDetailView : HWBaseRefreshView

@property (nonatomic, weak) id<HWTianTianTuanDetailViewDelegate> delegate;

- (void)invalidaTimer;

- (instancetype)initWithFrame:(CGRect)frame orderId:(NSString *)orderId;

@end
