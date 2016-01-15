//
//  LoginEmailApi.m
//  PUClient
//
//  Created by RRLhy on 15/7/27.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "LoginEmailApi.h"

@implementation LoginEmailApi
{
    NSString * _email;
    NSString * _passWord;
}
- (id)initWithUserEmail:(NSString *)email password:(NSString *)password
{
    self = [super init];
    if (self) {
        _email = email;
        _passWord = password;
    }
    return self;
}

- (NSString*)requestUrl
{
    return @"/user/emailLogin";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPost;
}

- (id)requestArgument
{
    return @{@"email":_email,
             @"password":_passWord};
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
