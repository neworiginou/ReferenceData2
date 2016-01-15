//
//  UploadIconApi.h
//  PUClient
//
//  Created by RRLhy on 15/8/4.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "YTKRequest.h"

@interface UploadIconApi : YTKRequest
/**
 *  修改个人资料
 *
 *  @param image    图像
 *  @param nickname 昵称
 *  @param sex      性别
 *  @param birthday 生日
 *  @param city     城市
 *  @param sign     签名
 *  @param token    token
 *
 *  @return 修改资料api
 */
- (id)initWith:(UIImage*)image nickName:(NSString*)nickname sex:(NSString*)sex birthDay:(NSString*)birthday city:(NSString*)city sign:(NSString*)sign token:(NSString*)token;

@end
