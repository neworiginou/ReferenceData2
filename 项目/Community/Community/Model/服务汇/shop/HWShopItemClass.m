//
//  HWShopItemClass.m
//  Community
//
//  Created by lizhongqiang on 14-9-11.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWShopItemClass.h"
#import "HWShopServiceConfig.h"

@implementation HWShopItemClass
@synthesize shopId;
@synthesize shopName;
@synthesize dialCount;
@synthesize sourceType;
@synthesize iconUrl;
@synthesize phoneNumber;
@synthesize arrShopConfig;
@synthesize mobileNumber;
@synthesize outSell;
@synthesize outSellPic;
@synthesize auditStatus;

-(id)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super init])
    {
        self.shopId = [dic stringObjectForKey:@"shopId"];
        self.shopName = [dic stringObjectForKey:@"shopName"];
        self.dialCount = [dic stringObjectForKey:@"dialCount"];
        self.sourceType = [dic stringObjectForKey:@"sourceType"];
        self.iconUrl = [dic stringObjectForKey:@"iconUrl"];
        self.phoneNumber = [dic stringObjectForKey:@"phoneNumber"];
        self.mobileNumber = [dic stringObjectForKey:@"mobileNumber"];
        self.outSell = [dic stringObjectForKey:@"outSell"];
        self.outSellPic = [dic stringObjectForKey:@"outSellPic"];
        self.auditStatus = [dic stringObjectForKey:@"auditStatus"];
        
        arrShopConfig = [[NSMutableArray alloc] init];
        NSArray *arrConfig = [dic arrayObjectForKey:@"serviceConfig"];
        for (int i = 0; i < arrConfig.count; i ++)
        {
            [self.arrShopConfig addObject:[[HWShopServiceConfig alloc] initWithDictionary:[arrConfig objectAtIndex:i]]];
        }
        
    }
    
    return self;
}

@end
