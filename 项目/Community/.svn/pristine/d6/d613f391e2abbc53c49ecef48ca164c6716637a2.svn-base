//
//  HWPayOrderModel.m
//  Community
//
//  Created by caijingpeng.haowu on 14-12-13.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWPayOrderModel.h"

@implementation HWPayOrderModel

@synthesize orderId;
@synthesize orderNo;
@synthesize orderType;
@synthesize orderAmount;
@synthesize orderStatus;
@synthesize orderUser;
@synthesize orderTime;
@synthesize paymentWay;
@synthesize paymentNo;
@synthesize paymentTime;
@synthesize mobileNumber;
@synthesize creater;
@synthesize createTime;
@synthesize modifier;
@synthesize modifyTime;
@synthesize version;
@synthesize disabled;

- (id)initWithPayOrder:(NSDictionary *)info
{
    self = [super init];
    if (self)
    {
        self.orderId = [info stringObjectForKey:@"orderId"];
        self.orderNo = [info stringObjectForKey:@"orderNo"];
        self.orderType = [info stringObjectForKey:@"orderType"];
        self.orderAmount = [info stringObjectForKey:@"orderAmount"];
        self.orderStatus = [info stringObjectForKey:@"orderStatus"];
        self.orderUser = [info stringObjectForKey:@"orderUser"];
        self.orderTime = [info stringObjectForKey:@"orderTime"];
        self.paymentWay = [info stringObjectForKey:@"paymentWay"];
        self.paymentNo = [info stringObjectForKey:@"paymentNo"];
        self.paymentTime = [info stringObjectForKey:@"paymentTime"];
        self.mobileNumber = [info stringObjectForKey:@"mobileNumber"];
        self.creater = [info stringObjectForKey:@"creater"];
        self.createTime = [info stringObjectForKey:@"createTime"];
        self.modifier = [info stringObjectForKey:@"modifier"];
        self.modifyTime = [info stringObjectForKey:@"modifyTime"];
        self.version = [info stringObjectForKey:@"version"];
        self.disabled = [info stringObjectForKey:@"disabled"];
    }
    return self;
}

@end
