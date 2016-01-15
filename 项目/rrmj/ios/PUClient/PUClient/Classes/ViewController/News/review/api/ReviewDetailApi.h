//
//  ReviewDetailApi.h
//  PUClient
//
//  Created by RRLhy on 15/8/17.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReviewDetailApi : YTKRequest

- (id)initWithReviewId:(NSString*)reviewID userId:(NSString*)userId;

@end
