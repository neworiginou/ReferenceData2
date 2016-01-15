//
//  HWPropertyItemClass.m
//  Community
//
//  Created by lizhongqiang on 14-9-11.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWPropertyItemClass.h"

@implementation HWPropertyItemClass
@synthesize propertyId;
@synthesize propertyName;
@synthesize dialCount;
@synthesize iconUrl;
@synthesize phoneNumber;
@synthesize publicInform;

- (id)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super init])
    {
        self.propertyId = [dic stringObjectForKey:@"propertyId"];
        self.propertyName = [dic stringObjectForKey:@"propertyName"];
        self.dialCount = [dic stringObjectForKey:@"dialCount"];
        self.iconUrl = [dic stringObjectForKey:@"iconUrl"];
        self.phoneNumber = [dic stringObjectForKey:@"phoneNumber"];
        self.publicInform = [dic stringObjectForKey:@"publicInform"];
        
    }
    return self;
}
@end
