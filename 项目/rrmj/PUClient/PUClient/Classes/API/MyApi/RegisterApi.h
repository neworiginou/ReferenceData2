//
//  RegisterApi.h
//  PUClient
//
//  Created by RRLhy on 15/7/22.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "YTKBaseRequest.h"
/* mobile
 nickName
 pwd
 email*/
@interface RegisterApi : YTKBaseRequest

/**
 *  手机注册接口
 *
 *  @param mobile   手机号
 *  @param nickname 昵称
 *  @param password 密码
 *  @param email    邮箱号（暂不用填）
 *
 *  @return 手机注册对象
 */
- (id)initWithMobile:(NSString*)mobile nickName:(NSString*)nickname passWord:(NSString*)password Email:(NSString*)email;

@end
