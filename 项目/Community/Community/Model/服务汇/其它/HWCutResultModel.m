//
//  HWCutResultModel.m
//  Community
//
//  Created by lizhongqiang on 15/4/28.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWCutResultModel.h"

@implementation HWCutResultModel
@synthesize award;
@synthesize bonus;
@synthesize createTime;
@synthesize cutPrice;
@synthesize isLowest;
@synthesize kaoLabonus;
@synthesize productId;
@synthesize samePriceTimes;
@synthesize uniqueLowerTimes;

- (id)initWithDict:(NSDictionary *)info
{
    self = [super init];
    if (self) {
        self.award = [info stringObjectForKey:@"award"];
        self.bonus = [info stringObjectForKey:@"bonus"];
        self.createTime = [info stringObjectForKey:@"createTime"];
        self.cutPrice = [info stringObjectForKey:@"cutPrice"];
        self.isLowest = [info stringObjectForKey:@"isLowest"];
        self.kaoLabonus = [info stringObjectForKey:@"kaoLabonus"];
        self.productId = [info stringObjectForKey:@"productId"];
        self.samePriceTimes = [info stringObjectForKey:@"samePriceTimes"];
        self.uniqueLowerTimes = [info stringObjectForKey:@"uniqueLowerTimes"];
    }
    return self;
}

@end
