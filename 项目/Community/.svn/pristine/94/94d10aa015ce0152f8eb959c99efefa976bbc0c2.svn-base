//
//  HWMyPriviledgeModel.m
//  Community
//
//  Created by gusheng on 14-12-10.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWMyPriviledgeModel.h"

@implementation HWMyPriviledgeModel
@synthesize priviledgeImageUrl;
@synthesize priviledgeNumStr;
@synthesize priviledgeStatus;
@synthesize priviledgeIdStr;
-(id)initWithDic:(NSDictionary *)dic
{
    if(self = [super init])
    {
        self.priviledgeStatus = [dic stringObjectForKey:@"valid"];
        self.priviledgeNumStr = [dic stringObjectForKey:@"couponNumber"];
        self.priviledgeImageUrl = [dic stringObjectForKey:@"listPic"];
        self.priviledgeIdStr = [dic stringObjectForKey:@"couponId"];
    }
    return self;
                
}
@end
