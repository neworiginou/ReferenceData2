//
//  MinitueAndSecondOfDateModel.m
//  TEST
//
//  Created by gusheng on 14-8-29.
//  Copyright (c) 2014年 gusheng. All rights reserved.
//

#import "MinitueAndSecondOfDateModel.h"

@implementation MinitueAndSecondOfDateModel
-(instancetype)initWithDic:(NSDictionary *)dic;
{
    if (self = [super init]) {
        self.yearAndDayStr = [dic objectForKey:@""];
        self.minitueAndSecondStr = [dic objectForKey:@""];
    }
    return self;
}
@end
