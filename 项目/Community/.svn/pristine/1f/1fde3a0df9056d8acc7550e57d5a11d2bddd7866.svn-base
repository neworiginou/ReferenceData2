//
//  HWJoinedActivityModel.m
//  Community
//
//  Created by caijingpeng.haowu on 14-12-11.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWJoinedActivityModel.h"

@implementation HWJoinedActivityModel

@synthesize joinedId;
@synthesize productId;
@synthesize cutPrice;
@synthesize cutUserId;
@synthesize poundage;
@synthesize source;
@synthesize winUserId;
@synthesize productStatus;
@synthesize guessCount;
@synthesize productName;
@synthesize cutTime;
@synthesize samePriceCount;
@synthesize isLowest;
@synthesize lessPriceCount;
@synthesize startTimeStr;
@synthesize bigImg;
@synthesize smallImg;
@synthesize startTime;
@synthesize cutTimeStr;
@synthesize marketPrice;
@synthesize orderStatus;
@synthesize tax;
@synthesize remark;
@synthesize service;

- (id)initWithJoinedActivity:(NSDictionary *)info
{
    self = [super init];
    if (self)
    {
        self.joinedId = [info stringObjectForKey:@"joinedId"];
        self.productId = [info stringObjectForKey:@"productId"];
        
        self.cutPrice = [info stringObjectForKey:@"cutPrice"];
        self.cutUserId = [info stringObjectForKey:@"cutUserId"];
        self.poundage = [info stringObjectForKey:@"poundage"];
        self.source = [info stringObjectForKey:@"source"];
        self.winUserId = [info stringObjectForKey:@"winUserId"];
        self.productStatus = [info stringObjectForKey:@"productStatus"];
        
        self.productName = [info stringObjectForKey:@"productName"];
        self.cutTime = [info stringObjectForKey:@"cutTime"];
        self.samePriceCount = [info stringObjectForKey:@"samePriceCount"];
        self.isLowest = [info stringObjectForKey:@"isLowest"];
        self.lessPriceCount = [info stringObjectForKey:@"lessPriceCount"];
        self.guessCount = [info stringObjectForKey:@"guessCount"];
        self.startTimeStr = [info stringObjectForKey:@"startTimeStr"];
        self.bigImg = [info stringObjectForKey:@"bigImg"];
        self.smallImg = [info stringObjectForKey:@"smallImg"];
        self.startTime = [info stringObjectForKey:@"startTime"];
        
        self.cutTimeStr = [info stringObjectForKey:@"cutTimeStr"];
        self.marketPrice = [info stringObjectForKey:@"marketPrice"];
        self.orderStatus = [info stringObjectForKey:@"orderStatus"];
        self.tax = [info stringObjectForKey:@"tax"];
        
        self.remark = [info stringObjectForKey:@"remark"];
        self.service = [info stringObjectForKey:@"service"];
    }
    return self;
}

@end
