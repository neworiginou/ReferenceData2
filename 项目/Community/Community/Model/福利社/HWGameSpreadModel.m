//
//  HWGameSpreadModel.m
//  KaoLa
//
//  Created by WeiYuanlin on 15/1/13.
//  Copyright (c) 2015年 WeiYuanlin. All rights reserved.
//
//  功能描述：游戏推广页面model
//
//  修改记录：
//      姓名          日期                      修改内容
//      魏远林         2015-1-13               创建文件
//

#import "HWGameSpreadModel.h"

@implementation HWGameSpreadModel

- (id)initWithDictionary:(NSDictionary *)dic;
{
    self = [super init];
    if (self)
    {
        self.appNumber = [dic stringObjectForKey:@"appNumber"];
        self.channelNumber = [dic stringObjectForKey:@"channelNumber"];
        self.commissionCount = [dic stringObjectForKey:@"commissionCount"];
        self.commissionList = [dic stringObjectForKey:@"commissionList"];
        self.detailDescription = [dic stringObjectForKey:@"detailDescription"];
        self.gameId = [dic stringObjectForKey:@"gameId"];
        self.gameName = [dic stringObjectForKey:@"gameName"];
        self.iconMongodbKey = [dic stringObjectForKey:@"iconMongodbKey"];
        self.shareCount = [dic stringObjectForKey:@"shareCount"];
        self.shortUrl = [dic stringObjectForKey:@"shortUrl"];
        self.typeDescription = [dic stringObjectForKey:@"typeDescription"];
    }
    return self;
}
@end
