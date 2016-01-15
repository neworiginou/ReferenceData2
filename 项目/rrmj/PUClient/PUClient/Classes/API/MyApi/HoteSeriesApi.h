//
//  HoteSeriesApi.h
//  PUClient
//
//  Created by RRLhy on 15/7/27.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "YTKBaseRequest.h"

@interface HoteSeriesApi : YTKBaseRequest
/**
 *  获取热门热门列表
 *
 *  @param token 用户token
 *
 *  @return 返回剧集列表api
 */
- (id)initWithUserToken:(NSString*)token;

@end
