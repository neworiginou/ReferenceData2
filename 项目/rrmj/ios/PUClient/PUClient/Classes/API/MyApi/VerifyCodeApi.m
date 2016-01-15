//
//  VerifyCodeApi.m
//  PUClient
//
//  Created by RRLhy on 15/7/28.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "VerifyCodeApi.h"

@implementation VerifyCodeApi
{
    NSString * _phone;
    NSString * _code;
}
- (id)initWithUserPhone:(NSString *)phone code:(NSString *)code
{
    self = [super init];
    if (self) {
        _phone = phone;
        _code = code;
    }
    return self;
}

- (NSString*)requestUrl
{
    return @"/user/verifyCaptcha";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPost;
}

- (id)requestArgument
{
    return @{@"mobile":_phone,@"code":_code};
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
