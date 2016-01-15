//
//  ClearCountApi.m
//  PUClient
//
//  Created by RRLhy on 15/8/4.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "ClearCountApi.h"

@implementation ClearCountApi
{
    NSString * _token;
    NSString * _name;
}
- (id)initWithUserToken:(NSString *)token platName:(NSString *)name
{
    self = [super init];
    if (self) {
        _token = token;
        _name = name;
    }
    return self;
}

- (NSString*)requestUrl
{
    return @"/user/unbindAccount";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPost;
}

- (id)requestArgument
{
    return @{@"token":_token,
             @"plat":_name};
}

@end
