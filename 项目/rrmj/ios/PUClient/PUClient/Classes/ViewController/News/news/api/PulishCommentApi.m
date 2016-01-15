//
//  PulishCommentApi.m
//  PUClient
//
//  Created by RRLhy on 15/8/17.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "PulishCommentApi.h"

@implementation PulishCommentApi
{
    NSString * _infoId;
    NSString * _content;
    NSString * _parentId;
    NSString * _parentContent;
    NSString * _parentAuthorId;
    NSString * _sychSeries;
}
- (id)initWithInfoId:(NSString *)infoId infoContent:(NSString *)content parentCommentId:(NSString *)parentId parentContent:(NSString *)parentContent parentAuthorId:(NSString *)parentAuthorId copy2Active:(NSString*)sychSeries
{
    self = [super init];
    if (self) {
        _infoId = infoId;
        _content = content;
        _parentAuthorId = parentAuthorId;
        _parentContent = parentContent;
        _parentId = parentId;
        _sychSeries = sychSeries;
    }
    return self;
}

- (NSString*)requestUrl
{
    return @"/comment/create";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPost;
}

- (id)requestArgument
{
    return @{@"infoId":_infoId,
             @"content":_content,
             @"parentCommentId":_parentId,
             @"parentContent":_parentContent,
             @"parentAuthorId":_parentAuthorId,
             @"copy2Active":_sychSeries,
             @"token":[UserInfoConfig sharedUserInfoConfig].userInfo.token};
}
@end
