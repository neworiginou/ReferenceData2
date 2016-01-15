//
//  HWAlertItem.m
//  Community
//
//  Created by caijingpeng.haowu on 15/5/4.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  保存 设置的提醒时间

#import "HWAlertModel.h"

@implementation HWAlertModel

@synthesize alertTime;
@synthesize goodsId;

- (id)initWithInfo:(NSDictionary *)dic
{
    self = [super init];
    if (self)
    {
        self.alertTime = [dic stringObjectForKey:@"alertTime"];
        self.goodsId = [dic stringObjectForKey:@"goodsId"];
    }
    return self;
}

@end
