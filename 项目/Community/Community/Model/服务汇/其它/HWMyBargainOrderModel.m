//
//  HWMyBargainOrderModel.m
//  Community
//
//  Created by D on 14/12/14.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWMyBargainOrderModel.h"

@implementation HWMyBargainOrderModel
@synthesize sendStatus;
@synthesize bigImg;
@synthesize smallImg;
@synthesize productName;
@synthesize marketPrice;
@synthesize orderAmount;
@synthesize winPrice;
@synthesize orderIdStr;
@synthesize addressStr;
@synthesize userNameStr;
@synthesize phoneStr;
@synthesize cutAddressIdStr;
@synthesize cutUserIdStr;
@synthesize payMoney;
@synthesize orderStatus;
@synthesize orderNum;
//add by gusheng
/*
 cutAddressId 地址id
 cutUserId 砍价用户id
 orderId 砍价订单id
 address 邮寄地址
 userName 收件人
 phone 电话号码
 */
- (id)initWithBargainOrderDic:(NSDictionary *)dict {
    self = [super init];
    if (self)
    {
        self.sendStatus = [dict stringObjectForKey:@"sendStatus"];
        self.bigImg = [dict stringObjectForKey:@"bigImg"];
        self.smallImg = [dict stringObjectForKey:@"smallImg"];
        self.productName = [dict stringObjectForKey:@"productName"];
        self.marketPrice = [dict stringObjectForKey:@"marketPrice"];
        self.orderAmount = @"1";
        self.orderStatus = [dict stringObjectForKey:@"orderStatus"];
        self.winPrice = [dict stringObjectForKey:@"winPrice"];
        self.payMoney = [dict stringObjectForKey:@"orderAmount"];
        self.cutAddressIdStr = [dict stringObjectForKey:@"addressId"];
        self.cutUserIdStr = [dict stringObjectForKey:@"cutUserId"];
        self.orderIdStr = [dict stringObjectForKey:@"id"];
        self.addressStr = [dict stringObjectForKey:@"address"];
        self.userNameStr = [dict stringObjectForKey:@"name"];
        self.phoneStr = [dict stringObjectForKey:@"mobile"];
        self.addressDto = [dict objectForKey:@"addressDto"];
        self.orderNum = [dict stringObjectForKey:@"orderId"];
    }
    return self;
}

@end
