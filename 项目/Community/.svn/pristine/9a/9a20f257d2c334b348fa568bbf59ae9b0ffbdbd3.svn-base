//
//  HWSubmitOrderModel.m
//  Community
//
//  Created by ryder on 8/1/15.
//  Copyright (c) 2015 caijingpeng. All rights reserved.
//

#import "HWSubmitOrderModel.h"

@implementation HWSubmitOrderModel
@synthesize data;

- (instancetype)initWithdictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.detail = [dictionary stringObjectForKey:@"detail"];
        self.key = [dictionary stringObjectForKey:@"key"];
        self.status = [dictionary stringObjectForKey:@"status"];
//        self.data = [dictionary stringObjectForKey:@"data"];
        
        self.data = [dictionary dictionaryObjectForKey:@"data"];
        self.orderId = [self.data stringObjectForKey:@"orderId"];
        self.submitResult = [self.data stringObjectForKey:@"submitResult"];
        self.submitMsg = [self.data stringObjectForKey:@"submitMsg"];
    }
    return self;
}

@end
