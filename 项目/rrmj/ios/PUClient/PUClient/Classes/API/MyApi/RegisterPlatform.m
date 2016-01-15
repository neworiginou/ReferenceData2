//
//  RegisterPlatform.m
//  PUClient
//
//  Created by RRLhy on 15/7/27.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "RegisterPlatform.h"

@implementation RegisterPlatform
{
    NSString * _userId;
    NSString * _platformName;
    NSString * _nickName;
    NSString * _iconUrl;
    NSString * _userName;
}
- (id)initWithUserId:(NSString *)userid PlatformName:(NSString *)platformName NickName:(NSString *)nickname IconUrl:(NSString *)iconurl userName:(NSString *)name
{
    self = [super init];
    
    if (self) {
        
        _userId = userid;
        _platformName = platformName;
        _nickName = nickname;
        _iconUrl = iconurl;
        _userName = name;
    }
    return self;
}

- (NSString*)requestUrl
{
    return @"/user/platReg";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPost;
}

- (id)requestArgument
{
    return @{@"usid":_userId,
             @"platformName":_platformName,
             @"nickName":_nickName,
             @"iconUrl":_iconUrl,
             @"userName":_userName};
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
