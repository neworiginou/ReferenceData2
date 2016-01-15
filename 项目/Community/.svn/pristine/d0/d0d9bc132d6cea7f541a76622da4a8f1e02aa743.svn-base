//
//  HWProductModel.m
//  Community
//
//  Created by caijingpeng.haowu on 14-12-11.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWProductModel.h"

@implementation HWProductModel

@synthesize productId;
@synthesize productName;
@synthesize productStatus;
@synthesize startTime;
@synthesize endTime;
@synthesize marketPrice;
@synthesize service;
@synthesize poundage;
@synthesize poundageType;
@synthesize joinCount;
@synthesize tax;
@synthesize bigImg;
@synthesize smallImg;
@synthesize lowestPrice;
@synthesize increasePrice;
@synthesize winPrice;
@synthesize remark;
@synthesize source;
@synthesize startTimeStr;
@synthesize endTimeStr;
@synthesize onlyLowestPrice;
@synthesize distanceInSec;
@synthesize showOrderId;
@synthesize showContent;
@synthesize mongodbKey;
@synthesize mobile;
@synthesize showImg;
@synthesize showOrderTime;
@synthesize showOrderTimeStr;
@synthesize userId;

- (id)initWithProductInfo:(NSDictionary *)info
{
    self = [super init];
    if (self)
    {
        self.productId = [info stringObjectForKey:@"id"];
        self.productName = [info stringObjectForKey:@"productName"];
        self.productStatus = [info stringObjectForKey:@"productStatus"];
        self.startTime = [info stringObjectForKey:@"startTime"];
        self.startTimeStr = [info stringObjectForKey:@"startTimeStr"];
        self.endTime = [info stringObjectForKey:@"endTime"];
        self.marketPrice = [info stringObjectForKey:@"marketPrice"];
        
        self.service = [info stringObjectForKey:@"service"];
        self.poundage = [info stringObjectForKey:@"poundage"];
        self.poundageType = [info stringObjectForKey:@"poundageType"];
        self.joinCount = [info stringObjectForKey:@"joinCount"];
        self.tax = [info stringObjectForKey:@"tax"];
        self.bigImg = [info stringObjectForKey:@"bigImg"];
        self.smallImg = [info stringObjectForKey:@"smallImg"];
        self.lowestPrice = [info stringObjectForKey:@"lowestPrice"];
        
        self.increasePrice = [info stringObjectForKey:@"increasePrice"];
        self.winPrice = [info stringObjectForKey:@"winPrice"];
        self.remark = [info stringObjectForKey:@"remark"];
        self.source = [info stringObjectForKey:@"source"];
        self.startTimeStr = [info stringObjectForKey:@"startTimeStr"];
        
        self.endTimeStr = [info stringObjectForKey:@"endTimeStr"];
        self.onlyLowestPrice = [info stringObjectForKey:@"onlyLowestPrice"];
        self.distanceInSec = [info stringObjectForKey:@"distanceInSec"];
        
        self.showOrderId = [info stringObjectForKey:@"showOrderId"];
        self.showContent = [info stringObjectForKey:@"showContent"];
        self.mongodbKey = [info stringObjectForKey:@"mongodbKey"];
        self.mobile = [info stringObjectForKey:@"mobile"];
        self.showImg = [info stringObjectForKey:@"showImg"];
        
        self.showOrderTime = [info stringObjectForKey:@"showOrderTime"];
        self.showOrderTimeStr = [info stringObjectForKey:@"showOrderTimeStr"];
        self.userId = [info stringObjectForKey:@"userId"];
    }
    return self;
}

@end
