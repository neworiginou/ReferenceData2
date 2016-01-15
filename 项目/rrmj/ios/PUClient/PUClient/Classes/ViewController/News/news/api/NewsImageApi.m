//
//  NewsImageApi.m
//  PUClient
//
//  Created by RRLhy on 15/8/17.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "NewsImageApi.h"

@implementation NewsImageApi
{
    NSString * _infoId;
    NSString * _userId;
}
- (id)initWithInfoId:(NSString *)infoId userID:(NSString *)userId
{
    self = [self init];
    if (self) {
        _infoId = infoId;
        if (_userId) {
            _userId = userId;
        }else{
            _userId = @"";
        }
    }
    return self;
}

- (NSString*)requestUrl
{
    return @"/info/detail4Wrap";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPost;
}

- (id)requestArgument
{
    return @{@"infoId":_infoId,
        @"userId":_userId};
}
@end
