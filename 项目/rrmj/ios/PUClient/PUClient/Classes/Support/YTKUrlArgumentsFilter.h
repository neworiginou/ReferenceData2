//
//  YTKUrlArgumentsFilter.h
//  PUClient
//
//  Created by RRLhy on 15/7/22.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YTKNetworkConfig.h>
@interface YTKUrlArgumentsFilter : NSObject<YTKUrlFilterProtocol>

+ (YTKUrlArgumentsFilter *)filterWithArguments:(NSDictionary *)arguments;

- (NSString *)filterUrl:(NSString *)originUrl withRequest:(YTKBaseRequest *)request;

@end
