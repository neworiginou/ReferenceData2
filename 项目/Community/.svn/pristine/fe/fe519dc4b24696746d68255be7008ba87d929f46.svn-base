//
//  HWPropertyNewsClass.m
//  Community
//
//  Created by caijingpeng.haowu on 14-8-27.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWPropertyNewsClass.h"

@implementation HWPropertyNewsClass
//@synthesize trackId;
//@synthesize trackType;
//@synthesize picture;
//@synthesize audioUrl;

@synthesize content;
@synthesize systemTime;
@synthesize createTime;
@synthesize releaseType;
@synthesize timeDistance;
@synthesize topic;
@synthesize topicId;
@synthesize url;
@synthesize audioPlayMode;
@synthesize soundTime;
@synthesize fileName;
@synthesize creater;
@synthesize replyContent;

- (id)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super init])
    {
//        self.trackId = [dic stringObjectForKey:@"trackId"];
//        self.trackType = [dic stringObjectForKey:@"trackType"];
//        self.picture = [dic stringObjectForKey:@"picture"];
//        self.audioUrl = [dic stringObjectForKey:@"audioUrl"];
        
        self.content = [dic stringObjectForKey:@"content"];
        self.systemTime = [dic stringObjectForKey:@"systemTime"];
        self.createTime = [dic stringObjectForKey:@"createTime"];
        self.releaseType = [dic stringObjectForKey:@"releaseType"];
        self.timeDistance = [dic stringObjectForKey:@"timeDistance"];
        self.topic = [dic stringObjectForKey:@"topic"];
        self.topicId = [dic stringObjectForKey:@"topicId"];
        self.url = [dic stringObjectForKey:@"url"];
        self.audioPlayMode = 0;
        self.soundTime = [dic stringObjectForKey:@"soundTime"];
        self.creater = [dic stringObjectForKey:@"creater"];
        self.fileName = [dic stringObjectForKey:@"fileName"];
        self.replyContent = [dic stringObjectForKey:@"replyContent"];
    }
    return self;
}

@end
