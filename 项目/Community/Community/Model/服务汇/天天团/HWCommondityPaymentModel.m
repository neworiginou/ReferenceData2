//
//  HWCommondityPaymentModel.m
//  Community
//
//  Created by ryder on 8/3/15.
//  Copyright (c) 2015 caijingpeng. All rights reserved.
//

#import "HWCommondityPaymentModel.h"

@implementation HWCommondityPaymentModel

- (instancetype)initWithdictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.detail = [dictionary stringObjectForKey:@"detail"];
        self.key = [dictionary stringObjectForKey:@"key"];
        self.status = [dictionary stringObjectForKey:@"status"];
        self.data = [dictionary stringObjectForKey:@"data"];
    }
    return self;
}

@end
