//
//  LoginPlatform.m
//  PUClient
//
//  Created by RRLhy on 15/7/27.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "LoginPlatformApi.h"

@implementation LoginPlatformApi
{
    NSString * _userid;
    NSString * _platformName;
}

- (id)initWithUserId:(NSString *)userid PlatformName:(NSString *)platformName
{
    if (self = [super init]) {
        
        _userid = userid;
        _platformName = platformName;
    }
    return self;
}

- (NSString*)requestUrl
{
    return @"/user/platLogin";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPost;
}

- (id)requestArgument
{
    return @{@"usid":_userid,
             @"platformName":_platformName};
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
