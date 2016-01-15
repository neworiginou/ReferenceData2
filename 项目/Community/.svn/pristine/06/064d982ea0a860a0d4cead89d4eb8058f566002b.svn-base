//
//  HWDetailOrderModel.m
//  Community
//
//  Created by caijingpeng.haowu on 14-12-17.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWDetailOrderModel.h"

@implementation HWDetailOrderModel

@synthesize modelId;
@synthesize productId;
@synthesize address;
@synthesize sendStatus;
@synthesize orderStatus;
@synthesize orderAmount;
@synthesize tax;
@synthesize winPrice;
@synthesize cutUserId;
@synthesize mobile;
@synthesize name;
@synthesize orderId;
@synthesize createTimeStr;

- (id)initWithDetailOrder:(NSDictionary *)info
{
    self = [super init];
    if (self)
    {
        self.modelId = [info stringObjectForKey:@"modelId"];
        self.productId = [info stringObjectForKey:@"productId"];
        self.address = [info stringObjectForKey:@"address"];
        self.sendStatus = [info stringObjectForKey:@"sendStatus"];
        self.orderStatus = [info stringObjectForKey:@"orderStatus"];
        self.orderAmount = [info stringObjectForKey:@"orderAmount"];
        self.tax = [info stringObjectForKey:@"tax"];
        self.winPrice = [info stringObjectForKey:@"winPrice"];
        self.cutUserId = [info stringObjectForKey:@"cutUserId"];
        self.mobile = [info stringObjectForKey:@"mobile"];
        self.name = [info stringObjectForKey:@"name"];
        self.orderId = [info stringObjectForKey:@"orderId"];
        self.createTimeStr = [info stringObjectForKey:@"createTimeStr"];
    }
    return self;
}

@end
