//
//  LoginMobileApi.m
//  PUClient
//
//  Created by RRLhy on 15/7/27.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "LoginMobileApi.h"

@implementation LoginMobileApi
{
    NSString * _mobile;
    NSString * _passWord;
}
- (id)initWithUserMobile:(NSString *)mobile password:(NSString *)password
{
    self = [super init];
    if (self) {
        
        _mobile = mobile;
        _passWord = password;
        
    }
    return self;
}

- (NSString*)requestUrl
{
    return @"/appUser/app/login/mobile";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPost;
}

- (id)requestArgument
{
    return @{@"mobile":_mobile,
             @"password":_passWord};
}

@end
