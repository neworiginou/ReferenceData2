//
//  Bound3Api.m
//  PUClient
//
//  Created by RRLhy on 15/8/4.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "Bound3Api.h"

@implementation Bound3Api
{
    NSString * _platName;
    NSString * _uid;
    NSString * _userName;
    NSString * _token;
}
- (id)initWith3rdPlatName:(NSString *)platName uid:(NSString *)uid userName:(NSString *)userName token:(NSString *)userToken
{
    self = [super init];
    if (self) {
        _platName = platName;
        _uid = uid;
        _userName = userName;
        _token = userToken;
    }
    return self;
}

- (NSString*)requestUrl
{
    return @"/user/bindAccount";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPost;
}

- (id)requestArgument
{
    return @{@"plat":_platName,
             @"uid":_uid,
             @"name":_userName,
             @"token":_token};
}

@end
