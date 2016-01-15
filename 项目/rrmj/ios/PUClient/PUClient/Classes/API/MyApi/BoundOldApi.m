//
//  BoundOldApi.m
//  PUClient
//
//  Created by RRLhy on 15/7/27.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "BoundOldApi.h"

@implementation BoundOldApi
{
    NSString * _userId;
    NSString * _platformName;
    NSString * _loginName;
    NSString * _passWord;
    NSString * _nickName;
}
- (id)initWithUserId:(NSString *)userId platformName:(NSString *)platformName loginName:(NSString *)loginName passWord:(NSString *)pwd nickName:(NSString*)nickname
{
    self = [super init];
    if (self) {
        _userId= userId;
        _platformName = platformName;
        _loginName = loginName;
        _passWord = pwd;
        _nickName = nickname;
    }
    return self;
}

- (NSString*)requestUrl
{
    return @"/user/bindOldAccount";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPost;
}

- (id)requestArgument
{
    return @{@"usid":_userId,
             @"platformName":_platformName,
             @"loginName":_loginName,
             @"pwd":_passWord,
             @"userName":_nickName};
}

/**
 *  设置缓存
 *
 *  @return 返回缓存持续的时间
 */
- (NSInteger)cacheTimeInSeconds {
    // 3分钟 = 180 秒
    return 0;
}

@end
