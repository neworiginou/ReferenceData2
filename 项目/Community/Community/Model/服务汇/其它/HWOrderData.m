//
//  HWOrderData.m
//  Community
//
//  Created by lizhongqiang on 14-9-14.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWOrderData.h"

@implementation HWOrderData

@synthesize serviceType;
@synthesize time;
//@synthesize roomNo;
//@synthesize buildingNo;
@synthesize address;

+ (HWOrderData *)getOrderData
{
    static HWOrderData *shareOrderData = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareOrderData = [[self alloc] init];
    });
    return shareOrderData;
}

@end
