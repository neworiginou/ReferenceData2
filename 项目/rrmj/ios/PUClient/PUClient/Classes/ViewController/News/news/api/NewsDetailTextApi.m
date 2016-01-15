//
//  NewsDetailTextApi.m
//  PUClient
//
//  Created by RRLhy on 15/8/13.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "NewsDetailTextApi.h"

@implementation NewsDetailTextApi
{
    NSString * _newsID;
    NSString * _userID;
}

- (id)initWithNewsId:(NSString *)newsID userId:(NSString *)userID
{
    self =[super init];
    if (self) {
        
        if (newsID) {
             _newsID = newsID;
        }else{
             _newsID = @"";
        }

        if (userID) {
            _userID = userID;
        }else{
            _userID = @"";
        }
    }
    return self;
}


- (NSString*)requestUrl
{
    return @"/info/detail";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPost;
}

- (id)requestArgument
{
    return @{@"infoId":_newsID,
             @"userId":_userID};
}
@end
