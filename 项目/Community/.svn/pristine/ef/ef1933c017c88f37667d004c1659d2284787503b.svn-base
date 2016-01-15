//
//  HWAddressModel.m
//  Community
//
//  Created by caijingpeng.haowu on 14-12-16.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWAddressModel.h"

@implementation HWAddressModel

@synthesize modelId;
@synthesize addressId;
@synthesize cutUserId;
@synthesize name;
@synthesize address;
@synthesize mobile;
@synthesize isDefault;
/**
 *                      "id": null,
 "addressId": 381116,
 "cutUserId": 691,
 "name": "厉1",
 "address": "上海普陀",
 "mobile": "18717959523",
 "isDefault": 1
 
 */

- (id)initWithAddress:(NSDictionary *)info
{
    self = [super init];
    if (self)
    {
     //   NSLog(@"%@",[info[@"addressId"] class]);
        self.modelId = [info stringObjectForKey:@"id"];
        self.addressId = [info stringObjectForKey:@"addressId"];
        self.cutUserId = [info stringObjectForKey:@"cutUserId"];
        self.name = [info stringObjectForKey:@"name"];
        self.address = [info stringObjectForKey:@"address"];
        self.mobile = [info stringObjectForKey:@"mobile"];
        self.isDefault = [info stringObjectForKey:@"isDefault"];
    }
    return self;
}

@end
