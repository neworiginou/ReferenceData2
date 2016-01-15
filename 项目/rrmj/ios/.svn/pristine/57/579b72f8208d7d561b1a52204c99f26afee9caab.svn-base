//
//  Bound3rdApi.m
//  PUClient
//
//  Created by RRLhy on 15/8/4.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "Bound3rdApi.h"

@implementation Bound3rdApi
{
    NSString * _token;
}
- (id)initWithUserToken:(NSString *)userToken
{
    self = [super init];
    if (self) {
        _token = userToken;
    }
    return self;
}

- (NSString*)requestUrl
{
    return @"/user/3rdAccount";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPost;
}

- (id)requestArgument
{
    return @{@"token":_token};
}

@end
