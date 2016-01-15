//
//  LoginEmailApi.h
//  PUClient
//
//  Created by RRLhy on 15/7/27.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "YTKBaseRequest.h"

@interface LoginEmailApi : YTKBaseRequest

- (id)initWithUserEmail:(NSString *)email password:(NSString *)password;

@end
