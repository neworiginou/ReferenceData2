//
//  HWGameSpreadPicModel.m
//  Community
//
//  Created by niedi on 15/1/19.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//    魏远林     2015-01-20     增添gamename model

#import "HWGameSpreadPicModel.h"

@implementation HWGameSpreadPicModel


- (instancetype)initWithDic:(NSDictionary *)dict
{
    if (self = [super init])
    {
        self.bannerMongodbKey = [dict stringObjectForKey:@"bannerMongodbKey"];
        self.gameId = [dict stringObjectForKey:@"gameId"];
        self.gameName = [dict stringObjectForKey:@"gameName"];
    }
    return self;
}

@end
