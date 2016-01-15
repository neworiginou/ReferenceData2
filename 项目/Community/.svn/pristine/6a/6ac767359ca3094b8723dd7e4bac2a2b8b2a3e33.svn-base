//
//  HWCutPriceModel.m
//  Community
//
//  Created by lizhongqiang on 15/4/20.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWCutPriceModel.h"

@implementation HWCutPriceModel
@synthesize createTime;
@synthesize cutPrice;
@synthesize isLowest;
@synthesize productId;
@synthesize samePriceTimes;
@synthesize uniqueLowerTimes;

- (id)initWithDict:(NSDictionary *)info
{
    self = [super init];
    if (self) {
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
