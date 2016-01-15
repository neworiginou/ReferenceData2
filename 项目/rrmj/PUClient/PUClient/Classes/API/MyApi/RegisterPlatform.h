//
//  RegisterPlatform.h
//  PUClient
//
//  Created by RRLhy on 15/7/27.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "YTKBaseRequest.h"

@interface RegisterPlatform : YTKBaseRequest

- (id)initWithUserId:(NSString *)userid PlatformName:(NSString *)platformName NickName:(NSString*)nickname IconUrl:(NSString*)iconurl;

@end
