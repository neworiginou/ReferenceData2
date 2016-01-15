//
//  FindPsdEmailApi.h
//  PUClient
//
//  Created by RRLhy on 15/7/27.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "YTKBaseRequest.h"

@interface FindPsdEmailApi : YTKBaseRequest
/**
 *  邮箱找回密码
 *
 *  @param email 邮箱号
 *
 *  @return api 对象
 */
- (id)initWithUserEmail:(NSString*)email;

@end
