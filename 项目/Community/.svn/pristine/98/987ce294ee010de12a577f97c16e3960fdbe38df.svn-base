//
//  NSDictionary+Utils.m
//  LoveClub
//
//  Created by huangpeng on 13-7-21.
//  Copyright (c) 2013年 LoveClubbing. All rights reserved.
//

#import "NSDictionary+Utils.h"

@implementation NSMutableDictionary(Utils)

- (void)setPObject:(id)anObject forKey:(id<NSCopying>)aKey {
    if(anObject==nil)
        [self setObject:@"" forKey:aKey];
    else
        [self setObject:anObject forKey:aKey];
}


@end


@implementation NSDictionary(Utils)

- (NSArray *)arrayObjectForKey:(NSString *)akey
{
    id obj = [self objectForKey:akey];
    if([obj isKindOfClass:[NSNull class]]||![obj isKindOfClass:[NSArray class]])
        return [NSArray array];
    else
    {
        NSMutableArray *resultArr = [NSMutableArray array];
        NSArray *resourceArr = obj;
        for (int i = 0; i < resourceArr.count; i++) {
            id arrObj = [resourceArr pObjectAtIndex:i];
            if (arrObj != nil)
            {
                [resultArr addObject:arrObj];
            }
        }
        return resultArr;
    }
    return nil;
}

- (id)stringObjectForKey:(id)aKey
{
    id obj = [self objectForKey:aKey];
    if([obj isKindOfClass:[NSNull class]] || obj == nil)
        return @"";
    else
        return [NSString stringWithFormat:@"%@",obj];
}

- (id)numberObjectForKey:(id)aKey
{
    id obj = [self objectForKey:aKey];
    if([obj isKindOfClass:[NSNull class]] || obj == nil)
        return @"";
    else
        return [NSString stringWithFormat:@"%@",obj];
}

- (NSDictionary *)dictionaryObjectForKey:(id)aKey
{
    id obj = [self objectForKey:aKey];
    if([obj isKindOfClass:[NSNull class]]||![obj isKindOfClass:[NSDictionary class]])
        return [NSDictionary dictionary];
    else
        return (NSDictionary*)obj;
}

@end
