//
//  NewsCommentApi.h
//  PUClient
//
//  Created by RRLhy on 15/8/13.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "YTKRequest.h"

@interface NewsCommentApi : YTKRequest
/**
 *  资讯详情页评论列表api
 *
 *  @param newsID 资讯id
 *  @param page   椰树
 *
 *  @return api
 */
- (id)initWithNewsId:(NSString*)newsID commentPage:(NSString*)page;

@end
