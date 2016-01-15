//
//  HWDiscountRefreshView.h
//  Community
//
//  Created by caijingpeng.haowu on 15/1/17.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseRefreshView.h"
#import "HWPriviledgeTableViewCell.h"
#import "HWPriviledgeModel.h"

@protocol HWDiscountRefreshViewDelegate <NSObject>

- (void)didSelectDirectGetPriviledge:(HWPriviledgeModel *)priviledge;
- (void)didSelectPriviledgeDetail:(HWPriviledgeModel *)priviledge activeTime:(int)aTime;

@end

@interface HWDiscountRefreshView : HWBaseRefreshView <HWPriviledgeTableViewCellDelegate>
{
    //优惠劵活动倒计时
    int priviledgeActivityTime;
    int maxColdTime;
    //优惠劵定时器
    NSTimer *priviledgeTimer;
}

@property (nonatomic, assign) id<HWDiscountRefreshViewDelegate> delegate;

- (void)refreshPriviledgeType:(NSString *)model;

@end
