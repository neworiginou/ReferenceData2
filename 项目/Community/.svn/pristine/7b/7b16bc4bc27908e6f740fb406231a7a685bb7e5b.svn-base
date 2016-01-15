//
//  HWActivityHistoryModel.m
//  Community
//
//  Created by caijingpeng.haowu on 14-12-11.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWActivityHistoryModel.h"

@implementation HWActivityHistoryModel

@synthesize remark;
@synthesize createTime;
@synthesize tax;
@synthesize source;
@synthesize creater;
@synthesize winPrice;
@synthesize joinCount;
@synthesize lowestPrice;
@synthesize modifier;
@synthesize service;
@synthesize productName;
@synthesize version;
@synthesize poundageType;
@synthesize startTime;
@synthesize userId;
@synthesize modifyTime;
@synthesize startTimeStr;
@synthesize historyId;
@synthesize productStatus;
@synthesize increasePrice;
@synthesize poundage;
@synthesize marketPrice;
@synthesize onlyLowestPrice;
@synthesize smallImg;
@synthesize bigImg;
@synthesize endTime;
@synthesize disabled;
@synthesize showHeadImg;
/**
 distanceInSec = "<null>";
 id = 2099792;
 mobile = 13000000001;
 mongodbKey = 548aea14e4b0b979fa2f7edf;
 showContent = "\U6211\U4e2d\U5956\U4e86\Uff0c\U5feb\U6765\U606d\U559c\U6211\U5427\Uff01";
 showImg = "file/downloadByKey.do?mKey=548aea14e4b0b979fa2f7edf";
 showOrderId = 2100300;

 *
 */
- (id)initWithHistoryInfo:(NSDictionary *)info
{
    self = [super init];
    if (self)
    {
        self.distanceInSec = [info stringObjectForKey:@"distanceInSec"];
        self.Id = [info stringObjectForKey:@"id"];
        self.mobile = [info stringObjectForKey:@"mobile"];
        self.showContent = [info stringObjectForKey:@"showContent"];
        self.showImg = [info stringObjectForKey:@"showImg"];
        self.showOrderId = [info stringObjectForKey:@"showOrderId"];
        self.showOrderTime = [info stringObjectForKey:@"showOrderTime"];
        self.showHeadImg = [info stringObjectForKey:@"showHeadImg"];
        
        self.remark = [info stringObjectForKey:@"remark"];
        self.createTime = [info stringObjectForKey:@"createTime"];
        self.tax = [info stringObjectForKey:@"tax"];
        self.source = [info stringObjectForKey:@"source"];
        self.creater = [info stringObjectForKey:@"creater"];
        self.winPrice = [info stringObjectForKey:@"winPrice"];
        self.joinCount = [info stringObjectForKey:@"joinCount"];
        self.lowestPrice = [info stringObjectForKey:@"lowestPrice"];
        self.modifier = [info stringObjectForKey:@"modifier"];
        self.service = [info stringObjectForKey:@"service"];
        self.productName = [info stringObjectForKey:@"productName"];
        self.version = [info stringObjectForKey:@"version"];
        self.poundageType = [info stringObjectForKey:@"poundageType"];
        self.startTime = [info stringObjectForKey:@"startTime"];
        self.userId = [info stringObjectForKey:@"userId"];
        self.modifyTime = [info stringObjectForKey:@"modifyTime"];
        self.startTimeStr = [info stringObjectForKey:@"startTimeStr"];
        self.historyId = [info stringObjectForKey:@"id"];
        self.productStatus = [info stringObjectForKey:@"productStatus"];
        self.increasePrice = [info stringObjectForKey:@"increasePrice"];
        self.poundage = [info stringObjectForKey:@"poundage"];
        self.marketPrice = [info stringObjectForKey:@"marketPrice"];
        self.onlyLowestPrice = [info stringObjectForKey:@"onlyLowestPrice"];
        self.smallImg = [info stringObjectForKey:@"smallImg"];
        self.bigImg = [info stringObjectForKey:@"bigImg"];
        self.endTime = [info stringObjectForKey:@"endTime"];
        self.disabled = [info stringObjectForKey:@"disabled"];
    }
    return self;
}

@end
