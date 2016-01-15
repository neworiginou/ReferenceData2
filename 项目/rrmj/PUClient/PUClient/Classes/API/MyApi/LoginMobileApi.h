//
//  LoginMobileApi.h
//  PUClient
//
//  Created by RRLhy on 15/7/27.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "YTKBaseRequest.h"

@interface LoginMobileApi : YTKBaseRequest

- (id)initWithUserMobile:(NSString *)mobile password:(NSString *)password;

@end
