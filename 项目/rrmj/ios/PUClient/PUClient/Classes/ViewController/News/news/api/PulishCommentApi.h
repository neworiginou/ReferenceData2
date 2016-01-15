//
//  PulishCommentApi.h
//  PUClient
//
//  Created by RRLhy on 15/8/17.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "YTKRequest.h"

@interface PulishCommentApi : YTKRequest
/**
 *  发表评论
 *
 *  @param infoId         资讯id
 *  @param content        评论内容
 *  @param parentId       父评论的id
 *  @param parentContent  父评论的内容
 *  @param parentAuthorId 父评论作者id
 *  @param sychSeries     是否同步到美剧圈
 *
 *  @return api
 */
- (id)initWithInfoId:(NSString*)infoId infoContent:(NSString*)content parentCommentId:(NSString*)parentId parentContent:(NSString*)parentContent parentAuthorId:(NSString*)parentAuthorId copy2Active:(NSString*)sychSeries;
@end
