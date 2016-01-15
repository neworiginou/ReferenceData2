//
//  HWShareDetailClass.m
//  Community
//
//  Created by caijingpeng.haowu on 14-9-15.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWShareDetailClass.h"

@implementation HWShareDetailClass

@synthesize activityId;
@synthesize contentUrl;
@synthesize houseAddress;
@synthesize houseAvgPrice;
@synthesize houseId;
@synthesize houseName;
@synthesize housePromo;
@synthesize publishTime;
@synthesize shareingPrice;

- (id)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    
    if (self)
    {
        self.activityId         = [dic stringObjectForKey:@"activityId"];
        self.contentUrl         = [dic stringObjectForKey:@"contentUrl"];
        self.houseAddress       = [dic stringObjectForKey:@"houseAddress"];
        self.houseAvgPrice      = [dic stringObjectForKey:@"houseAvgPrice"];
        self.houseId            = [dic stringObjectForKey:@"houseId"];
        self.houseName          = [dic stringObjectForKey:@"houseName"];
        self.housePromo         = [dic stringObjectForKey:@"housePromo"];
        self.publishTime        = [dic stringObjectForKey:@"publishTime"];
        self.shareingPrice      = [dic stringObjectForKey:@"shareingPrice"];
    }
    
    return self;
}

@end
