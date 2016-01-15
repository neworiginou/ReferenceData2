//
//  HotSeriesModel.m
//  PUClient
//
//  Created by RRLhy on 15/7/28.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "HotSeriesModel.h"

@implementation HotSeriesModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

/**
 *  字典和模型不对应，手动写对应关系
 */
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"Id" : @"id"};
}
@end
