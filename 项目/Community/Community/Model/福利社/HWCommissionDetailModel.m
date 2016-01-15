//
//  HWCommissionDetailModel.m
//  Community
//
//  Created by niedi on 15/1/17.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWCommissionDetailModel.h"

@implementation HWCommissionDetailModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [self init])
    {
        self.commissionDayCountKLB = [dict stringObjectForKey:@"commissionDayCountKLB"];
        self.commissionDayCountRMB = [dict stringObjectForKey:@"commissionDayCountRMB"];
        self.dealDay = [dict stringObjectForKey:@"dealDay"];
        
        NSArray *dictArr = [dict arrayObjectForKey:@"gameAmountDetailDtoList"];
        NSMutableArray *tmpArr = [NSMutableArray array];
        for (NSDictionary *tmpDict in dictArr)
        {
            HWCommissionDetailSubModel *subModel = [[HWCommissionDetailSubModel alloc] initWithDict:tmpDict];
            [tmpArr addObject:subModel];
        }
        self.gameAmountDetailDtoArray = [NSArray arrayWithArray:tmpArr];
    }
    return self;
}


@end


@implementation HWCommissionDetailSubModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        self.commissionAmountKLB = [dict stringObjectForKey:@"commissionAmountKLB"];
        self.commissionAmountRMB = [dict stringObjectForKey:@"commissionAmountRMB"];
        self.dealTime = [dict stringObjectForKey:@"dealTime"];
        self.eventType = [dict stringObjectForKey:@"eventType"];
        self.proportion = [dict stringObjectForKey:@"proportion"];
    }
    return self;
}

@end