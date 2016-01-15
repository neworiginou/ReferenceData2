//
//  HWGameAllNameModel.m
//  Community
//
//  Created by WeiYuanlin on 15/1/17.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//  功能描述：游戏一键推广全部游戏model
//
//  修改记录：
//      姓名          日期                      修改内容
//      魏远林         2015-1-17                创建文件
//

#import "HWGameAllNameModel.h"

@implementation HWGameAllNameModel
@synthesize gameName;
@synthesize gameImg;
@synthesize gameId;
@synthesize appNumber;
@synthesize channelNumber;
@synthesize gameShareUrl;
@synthesize shortUrl;

- (id)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self)
    {
        self.gameName = [dic stringObjectForKey:@"gameName"];
        self.gameImg = [dic stringObjectForKey:@"iconMongodbKey"];
        self.gameId = [dic stringObjectForKey:@"gameId"];
        self.appNumber = [dic stringObjectForKey:@"appNumber"];
        self.channelNumber = [dic stringObjectForKey:@"channelNumber"];
        self.gameShareUrl = [dic stringObjectForKey:@"gameShareUrl"];
        self.shortUrl = [dic stringObjectForKey:@"shortUrl"];
    }
    return self;
}
@end
