//
//  HWPriviledgeDetailModel.m
//  TestOne
//
//  Created by gusheng on 14-12-8.
//  Copyright (c) 2014年 gusheng. All rights reserved.
//

#import "HWPriviledgeDetailModel.h"

@implementation HWPriviledgeDetailModel

@synthesize priviledgeImageUrl;
@synthesize timeStr;
@synthesize totalPriviledge;
@synthesize remainPriviledge;
@synthesize priviledgeContent;
@synthesize brandStr;
@synthesize starTime;
@synthesize endTime;
@synthesize ruleArry;
@synthesize priviledgeType;
@synthesize sharePriviledgeStatus;
@synthesize priviledgeOrderNum;
@synthesize priviledgeUrl;
@synthesize shareUrl;
@synthesize remainMS;

- (id)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        self.priviledgeImageUrl = [dic stringObjectForKey:@"detailPic"];
        self.timeStr =[dic stringObjectForKey:@"getTimeStart"];
        
        NSString *countStr = [dic stringObjectForKey:@"count"];
        self.totalPriviledge = (countStr.length == 0 ? @"0" : countStr);
        
        self.remainPriviledge = [dic stringObjectForKey:@"remainCount"];
        self.priviledgeContent = [dic stringObjectForKey:@"name"];
        self.brandStr = [dic stringObjectForKey:@"shopName"];
        self.starTime =[dic stringObjectForKey:@"validTimeStart"];
        self.endTime = [dic stringObjectForKey:@"validTimeEnd"];
        NSString *ruleStr = [dic stringObjectForKey:@"ruleDesc"];
        ruleStr = [ruleStr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        self.ruleArry = [ruleStr componentsSeparatedByString:@"\n"];
        self.priviledgeUrl = [dic stringObjectForKey:@"linkUrl"];
        self.priviledgeType = [dic stringObjectForKey:@"status"];
        self.sharePriviledgeStatus = [dic stringObjectForKey:@""];
        self.priviledgeOrderNum = [dic stringObjectForKey:@""];
        self.shareUrl = [dic stringObjectForKey:@"shareUrl"];
//        self.remainMS = [dic stringObjectForKey:@"remainMs"];
        
        NSUInteger minTime = [[dic stringObjectForKey:@"remainMs"] integerValue] / 1000;//99999999
        self.remainMS = [NSString stringWithFormat:@"%i",minTime];
        
//        self.remainMS = [NSString stringWithFormat:@"%f", [[dic stringObjectForKey:@"remainMS"] doubleValue] / 1000];
    }
    return self;
}
@end
