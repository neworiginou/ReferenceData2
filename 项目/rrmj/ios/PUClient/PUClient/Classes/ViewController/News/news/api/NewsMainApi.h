//
//  NewsMainApi.h
//  PUClient
//
//  Created by RRLhy on 15/8/12.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "YTKRequest.h"

@interface NewsMainApi : YTKRequest

- (id)initWithNewsPage:(NSString*)page newRow:(NSString*)row;

@end
