//
//  NewsMainApi.m
//  PUClient
//
//  Created by RRLhy on 15/8/12.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "NewsMainApi.h"

@implementation NewsMainApi
{
    NSString * _page;
    NSString * _row;
}
- (id)initWithNewsPage:(NSString *)page newRow:(NSString *)row
{
    self = [super init];
    if (self) {
        _page = page;
        _row = row;
    }
    return self;
}

- (NSString*)requestUrl
{
    return @"/info/infoList";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPost;
}

- (id)requestArgument
{
    return @{@"page":_page,
             @"rows":_row};
}

@end
