//
//  RegisterApi.m
//  PUClient
//
//  Created by RRLhy on 15/7/22.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "RegisterApi.h"

@implementation RegisterApi
{
    NSString *_password;
    NSString *_mobile;
    NSString *_nickname;
    NSString *_code;
}

- (id)initWithMobile:(NSString *)mobile nickName:(NSString *)nickname passWord:(NSString *)password Code:(NSString *)code
{
    self = [super init];
    
    if (self) {
        
        _nickname = nickname;
        _mobile = mobile;
        _password = password;
        _code = code;
    }
    return self;
}

- (NSString *)requestUrl {

    return @"/user/mobileReg";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
    return @{
             @"nickName": _nickname,
             @"pwd": _password,
             @"code":_code,
             @"mobile":_mobile};
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
