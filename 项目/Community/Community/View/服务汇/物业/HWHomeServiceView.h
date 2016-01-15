//
//  HWHomeServiceView.h
//  Community
//
//  Created by niedi on 15/6/15.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseRefreshView.h"

@protocol HWHomeServiceViewDelegate <NSObject>

- (void)bookingOrderBtnClick;

@end


@interface HWHomeServiceView : HWBaseRefreshView

@property (nonatomic, strong) id<HWHomeServiceViewDelegate> delegate;


- (instancetype)initWithFrame:(CGRect)frame serviceId:(NSString *)serviceId;

@end
