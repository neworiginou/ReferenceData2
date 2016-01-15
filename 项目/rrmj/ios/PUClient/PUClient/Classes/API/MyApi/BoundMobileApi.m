//
//  BoundMobileApi.m
//  PUClient
//
//  Created by RRLhy on 15/7/28.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "BoundMobileApi.h"

@implementation BoundMobileApi
{
    NSString * _mobile;
    NSString * _token;
    NSString * _code;
}
- (id)initWithUserMobile:(NSString *)mobile token:(NSString *)token code:(NSString *)code
{
    self = [super init];
    if (self) {
        _mobile = mobile;
        _token = token;
        _code = code;
    }
    return self;
}

- (NSString*)requestUrl
{
    return @"/user/bindMobile";
}
- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPost;
}

- (id)requestArgument
{
    return @{@"mobile":_mobile,
             @"token":_token,
             @"code":_code};
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
