//
//  HWStoreNewsClass.m
//  Community
//
//  Created by caijingpeng.haowu on 14-8-27.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//
//  商户详情 活动动态数据模型
//

#import "HWStoreNewsClass.h"

@implementation HWStoreNewsClass
@synthesize trackId;
//@synthesize systemTime;
@synthesize content;
//@synthesize createTime;
@synthesize createDate;
-(id)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super init])
    {
        self.trackId = [dic stringObjectForKey:@"trackId"];
//        self.systemTime = [dic stringObjectForKey:@"systemTime"];
//        self.createTime = [dic stringObjectForKey:@"createTime"];
        self.content = [dic stringObjectForKey:@"content"];
        self.createDate = [dic stringObjectForKey:@"createDate"];
    }
    return self;
}
@end
