//
//  NewsImageApi.h
//  PUClient
//
//  Created by RRLhy on 15/8/17.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "YTKRequest.h"

@interface NewsImageApi : YTKRequest

- (id)initWithInfoId:(NSString*)infoId userID:(NSString*)userId;

@end
