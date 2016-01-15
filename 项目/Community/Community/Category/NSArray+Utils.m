//
//  NSArray+NSArray_Utils.m
//  HaoWu_4.0
//
//  Created by caijingpeng.haowu on 14-6-10.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "NSArray+Utils.h"

@implementation NSArray (Utils)

- (id)pObjectAtIndex:(NSUInteger)index
{
    if (index >= self.count || [[self objectAtIndex:index] isKindOfClass:[NSNull class]])
    {
        return nil;
    }
    return [self objectAtIndex:index];
}

@end
