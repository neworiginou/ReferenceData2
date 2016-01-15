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
    return @"/appUser/platform/login";
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
@end
