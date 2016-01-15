//
//  HWShowOrderModel.m
//  Community
//
//  Created by caijingpeng.haowu on 14-12-16.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWShowOrderModel.h"

@implementation HWShowOrderModel

@synthesize address;
@synthesize mobile;
@synthesize name;
@synthesize createTime;
@synthesize orderId;
@synthesize showOrderId;
@synthesize mongodbKey;
@synthesize showContent;
@synthesize createTimeStr;

- (id)initWithShowOrder:(NSDictionary *)info
{
    self = [super init];
    if (self)
    {
        self.address = [info stringObjectForKey:@"address"];
        self.mobile = [info stringObjectForKey:@"mobile"];
        self.name = [info stringObjectForKey:@"name"];
        self.createTime = [info stringObjectForKey:@"createTime"];
        self.orderId = [info stringObjectForKey:@"orderId"];
        self.showOrderId = [info stringObjectForKey:@"showOrderId"];
        self.mongodbKey = [info stringObjectForKey:@"mongodbKey"];
        self.showContent = [info stringObjectForKey:@"showContent"];
        self.createTimeStr = [info stringObjectForKey:@"createTimeStr"];
    }
    return self;
}

@end
