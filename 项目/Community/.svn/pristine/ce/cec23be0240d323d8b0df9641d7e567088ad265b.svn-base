//
//  HWShopTypeClass.m
//  Community
//
//  Created by lizhongqiang on 14-9-11.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWShopTypeClass.h"

@implementation HWShopTypeClass
@synthesize serviceIcon;
@synthesize serviceId;
@synthesize serviceName;

-(id)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super init])
    {
        self.serviceId = [dic stringObjectForKey:@"serviceId"];
        self.serviceName = [dic stringObjectForKey:@"serviceName"];
        self.serviceIcon = [dic stringObjectForKey:@"serviceIcon"];
    }
    return self;
}
@end
