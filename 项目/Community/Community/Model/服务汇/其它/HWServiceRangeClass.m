//
//  HWServiceRangeClass.m
//  Community
//
//  Created by lizhongqiang on 14-9-11.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWServiceRangeClass.h"

@implementation HWServiceRangeClass
@synthesize villageId;
@synthesize villageName;

- (id)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super init])
    {
        self.villageId = [dic stringObjectForKey:@"villageId"];
        self.villageName = [dic stringObjectForKey:@"villageName"];
        self.distance = [dic stringObjectForKey:@"distance"];
    }
    return self;
}
@end
