//
//  GetUserInfoApi.h
//  PUClient
//
//  Created by RRLhy on 15/7/22.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "YTKBaseRequest.h"

@interface GetUserInfoApi : YTKBaseRequest

- (id)initWithUserId:(NSString *)userId;

@end
