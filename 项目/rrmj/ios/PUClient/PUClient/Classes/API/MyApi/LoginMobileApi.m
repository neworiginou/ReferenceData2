//
//  LoginMobileApi.m
//  PUClient
//
//  Created by RRLhy on 15/7/27.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "LoginMobileApi.h"

@implementation LoginMobileApi
{
    NSString * _mobile;
    NSString * _passWord;
}
- (id)initWithUserMobile:(NSString *)mobile password:(NSString *)password
{
    self = [super init];
    if (self) {
        
        _mobile = mobile;
        _passWord = password;
        
    }
    return self;
}

- (NSString*)requestUrl
{
    return @"/user/mobileLogin";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPost;
}

- (id)requestArgument
{
    return @{@"mobile":_mobile,
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
