//
//  HWServiceData.m
//  Community
//
//  Created by lizhongqiang on 14-9-23.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWServiceData.h"

@implementation HWServiceData

@synthesize isFirstPerfect;
@synthesize arrServiceBase;

- (id)init
{
    if (self = [super init])
    {
        self.arrServiceBase = [[NSMutableArray alloc] init];
    }
    return self;
}

+ (HWServiceData *)getServiceData
{
    static HWServiceData *shareOrderData = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareOrderData = [[self alloc] init];
    });
    return shareOrderData;
}

@end
