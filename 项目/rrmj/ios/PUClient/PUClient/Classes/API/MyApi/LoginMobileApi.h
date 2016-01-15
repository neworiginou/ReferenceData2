//
//  LoginMobileApi.h
//  PUClient
//
//  Created by RRLhy on 15/7/27.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "YTKBaseRequest.h"

@interface LoginMobileApi : YTKBaseRequest
/**
 *  手机登陆
 *
 *  @param mobile   手机号
 *  @param password 密码
 *
 *  @return api
 */
- (id)initWithUserMobile:(NSString *)mobile password:(NSString *)password;

@end
