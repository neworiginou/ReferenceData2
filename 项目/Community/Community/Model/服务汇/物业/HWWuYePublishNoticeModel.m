//
//  HWWuYePublishNoticeModel.m
//  Community
//
//  Created by niedi on 15/6/11.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWWuYePublishNoticeModel.h"

@implementation HWWuYePublishNoticeModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        self.topicId = [dict stringObjectForKey:@"topicId"];
        self.createTime = [dict stringObjectForKey:@"createTime"];
        self.content = [dict stringObjectForKey:@"content"];
    }
    return self;
}




@end
