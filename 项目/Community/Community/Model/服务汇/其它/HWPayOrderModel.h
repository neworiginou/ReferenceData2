//
//  HWPayOrderModel.h
//  Community
//
//  Created by caijingpeng.haowu on 14-12-13.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWPayOrderModel : NSObject

@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, strong) NSString *orderNo;
@property (nonatomic, strong) NSString *orderType;
@property (nonatomic, strong) NSString *orderAmount;
@property (nonatomic, strong) NSString *orderStatus;
@property (nonatomic, strong) NSString *orderUser;
@property (nonatomic, strong) NSString *orderTime;
@property (nonatomic, strong) NSString *paymentWay;
@property (nonatomic, strong) NSString *paymentNo;
@property (nonatomic, strong) NSString *paymentTime;
@property (nonatomic, strong) NSString *mobileNumber;
@property (nonatomic, strong) NSString *creater;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *modifier;
@property (nonatomic, strong) NSString *modifyTime;
@property (nonatomic, strong) NSString *version;
@property (nonatomic, strong) NSString *disabled;

- (id)initWithPayOrder:(NSDictionary *)info;

@end
