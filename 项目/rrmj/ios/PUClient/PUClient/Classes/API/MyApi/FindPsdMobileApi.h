//
//  FindPsdMobile.h
//  PUClient
//
//  Created by RRLhy on 15/7/27.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "YTKBaseRequest.h"

@interface FindPsdMobileApi : YTKBaseRequest

/**
 *  手机找回密码
 *
 *  @param mobile 手机号
 *  @param code   验证码
 *  @param psd    新密码
 *
 *  @return api  对象
 */
- (id)initWithUserMobile:(NSString*)mobile code:(NSString*)code passWord:(NSString*)psd;

@end
