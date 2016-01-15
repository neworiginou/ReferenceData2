//
//  HWServiceListPaySuccessViewController.h
//  Community
//
//  Created by hw500027 on 15/6/25.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseViewController.h"

typedef NS_ENUM(NSInteger, pushPaySuccessType) {
    pushPaySuccessTypeList = 0,             //从列表直接点支付进人 pop时回到列表
    pushPaySuccessTypeDetail,               //从详情直接点支付进人 pop时回到详情
    pushPaySuccessTypeWY,                   //从物业或首页或更多提交订单，并支付，pop到上门服务前一页
};


@interface HWServiceListPaySuccessViewController : HWBaseViewController

@property (nonatomic , strong) NSString *orderId;

@property (nonatomic, assign) pushPaySuccessType pushType;



@end
