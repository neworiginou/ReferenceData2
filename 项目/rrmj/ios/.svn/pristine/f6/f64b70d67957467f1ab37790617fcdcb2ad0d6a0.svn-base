//
//  MySilverApi.m
//  PUClient
//
//  Created by RRLhy on 15/8/5.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "MySilverApi.h"

@implementation MySilverApi
{
    NSString * _userId;
    NSString * _page;
    NSString * _rows;
}
- (id)initWithUserId:(NSString *)userId Page:(NSString *)page Rows:(NSString *)rows
{
    self = [super init];
    if (self) {
        _userId = userId;
        _page = page;
        _rows = rows;
    }
    return self;
}

- (NSString*)requestUrl
{
    return @"/user/silver";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPost;
}

- (id)requestArgument
{
    return @{@"userId":_userId,
             @"page":_page,
             @"rows":_rows};
}

@end
