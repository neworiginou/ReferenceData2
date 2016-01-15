//
//  HWChannelItemClass.m
//  Community
//
//  Created by zhangxun on 15/1/20.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

//  修改人         日期          操作
//  张迅           2014.1.20    创建

#import "HWChannelItemClass.h"

@implementation HWChannelItemClass


@synthesize topicId;
@synthesize title;
@synthesize content;
@synthesize replyCount;
@synthesize praiseCount;
@synthesize createTime;
@synthesize userId;
@synthesize releaseType;
@synthesize villageName;
@synthesize villageId;
@synthesize cityId;
@synthesize districtId;
@synthesize areaName;
@synthesize hasPraise;
@synthesize mongodbKey;
@synthesize fileName;
@synthesize soundTime;

- (void)fillWithDictionary:(NSDictionary *)dict
{
    self.channelId = [dict stringObjectForKey:@"channelId"];
    self.channelName = [dict stringObjectForKey:@"channelName"];
    self.nickName = [dict stringObjectForKey:@"nickName"];
    self.headUrl = [dict stringObjectForKey:@"headUrl"];
    self.isAnonymous = [dict stringObjectForKey:@"isAnonymous"];
    self.topicId = [dict stringObjectForKey:@"topicId"];
    self.title = [dict stringObjectForKey:@"title"];
    self.content = [dict stringObjectForKey:@"content"];
    self.replyCount = [dict stringObjectForKey:@"replyCount"];
    self.praiseCount = [dict stringObjectForKey:@"praiseCount"];
    self.createTime = [dict stringObjectForKey:@"createTime"];
    self.createTimeStr = [dict stringObjectForKey:@"createTimeStr"];
    self.userId = [dict stringObjectForKey:@"userId"];
    self.releaseType = [dict stringObjectForKey:@"releaseType"];
    self.villageName = [dict stringObjectForKey:@"villageName"];
    self.villageId = [dict stringObjectForKey:@"villageId"];
    self.cityId = [dict stringObjectForKey:@"cityId"];
    self.districtId = [dict stringObjectForKey:@"districtId"];
    self.areaName = [dict stringObjectForKey:@"areaName"];
    self.hasPraise = [dict stringObjectForKey:@"hasPraise"];
    self.mongodbKey = [dict stringObjectForKey:@"mongodbKey"];
    self.fileName = [dict stringObjectForKey:@"fileName"];
    self.soundTime = [dict stringObjectForKey:@"soundTime"];
}

- (void)fillWithDictForPersonalTheme:(NSDictionary *)dict
{
    self.channelId = [dict stringObjectForKey:@"channelId"];
    self.channelName = [dict stringObjectForKey:@"channelName"];
    self.userId = [dict stringObjectForKey:@"userId"];
    self.nickName = [dict stringObjectForKey:@"nickName"];
    self.headUrl = [dict stringObjectForKey:@"headUrl"];
    self.topicId = [dict stringObjectForKey:@"topicId"];
    self.content = [dict stringObjectForKey:@"topicContent"];
    self.replyCount = [dict stringObjectForKey:@"replyCount"];
    self.praiseCount = [dict stringObjectForKey:@"praiseCount"];
    self.createTime = [dict stringObjectForKey:@"createTime"];
    self.createTimeStr = [dict stringObjectForKey:@"createTimeStr"];
    self.releaseType = [dict stringObjectForKey:@"releaseType"];
    self.mongodbKey = [dict stringObjectForKey:@"topicMongodbKey"];
    self.hasPraise = [dict stringObjectForKey:@"hasPraise"];
}
/*{
 channelId = "<null>";
 channelName = "<null>";
 createTime = 1430975440000;
 createTimeStr = "1\U5c0f\U65f6\U524d";
 hasPraise = 1;
 headUrl = "file/downloadByKey.do?mKey=55404622e4b06bf3a4903e04";
 mongodbKey = 55404622e4b06bf3a4903e04;
 nickName = 9623;
 praiseCount = 1;
 releaseType = 0;
 replyCount = "<null>";
 soundTime = "<null>";
 topicAttUrl = "file/downloadByKey.do?mKey=554af3cfe4b08b7886a3d48e";
 topicContent = "\U65f6\U5c1a";
 topicId = 1036509474;
 topicMongodbKey = 554af3cfe4b08b7886a3d48e;
 userId = 1033470033469;
 }*/


@end
