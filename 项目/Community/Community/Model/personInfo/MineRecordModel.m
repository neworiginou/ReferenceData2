//
//  MineRecordModel.m
//  TEST
//
//  Created by gusheng on 14-8-29.
//  Copyright (c) 2014年 gusheng. All rights reserved.
//

#import "MineRecordModel.h"

@implementation MineRecordModel
@synthesize phoneStr,scanStr,activeStr,registerStr;
-(instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        self.phoneStr = [dic stringObjectForKey:@"deviceType"];
        self.scanStr = [dic stringObjectForKey:@"downloadTime"];
        self.activeStr = [dic stringObjectForKey:@"activeTime"];
        self.registerStr = [dic stringObjectForKey:@"registerTime"];
    }
    return self;
}
@end
