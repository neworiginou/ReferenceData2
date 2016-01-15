//
//  BoundOldApi.h
//  PUClient
//
//  Created by RRLhy on 15/7/27.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "YTKBaseRequest.h"

@interface BoundOldApi : YTKBaseRequest

- (id)initWithUserId:(NSString*)userId platformName:(NSString*)platformName loginName:(NSString*)loginName passWord:(NSString *)pwd;

@end
