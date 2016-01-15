//
//  NewsDetailTextApi.h
//  PUClient
//
//  Created by RRLhy on 15/8/13.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "YTKRequest.h"

@interface NewsDetailTextApi : YTKRequest
/**
 *  文字资讯详情api
 *
 *  @param newsID 资讯的id
 *  @param userID 用户id
 *
 *  @return api
 */
- (id)initWithNewsId:(NSString*)newsID userId:(NSString*)userID;
@end
