//
//  ModifiedPwdApi.m
//  PUClient
//
//  Created by RRLhy on 15/8/4.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "ModifiedPwdApi.h"

@implementation ModifiedPwdApi
{
    NSString * _userId;
    NSString * _oldPwd;
    NSString * _newPwd;
}
- (id)initWithUserId:(NSString *)userID oldPwd:(NSString *)oldPwd newPwd:(NSString *)newPwd
{
    self = [super init];
    if (self) {
        _userId = userID;
        _oldPwd = oldPwd;
        _newPwd = newPwd;
    }
    return self;
}

- (NSString*)requestUrl
{
    return @"/user/resetPwd";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPost;
}

- (id)requestArgument
{
    return @{@"id":_userId,
             @"oldPwd":_oldPwd,
             @"newPwd":_newPwd};
}


@end
