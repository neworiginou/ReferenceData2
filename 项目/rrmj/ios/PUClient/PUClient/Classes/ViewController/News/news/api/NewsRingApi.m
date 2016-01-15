//
//  NewsRingApi.m
//  PUClient
//
//  Created by RRLhy on 15/8/12.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "NewsRingApi.h"

@implementation NewsRingApi
{
    NSString * _page;
    NSString * _row;
}

- (id)initWithPage:(NSString*)page rows:(NSString*)row
{
    self = [super init];
    if (self) {
        
        _page = page;
        _row  = row;
    }
    return self;
}

- (NSString*)requestUrl
{
    return @"/constant/infoTop";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPost;
}

- (id)requestArgument
{
    return @{@"page":_page,@"rows":_row};
}

@end
