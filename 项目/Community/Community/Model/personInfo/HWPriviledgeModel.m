//
//  HWPriviledgeModel.m
//  TestOne
//
//  Created by gusheng on 14-12-8.
//  Copyright (c) 2014年 gusheng. All rights reserved.
//

#import "HWPriviledgeModel.h"

@implementation HWPriviledgeModel
/*
 @property(nonatomic,strong)NSString * priviledgeId;
 @property(nonatomic,strong)NSString * hourStr;
 @property(nonatomic,strong)NSString * minitueStr;
 @property(nonatomic,strong)NSString * secondStr;
 @property(nonatomic,strong)NSString * priviledgeType;//未开始，立即领劵，已领完
 @property(nonatomic,strong)NSString * priviledgeImageUrl;//优惠劵图片Url
 */
@synthesize priviledgeId;
//@synthesize hourStr;
//@synthesize minitueStr;
//@synthesize secondStr;
@synthesize priviledgeType;
@synthesize priviledgeImageUrl;
@synthesize timeStr;
@synthesize remainMsStr;
-(id)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        self.priviledgeId = [dic stringObjectForKey:@"couponId"];
//        NSDate *StartDate = [NSDate dateWithTimeIntervalSince1970:[timeStrTemp doubleValue]/1000];
//        NSDate *nowDate = [NSDate date];
//        NSTimeInterval coolTime = [StartDate timeIntervalSinceDate:nowDate];
        timeStr = [dic stringObjectForKey:@"getTimeStart"];
        self.priviledgeType = [dic stringObjectForKey:@"status"];
        self.priviledgeImageUrl = [dic stringObjectForKey:@"listPic"];
        self.remainMsStr = [dic stringObjectForKey:@"remainMs"];
    }
    return self;
}

@end
