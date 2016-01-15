//
//  HotStarApi.h
//  PUClient
//
//  Created by RRLhy on 15/7/27.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "YTKBaseRequest.h"

@interface HotStarApi : YTKBaseRequest
/**
 *  获取热门后援团列表
 *
 *  @param token       登录token
 *  @param seriesIdArr 上一步选择的剧集
 *
 *  @return 返回列表api
 */
- (id)initWithUserToken:(NSString *)token SeriesIdArr:(NSString *)seriesIdArr;
@end
