//
//  HWPayConfirmView.h
//  Community
//
//  Created by niedi on 15/6/24.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseRefreshView.h"

typedef NS_ENUM(NSInteger, HWPayConfirmType) {
    HWPayConfirmTypeWeYeForWyPush = 0,                  //物业缴费
    
    
    HWPayConfirmTypeHomeServiceForList,                 //从上门服务列表进入收银台
    HWPayConfirmTypeHomeServiceForDetail,               //从上门服务详情进入收银台
    HWPayConfirmTypeHomeServiceForWy,                   //从物业或更多 进入订单详情然后支付 pop到详情
};


@protocol HWPayConfirmViewDelegate <NSObject>

@optional
- (void)pushViewController:(UIViewController *)vc;
- (void)popToWuYeFeeVC;

@end


@interface HWPayConfirmView : HWBaseRefreshView

@property (nonatomic , strong) id <HWPayConfirmViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame model:(id)model type:(HWPayConfirmType)type;


@end
