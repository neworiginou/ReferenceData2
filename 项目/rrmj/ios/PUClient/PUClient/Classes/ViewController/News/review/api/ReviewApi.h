//
//  ReviewApi.h
//  PUClient
//
//  Created by RRLhy on 15/8/17.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "YTKRequest.h"

@interface ReviewApi : YTKRequest

- (id)initWithType:(NSString*)type page:(NSString*)page;

@end
