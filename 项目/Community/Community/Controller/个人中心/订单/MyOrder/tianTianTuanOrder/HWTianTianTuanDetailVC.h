//
//  HWTianTianTuanDetailVC.h
//  Community
//
//  Created by niedi on 15/7/31.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseViewController.h"

typedef NS_ENUM(NSInteger, ttTOrderDetailPopType)
{
    ttTOrderDetailPopTypeOneVC = 0,
    ttTOrderDetailPopType1
};

@protocol HWTianTianTuanDetailVCDelegate <NSObject>

- (void)cancleOrderReQueryList;

@end

@interface HWTianTianTuanDetailVC : HWBaseViewController

@property (nonatomic, weak) id<HWTianTianTuanDetailVCDelegate> delegate;

@property (nonatomic, strong) NSString *orderId;

@property (nonatomic, assign) ttTOrderDetailPopType popType;

@end
