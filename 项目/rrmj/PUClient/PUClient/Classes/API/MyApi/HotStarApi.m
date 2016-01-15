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
    return @"/appUser/stars/rec/list";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodGet;
}

- (id)requestArgument
{
    return @{@"token":_token,
             @"seriesIdArr":_seriesIdArr};
}

@end
