//
//  HWRentsData.m
//  Community
//
//  Created by lizhongqiang on 14-9-11.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWRentsData.h"

@implementation HWRentsData
@synthesize strAddress;
@synthesize strArea;
@synthesize strHuXing;
@synthesize strIntention;
@synthesize strName;
@synthesize strPhone;
@synthesize buildNo;
@synthesize roomNo;

+(HWRentsData *)getRentsData
{
    static HWRentsData *shareRentsData = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareRentsData = [[self alloc] init];
    });
    return shareRentsData;
}

@end
