//
//  HWTianTianTuanListView.h
//  Community
//
//  Created by niedi on 15/7/31.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseRefreshView.h"

@protocol HWTianTianTuanListViewDelegate <NSObject>

- (void)pushToOrderDetail:(NSString *)orderId;

- (void)pushToPayConfirmVC:(NSString *)orderId;

@end

@interface HWTianTianTuanListView : HWBaseRefreshView

@property (nonatomic, weak) id<HWTianTianTuanListViewDelegate> delegate;

- (void)requeryData;

@end
