//
//  NewsCommentApi.m
//  PUClient
//
//  Created by RRLhy on 15/8/13.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "NewsCommentApi.h"

@implementation NewsCommentApi
{
    NSString * _newsID;
    NSString * _page;
}
- (id)initWithNewsId:(NSString *)newsID commentPage:(NSString *)page
{
    self = [super init];
    if (self) {
        if (newsID) {
             _newsID = newsID;
        }else{
             _newsID = @"";
        }
  
        _page = page;
    }
    return self;
}

- (NSString*)requestUrl
{
    return @"/comment/list";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPost;
}

- (id)requestArgument
{
    return @{@"infoId":_newsID,
             @"page":_page};
}


@end
