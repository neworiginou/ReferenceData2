//
//  HWPropertyServiceClass.m
//  Community
//
//  Created by lizhongqiang on 14-9-23.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWPropertyServiceClass.h"

@implementation HWPropertyServiceClass
@synthesize isServiceOpen;
@synthesize serviceId;
@synthesize serviceName;

- (id)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super init])
    {
        self.isServiceOpen = [dic stringObjectForKey:@"isServiceOpen"];
        self.serviceId = [dic stringObjectForKey:@"serviceId"];
        self.serviceName = [dic stringObjectForKey:@"serviceName"];
    }
    
    return self;
}
@end
