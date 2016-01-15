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
}
- (id)initWithUserId:(NSString *)userid PlatformName:(NSString *)platformName NickName:(NSString *)nickname IconUrl:(NSString *)iconurl
{
    self = [super init];
    
    if (self) {
        
        _userId = userid;
        _platformName = platformName;
        _nickName = nickname;
        _iconUrl = iconurl;
    }
    return self;
}

- (NSString*)requestUrl
{
    return @"/appUser/platform/register";
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
             @"iconUrl":_iconUrl};
}

@end
