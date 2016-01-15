//
//  HWWinnerModel.m
//  Community
//
//  Created by caijingpeng.haowu on 14-12-16.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWWinnerModel.h"

@implementation HWWinnerModel

@synthesize wId;
@synthesize cutUserId;
@synthesize cutId;
@synthesize cutPrice;
@synthesize productId;
@synthesize source;
@synthesize createTime;
@synthesize mobile;
@synthesize winnerId;

- (id)initWithWinner:(NSDictionary *)info
{
    self = [super init];
    if (self)
    {
        self.wId = [info stringObjectForKey:@"id"];
        self.cutUserId = [info stringObjectForKey:@"cutUserId"];
        self.cutId = [info stringObjectForKey:@"cutId"];
        self.cutPrice = [info stringObjectForKey:@"cutPrice"];
        self.productId = [info stringObjectForKey:@"productId"];
        self.source = [info stringObjectForKey:@"source"];
        self.createTime = [info stringObjectForKey:@"createTime"];
        self.mobile = [info stringObjectForKey:@"mobile"];
        self.winnerId = [info stringObjectForKey:@"winnerId"];
    }
    return self;
}

@end
