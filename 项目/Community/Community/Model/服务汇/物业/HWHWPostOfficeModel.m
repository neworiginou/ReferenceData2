//
//  HWHWPostOfficeModel.m
//  Community
//
//  Created by niedi on 15/6/12.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWHWPostOfficeModel.h"

@implementation HWHWPostOfficeModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        self.expressName = [dict stringObjectForKey:@"expressName"];
        self.expressNum = [dict stringObjectForKey:@"expressNum"];
        self.recipientPassword = [dict stringObjectForKey:@"recipientPassword"];
        self.createTimeStr = [dict stringObjectForKey:@"createTimeStr"];
    }
    return self;
}


/*{ "expressNum": 运单号,"expressName": 物流公司名称, "recipientPassword": 密码， "createTimeStr": 收件时间 } */

/*{
 collectingRegistration = "<null>";
 createTime = 1434182340000;
 createTimeStr = "2015-06-13 15:59";
 creater = "<null>";
 expressName = "<null>";
 expressNum = 201506130104;
 id = 104622267;
 note = "<null>";
 pickUpRegistration = "<null>";
 receiveStatus = 2;
 recipient = 18717969629;
 recipientPassword = 780204;
 storageLocation = "<null>";
 },*/

@end



