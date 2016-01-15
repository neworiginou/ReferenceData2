//
//  PsdCodeApi.m
//  PUClient
//
//  Created by RRLhy on 15/7/28.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "PsdCodeApi.h"

@implementation PsdCodeApi
{
    NSString * _phone;
}
- (id)initWithUserPhone:(NSString *)phone
{
    self = [super init];
    if (self) {
        _phone = phone;
    }
    return self;
}

- (NSString*)requestUrl
{
    return @"/user/sendCaptcha";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPost;
}

-(id)requestArgument
{
    return @{@"mobile":_phone};
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
