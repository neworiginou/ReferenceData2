//
//  HWServiceListModel.m
//  Community
//
//  Created by hw500027 on 15/6/18.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWServiceListModel.h"

@implementation HWServiceListModel
- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self)
    {
        _orderId = [dic stringObjectForKey:@"orderId"];
        _serviceName = [dic stringObjectForKey:@"serviceName"];
        _serviceIcon = [dic stringObjectForKey:@"serviceIcon"];
        _status = [dic stringObjectForKey:@"status"];
        _serviceTime = [self translateTime:[dic stringObjectForKey:@"serviceTime"]];
        _serviceTimeSection = [self translateServiceTimeSection:[dic stringObjectForKey:@"serviceTimeSection"]];
        _payTime = [self translateTime:[dic stringObjectForKey:@"payTime"]];
    }
    return self;
}

- (NSString *)translateTime:(NSString *)time
{
    return [Utility getTimeWithTimestamp:time];
}

- (NSString *)translateServiceTimeSection:(NSString *)str
{
    if ([str isEqual:@"0"])
    {
        return @"全天";
    }
    else if ([str isEqual:@"1"])
    {
        return @"上午";
    }
    else if ([str isEqual:@"2"])
    {
        return @"下午";
    }
    else
    {
        return @"晚上";
    }
}

@end
