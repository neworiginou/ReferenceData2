//
//  NewsDetailModel.m
//  PUClient
//
//  Created by RRLhy on 15/8/13.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "NewsDetailModel.h"

@implementation NewsDetailModel

/**
 *  字典和模型不对应，手动写对应关系
 */
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"ID" : @"id"};
}

+ (NSDictionary *)objectClassInArray{
    
    return @{ @"actorViewList" : @"ActorModel",
              @"seriesViewList" : @"SeriesModel",
              @"paragraphViewList":@"NewImageModel"};
}

@end
