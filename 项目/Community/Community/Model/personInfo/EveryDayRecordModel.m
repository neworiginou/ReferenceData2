//
//  EveryDayRecordModel.m
//  TEST
//
//  Created by gusheng on 14-8-29.
//  Copyright (c) 2014年 gusheng. All rights reserved.
//

#import "EveryDayRecordModel.h"
@implementation EveryDayRecordModel
@synthesize yearAndDayStr,commissionStr,scanStr,activeStr,registerStr;
-(instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        self.yearAndDayStr =[dic numberObjectForKey:@"date"];
        
        self.commissionStr =[NSString stringWithFormat:@"%@",[dic numberObjectForKey:@"commission"]];
        self.scanStr = [NSString stringWithFormat:@"%@",[dic numberObjectForKey:@"scan"]];
        self.activeStr = [NSString stringWithFormat:@"%@",[dic numberObjectForKey:@"activate"]];
        self.registerStr = [NSString stringWithFormat:@"%@",[dic numberObjectForKey:@"register"]];
        self.yearAndDayStr = [NSString stringWithFormat:@"%@",[dic stringObjectForKey:@"dealTime"]];
    }
    return self;
}

@end
