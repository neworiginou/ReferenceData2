//
//  HoteSeriesApi.m
//  PUClient
//
//  Created by RRLhy on 15/7/27.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "HoteSeriesApi.h"

@implementation HoteSeriesApi
{
    NSString * _token;
}

- (id)initWithUserToken:(NSString *)token
{
    self = [super init];
    if (self) {
        _token = token;
    }
    return self;
}

- (NSString*)requestUrl
{
    return @"/appUser/stars/rec/list";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodGet;
}

- (id)requestArgument
{
    return @{@"token":_token};
}

@end
