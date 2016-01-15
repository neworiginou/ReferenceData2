//
//  AddHotStarApi.m
//  PUClient
//
//  Created by RRLhy on 15/7/28.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "AddHotStarApi.h"

@implementation AddHotStarApi
{
    NSString * _token;
    NSString * _idString;
}

- (id)initWithUserToken:(NSString *)token groupIdStr:(NSString *)idString
{
    self = [super init];
    if (self) {
        _token = token;
        _idString = idString;
    }
    return self;
}

- (NSString*)requestUrl
{
    return @"/user/addFocusGroup";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPost;
}

- (id)requestArgument
{
    return @{@"token":_token,@"groupIdStr":_idString};
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
