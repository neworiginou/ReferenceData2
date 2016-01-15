//
//  SignApi.m
//  PUClient
//
//  Created by RRLhy on 15/8/5.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "SignApi.h"

@implementation SignApi
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

- (NSString *)requestUrl
{
    return @"/user/sign";
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
