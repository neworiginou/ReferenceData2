//
//  HWChannelModel.m
//  Community
//
//  Created by caijingpeng.haowu on 15/1/15.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：话题 数据模型
//
//  修改记录：
//      姓名         日期               修改内容
//     蔡景鹏     2015-01-15           创建文件
//     杨庆龙     2015--1-16           实现NSCoding协议
//

#import "HWChannelModel.h"

@implementation HWChannelModel

@synthesize channelIcon;
@synthesize channelId;
@synthesize channelName;
@synthesize channelColor;
/*[ "channelId": 104044645,频道id "channelName": "广东话邓华德",频道名称 "channelIcon": null,频道logo url "creatorName": null,创建人 "joinCount": null 参与数量 ]*/

- (id)initWithChannel:(NSDictionary *)info
{
    self = [super init];
    if (self)
    {
        self.channelId = [info stringObjectForKey:@"channelId"];
        self.channelName = [info stringObjectForKey:@"channelName"];
        self.channelIcon = [info stringObjectForKey:@"channelIcon"];
        self.partInCount = [[info stringObjectForKey:@"joinCount"] isEqualToString:@""] ? @"1" : [info stringObjectForKey:@"joinCount"];
        self.createrName = [info stringObjectForKey:@"creatorName"];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.channelName = [aDecoder decodeObjectForKey:@"channelName"];
        self.channelId = [aDecoder decodeObjectForKey:@"channelId"];
        self.channelIcon = [aDecoder decodeObjectForKey:@"channelIcon"];
        self.partInCount = [aDecoder decodeObjectForKey:@"joinCount"];
        self.createrName = [aDecoder decodeObjectForKey:@"creatorName"];
    }
    return self;

}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.channelIcon forKey:@"channelIcon"];
    [aCoder encodeObject:self.channelId forKey:@"channelId"];
    [aCoder encodeObject:self.channelName forKey:@"channelName"];
    [aCoder encodeObject:self.partInCount forKey:@"joinCount"];
    [aCoder encodeObject:self.createrName forKey:@"creatorName"];
}

@end
