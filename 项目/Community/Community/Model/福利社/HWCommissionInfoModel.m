//
//  HWCommissionInfoModel.m
//  Community
//
//  Created by niedi on 15/1/20.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWCommissionInfoModel.h"

@implementation HWCommissionInfoModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        self.commissionCountKLB = [dict stringObjectForKey:@"commissionCountKLB"];
        self.commissionCountRMB = [dict stringObjectForKey:@"commissionCountRMB"];
        self.activateCount = [dict stringObjectForKey:@"activateCount"];
        self.consumeAmount = [dict stringObjectForKey:@"consumeAmount"];
    }
    return self;
}

@end
