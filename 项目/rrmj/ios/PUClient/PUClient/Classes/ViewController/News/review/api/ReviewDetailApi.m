//
//  ReviewDetailApi.m
//  PUClient
//
//  Created by RRLhy on 15/8/17.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "ReviewDetailApi.h"

@implementation ReviewDetailApi
{
    NSString * _reviewId;
    NSString * _userId;
}
- (id)initWithReviewId:(NSString *)reviewID userId:(NSString *)userId
{
    self = [super init];
    if (self) {
        
        if (userId) {
            _userId = userId;
        }else
        {
            _userId = @"";
        }
        
        if (reviewID) {
            _reviewId = reviewID;
        }else{
             _reviewId = @"";
        }
    }
    return self;
}

- (NSString*)requestUrl
{
    return @"/report/detail";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPost;
}

- (id)requestArgument
{
    return @{@"reprotId":_reviewId,@"userId":_userId};
}

@end
