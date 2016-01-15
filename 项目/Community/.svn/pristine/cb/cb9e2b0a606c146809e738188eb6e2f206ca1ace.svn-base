//
//  HWPublicRepairModel.m
//  Community
//
//  Created by niedi on 15/6/15.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWPublicRepairModel.h"

@implementation HWPublicRepairModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        self.modelId = [dict stringObjectForKey:@"id"];
        self.content = [dict stringObjectForKey:@"content"];
        self.createTime = [dict stringObjectForKey:@"createTime"];
        self.modifyTime = [dict stringObjectForKey:@"modifyTime"];
        self.createTimeStr = [dict stringObjectForKey:@"createTimeStr"];
        self.imagesArr = [dict arrayObjectForKey:@"images"];
        self.status = [dict stringObjectForKey:@"status"];
        self.result = [dict stringObjectForKey:@"result"];
        self.userId = [dict stringObjectForKey:@"userId"];
        self.spendTimeStr = [dict stringObjectForKey:@"spendTimeStr"];
    }
    return self;
}

/*
 @property (nonatomic, strong) NSString *content;
 @property (nonatomic, strong) NSString *createTime;
 @property (nonatomic, strong) NSString *createTimeStr;
 @property (nonatomic, strong) NSArray *imagesArr;
 @property (nonatomic, strong) NSString *status;
 @property (nonatomic, strong) NSString *result;
 @property (nonatomic, strong) NSString *spendTimeStr;
 */

@end

