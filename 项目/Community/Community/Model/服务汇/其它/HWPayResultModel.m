//
//  HWPayResultModel.m
//  Community
//
//  Created by caijingpeng.haowu on 14-12-15.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWPayResultModel.h"

@implementation HWPayResultModel

@synthesize createTime;
@synthesize cutPrice;
@synthesize isLowest;
@synthesize productId;
@synthesize samePriceTimes;
@synthesize uniqueLowerTimes;

- (id)initWithPayResult:(NSDictionary *)info
{
    self = [super init];
    if (self)
    {
        self.createTime = [info stringObjectForKey:@"createTime"];
        self.cutPrice = [info stringObjectForKey:@"cutPrice"];
        self.isLowest = [info stringObjectForKey:@"isLowest"];
        self.productId = [info stringObjectForKey:@"productId"];
        self.samePriceTimes = [info stringObjectForKey:@"samePriceTimes"];
        self.uniqueLowerTimes = [info stringObjectForKey:@"uniqueLowerTimes"];
    }
    return self;
}

@end
