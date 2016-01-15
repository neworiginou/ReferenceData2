//
//  HWCityClass.m
//  Community
//
//  Created by gusheng on 14-9-13.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWCity.h"

@implementation HWCity
@synthesize cityId;
@synthesize cityName;
@synthesize cityPinyin;
@synthesize areaName;
@synthesize areaId;
- (id)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super init])
    {
        self.cityId = [dic stringObjectForKey:@"id"];
        self.cityName = [dic stringObjectForKey:@"city_name"];
        self.cityPinyin = [dic stringObjectForKey:@"city_quanpin"];
    }
    return self;
}
@end
