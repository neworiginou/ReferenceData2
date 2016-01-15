//
//  SuggestApi.h
//  PUClient
//
//  Created by RRLhy on 15/8/5.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "YTKRequest.h"

@interface SuggestApi : YTKRequest
/**
 *   意见反馈
 *
 *  @param contnt  反馈内容
 *  @param contact 联系方式
 *  @param source  来源
 *
 *  @return api对象
 */
- (id)initWithWithContent:(NSString*)content Contact:(NSString*)contact Source:(NSString*)source;

@end
