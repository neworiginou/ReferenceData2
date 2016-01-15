//
//  ReviewApi.m
//  PUClient
//
//  Created by RRLhy on 15/8/17.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "ReviewApi.h"

@implementation ReviewApi
{
    NSString * _type;
    NSString * _page;
}
- (id)initWithType:(NSString *)type page:(NSString *)page
{
    self = [super init];
    if (self) {
        _type = type;
        _page = page;
    }
    return self;
}

- (NSString*)requestUrl
{
    return @"/report/list";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPost;
}

- (id)requestArgument
{
    return @{@"page":_page,@"type":_type,@"rows":@"20"};
}
@end
