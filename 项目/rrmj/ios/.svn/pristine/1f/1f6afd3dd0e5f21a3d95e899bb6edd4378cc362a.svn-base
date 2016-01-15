//
//  HotStarApi.m
//  PUClient
//
//  Created by RRLhy on 15/7/27.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "HotStarApi.h"

@implementation HotStarApi
{
    NSString * _token;
    NSString * _seriesIdArr;
}
- (id)initWithUserToken:(NSString *)token SeriesIdArr:(NSString *)seriesIdArr
{
    self = [super init];
    if (self) {
        _token = token;
        _seriesIdArr = seriesIdArr;
    }
    return self;
}

- (NSString *)requestUrl
{
    return @"/user/recStar";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPost;
}

- (id)requestArgument
{
    return @{@"token":_token,
             @"seriesIdArr":_seriesIdArr};
}

- (NSTimeInterval)requestTimeoutInterval
{
    return 5 * 60;
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
