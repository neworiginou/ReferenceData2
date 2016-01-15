//
//  RegisterApi.m
//  PUClient
//
//  Created by RRLhy on 15/7/22.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "RegisterApi.h"

@implementation RegisterApi
{
    NSString *_password;
    NSString *_mobile;
    NSString *_nickname;
    NSString *_email;
}

- (id)initWithMobile:(NSString*)mobile nickName:(NSString*)nickname passWord:(NSString*)password Email:(NSString*)email
{
    self = [super init];
    
    if (self) {
        
        _nickname = nickname;
        _mobile = mobile;
        _password = password;
        _email = email;
    }
    return self;
}

- (NSString *)requestUrl {

    return @"/appUser/app/register";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
    return @{
             @"nickName": _nickname,
             @"pwd": _password,
             @"email":_email,
             @"mobile":_mobile};
}

@end
