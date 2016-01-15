//
//  AddressModel.m
//  Community
//
//  Created by hw500028 on 14/12/8.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "AddressModel.h"

@implementation AddressModel

@synthesize addressId;
@synthesize cutUserId;
@synthesize name;
@synthesize address;
@synthesize mobile;
@synthesize creater;
@synthesize createTime;
@synthesize modifier;
@synthesize modifyTime;
@synthesize version;
@synthesize disabled;
@synthesize isDefault;
@synthesize orderIdStr;
- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self)
    {
        self.addressId = [dic stringObjectForKey:@"addressId"];
        self.cutUserId = [dic stringObjectForKey:@"cutUserId"];
        self.name = [dic stringObjectForKey:@"name"];
        self.address = [dic stringObjectForKey:@"address"];
        self.mobile = [dic stringObjectForKey:@"mobile"];
        self.creater = [dic stringObjectForKey:@"creater"];
        self.createTime = [dic stringObjectForKey:@"createTime"];
        
        self.modifier = [dic stringObjectForKey:@"modifier"];
        self.modifyTime = [dic stringObjectForKey:@"modifyTime"];
        self.version = [dic stringObjectForKey:@"version"];
        self.disabled = [dic stringObjectForKey:@"disabled"];
        self.isDefault = [dic stringObjectForKey:@"isDefault"];
    }
    return self;
}

@end
