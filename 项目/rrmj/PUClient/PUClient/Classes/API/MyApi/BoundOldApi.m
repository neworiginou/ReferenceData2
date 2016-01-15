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
}
- (id)initWithUserId:(NSString *)userId platformName:(NSString *)platformName loginName:(NSString *)loginName passWord:(NSString *)pwd
{
    self = [super init];
    if (self) {
        _userId= userId;
        _platformName = platformName;
        _loginName = loginName;
        _passWord = pwd;
    }
    return self;
}

- (NSString*)requestUrl
{
    return @"/appUser/bind";
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
             @"pwd":_passWord};
}

@end
