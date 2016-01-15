//
//  FindPsdMobile.m
//  PUClient
//
//  Created by RRLhy on 15/7/27.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "FindPsdMobileApi.h"

@implementation FindPsdMobileApi
{
    NSString * _mobile;
    NSString * _code;
    NSString * _passWord;
}
- (id)initWithUserMobile:(NSString *)mobile code:(NSString *)code passWord:(NSString *)psd
{
    self = [super init];
    if (self) {
        _mobile = mobile;
        _code = code;
        _passWord = psd;
    }
    return self;
}

- (NSString*)requestUrl
{
    return @"/user/resetPwdMobile";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPost;
}

- (id)requestArgument
{
    return @{@"mobile":_mobile,
             @"code":_code,
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
