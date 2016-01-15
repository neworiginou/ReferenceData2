//
//  SuggestApi.m
//  PUClient
//
//  Created by RRLhy on 15/8/5.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "SuggestApi.h"

@implementation SuggestApi
{
    NSString * _content;
    NSString * _contact;
    NSString * _source;
}
- (id)initWithWithContent:(NSString *)content Contact:(NSString *)contact Source:(NSString *)source
{
    self = [super init];
    if (self) {
        _contact = contact;
        _content = content;
    }
    return self;
}

- (NSString*)requestUrl
{
    return @"/suggest";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPost;
}

- (id)requestArgument
{
    return @{@"content":_content,@"contact":_contact,@"source":@"ios2.0"};
}

@end
