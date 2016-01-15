//
//  HWWuYeServiceModel.m
//  Community
//
//  Created by niedi on 15/6/11.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWWuYeServiceModel.h"

@implementation HWWuYeServiceModel

- (instancetype)initWithdict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        self.name = [dict stringObjectForKey:@"name"];
        self.address = [dict stringObjectForKey:@"address"];
        self.openTime = [dict stringObjectForKey:@"openTime"];
        self.coStatus = [dict stringObjectForKey:@"coStatus"];
        self.publishModel = [[HWWuYePublishNoticeModel alloc] initWithDict:[dict dictionaryObjectForKey:@"topic"]];
        self.hasUnread = [dict stringObjectForKey:@"hasUnread"];
        self.telArr = [dict arrayObjectForKey:@"tenementTel"];
    }
    return self;
}

@end

/*@property (nonatomic, strong) NSString *name;
 @property (nonatomic, strong) NSString *address;
 @property (nonatomic, strong) NSString *openTime;
 @property (nonatomic, strong) HWWuYePublishNoticeModel *publishModel;
 @property (nonatomic, strong) NSArray *telArr;
*/
