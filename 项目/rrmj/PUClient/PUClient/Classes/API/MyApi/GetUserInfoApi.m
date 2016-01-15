//
//  GetUserInfoApi.m
//  PUClient
//
//  Created by RRLhy on 15/7/22.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "GetUserInfoApi.h"

@implementation GetUserInfoApi
{
    NSString * _userId;
}
- (id)initWithUserId:(NSString *)userId
{
    self = [super init];
    if (self) {
        _userId = userId;
    }
    return self;
}

/**
 *  api借口
 *
 *  @return 返回借口字段
 */
- (NSString*)requestUrl
{
    return @"";
}
/**
 *  请求方式
 *
 *  @return 返回请求方式
 */
- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPost;
}
/**
 *  请求参数格式
 *
 *  @return 返回所需要的参数
 */
- (id)requestArgument
{
    return @{@"id":_userId};
}
/**
 *  校正返回的数据结果
 *
 *  @return 返回结果格式
 */
- (id)jsonValidator
{
    return @{ @"nick": [NSString class],
              @"level": [NSNumber class]};
}
/**
 *  设置缓存
 *
 *  @return 返回缓存持续的时间
 */
- (NSInteger)cacheTimeInSeconds {
    // 3分钟 = 180 秒
    return 60 * 3;
}

@end
