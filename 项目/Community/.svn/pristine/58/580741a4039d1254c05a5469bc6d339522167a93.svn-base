//
//  HWGoodsListModel.m
//  Community
//
//  Created by lizhongqiang on 15/4/13.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWGoodsListModel.h"

@implementation HWGoodsListModel
@synthesize productId;
@synthesize bigImg;
@synthesize marketPrice;
@synthesize status;
@synthesize remainMs;
@synthesize productName;

- (id)initWithDict:(NSDictionary *)info
{
    self = [super init];
    if (self)
    {
        self.productId = [info stringObjectForKey:@"productId"];
        self.bigImg = [info stringObjectForKey:@"bigImg"];
        self.marketPrice = [info stringObjectForKey:@"marketPrice"];
        self.status = [info stringObjectForKey:@"status"];
        self.remainMs = [info stringObjectForKey:@"remainMs"];
        self.productName = [info stringObjectForKey:@"productName"];
    }
    return self;
}
@end
