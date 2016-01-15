//
//  HWDetailOrderModel.h
//  Community
//
//  Created by caijingpeng.haowu on 14-12-17.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//
//  订单详情 中 返回的订单信息 数据模型
//

#import <Foundation/Foundation.h>

@interface HWDetailOrderModel : NSObject

@property (nonatomic, strong) NSString *modelId;
@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *sendStatus;
@property (nonatomic, strong) NSString *orderStatus;
@property (nonatomic, strong) NSString *orderAmount;
@property (nonatomic, strong) NSString *tax;
@property (nonatomic, strong) NSString *winPrice;
@property (nonatomic, strong) NSString *cutUserId;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, strong) NSString *createTimeStr;

- (id)initWithDetailOrder:(NSDictionary *)info;

@end
