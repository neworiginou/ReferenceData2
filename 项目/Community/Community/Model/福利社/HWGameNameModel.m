//
//  HWGameNameModel.m
//  KaoLaSpread
//
//  Created by WeiYuanlin on 15/1/15.
//  Copyright (c) 2015年 hw. All rights reserved.
//
//  功能描述：个人游戏推广Model
//
//  修改记录：
//      姓名          日期                      修改内容
//      魏远林        2015-1-15                 创建文件
//


#import "HWGameNameModel.h"

@implementation HWGameNameModel

@synthesize dimensionalCode;
@synthesize downloadAddress;
@synthesize gameId;
@synthesize popularizeUserId;
@synthesize gameShareUrl;

- (id)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self)
    {
        dimensionalCode = [dic stringObjectForKey:@"dimensionalCode"];
        downloadAddress = [dic stringObjectForKey:@"downloadAddress"];
        gameId = [dic stringObjectForKey:@"gameId"];
        popularizeUserId = [dic stringObjectForKey:@"popularizeUserId"];
        gameShareUrl = [dic stringObjectForKey:@"gameShareUrl"];
    }
    return self;
}
@end
