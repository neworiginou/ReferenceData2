//
//  HWProductDetailModel.m
//  Community
//
//  Created by lizhongqiang on 15/4/23.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWProductDetailModel.h"

@implementation HWProductDetailModel
@synthesize bigImg;
@synthesize createTime;
@synthesize creater;
@synthesize disabled;
@synthesize endTime;
@synthesize Id;
@synthesize increasePrice;
@synthesize joinCount;
@synthesize lowestPrice;
@synthesize marketPrice;
@synthesize modifier;
@synthesize modifyTime;
@synthesize onlineTime;
@synthesize poundage;
@synthesize poundageType;
@synthesize productDescribe;
@synthesize productName;
@synthesize productStatus;
@synthesize remainMs;
@synthesize range;
@synthesize remark;
@synthesize service;
@synthesize shareCount;
@synthesize shareUrl;
@synthesize smallImg;
@synthesize startTime;
@synthesize tax;
//@synthesize version;
//@synthesize winPrice;

- (id)initWithDict:(NSDictionary *)info
{
    if (self = [super init])
    {
        self.bigImg = [info stringObjectForKey:@"bigImg"];
        self.createTime = [info stringObjectForKey:@"createTime"];
        self.creater = [info stringObjectForKey:@"creater"];
        self.disabled = [info stringObjectForKey:@"disabled"];
        self.endTime = [info stringObjectForKey:@"endTime"];
        self.Id = [info stringObjectForKey:@"id"];
        self.increasePrice = [info stringObjectForKey:@"increasePrice"];
        self.joinCount = [info stringObjectForKey:@"joinCount"];
        self.lowestPrice = [info stringObjectForKey:@"lowestPrice"];
        self.marketPrice = [info stringObjectForKey:@"marketPrice"];
        self.modifier = [info stringObjectForKey:@"modifier"];
        self.modifyTime = [info stringObjectForKey:@"modifyTime"];
        self.onlineTime = [info stringObjectForKey:@"onlineTime"];
        self.poundage = [info stringObjectForKey:@"poundage"];
        self.poundageType = [info stringObjectForKey:@"poundageType"];
        self.productDescribe = [info stringObjectForKey:@"productDescribe"];
        self.productName = [info stringObjectForKey:@"productName"];
        self.productStatus = [info stringObjectForKey:@"productStatus"];
        self.remainMs = [info stringObjectForKey:@"remainMS"];
        self.range = [info stringObjectForKey:@"range"];
        self.remark = [info stringObjectForKey:@"remark"];
        self.service = [info stringObjectForKey:@"service"];
        self.shareCount = [info stringObjectForKey:@"shareCount"];
        self.shareUrl = [info stringObjectForKey:@"shareUrl"];
        self.smallImg = [info stringObjectForKey:@"smallImg"];
        self.startTime = [info stringObjectForKey:@"startTime"];
        self.tax = [info stringObjectForKey:@"tax"];
//        self.version = [info stringObjectForKey:@"version"];
//        self.winPrice = [info stringObjectForKey:@"winPrice"];
    }
    return self;
}
@end
