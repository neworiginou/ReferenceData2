//
//  HWWuYeFeeModel.m
//  Community
//
//  Created by niedi on 15/6/11.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWWuYeFeeModel.h"

@implementation HWWuYeFeeModel


- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        self.nameStr = [dict stringObjectForKey:@"name"];
        self.buildingStr = [dict stringObjectForKey:@"building"];
        self.unitNoStr = [dict stringObjectForKey:@"unitNo"];
        self.roomStr = [dict stringObjectForKey:@"room"];
        self.propertyStr = [dict stringObjectForKey:@"property"];
        self.sDateStr = [dict stringObjectForKey:@"sDate"];
        self.typeStr = [dict stringObjectForKey:@"type"];
        self.messageStr = [dict stringObjectForKey:@"message"];
        self.wyFeeId = [dict stringObjectForKey:@"wyFeeId"];
        self.monthArr = [[dict stringObjectForKey:@"monthList"] componentsSeparatedByString:@","];
        self.WyHouseId = [dict stringObjectForKey:@"wyHouseId"];
        self.houseId = [dict stringObjectForKey:@"houseId"];
    }
    return self;
}




@end

//{
// "name": "山地车",
// "building": null,
// "room": "702",
// "property": 0,
// "sDate": 1435922124000,
// "type": "0",
// "message": "缴费一年免费清洗空调一次",
// "wyFeeId": "2"
// },