//
//  HWServiceListDetailModel.m
//  Community
//
//  Created by hw500027 on 15/6/23.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWServiceListDetailModel.h"

@implementation HWServiceListDetailModel

- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if(self)
    {
        _orderId = [dic stringObjectForKey:@"orderId"];
        _founder = [dic stringObjectForKey:@"founder"];
        _receiver = [dic stringObjectForKey:@"receiver"];
        _serviceName = [dic stringObjectForKey:@"serviceName"];
        _serviceIcon = [dic stringObjectForKey:@"serviceIcon"];
        _status = [dic stringObjectForKey:@"status"];
        _serviceTime = [self translateServiceTime:[dic stringObjectForKey:@"serviceTime"]];
        _serviceTimeSection = [self translateServiceTimeSection:[dic stringObjectForKey:@"serviceTimeSection"]];
        _payTime = [dic stringObjectForKey:@"payTime"];
        _charge = [dic stringObjectForKey:@"charge"];
        _token = [dic stringObjectForKey:@"token"];
        _bcOrderId = [dic stringObjectForKey:@"bcOrderId"];
        _serviceAddress = [dic stringObjectForKey:@"serviceAddress"];
        _mobileNumber = [dic stringObjectForKey:@"mobileNumber"];
        _payNum = [dic stringObjectForKey:@"payNum"];
        _ownerVo = [dic dictionaryObjectForKey:@"ownerVo"];
        _servePersonVo = [dic dictionaryObjectForKey:@"servePersonVo"];
        _statusList = [dic arrayObjectForKey:@"statusList"];
    }
    return self;
}

- (NSString *)translateServiceTime:(NSString *)time
{
    return [Utility getTimeWithTimestamp:time];
}

- (NSString *)translateServiceTimeSection:(NSString *)time
{
    if (time.length == 0)
    {
        return @"";
    }
    else
    {
        //  服务时间段//(0全天,1,上午,2下午,3晚上)
        NSArray *timeSection = @[@"全天",@"上午",@"下午",@"晚上"];
        return [timeSection pObjectAtIndex:[time integerValue]];
    }
}
@end
