//
//  NewsIntroModel.m
//  PUClient
//
//  Created by RRLhy on 15/8/12.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "NewsIntroModel.h"

@implementation NewsIntroModel

/**
 *  字典和模型不对应，手动写对应关系
 */
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"ID" : @"id"};
}

@end
