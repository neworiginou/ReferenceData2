//
//  NSString+KuoZhanFangFa.m
//  searchTest
//
//  Created by 孙鹏 on 14-8-29.
//  Copyright (c) 2014年 ___sp___. All rights reserved.
//

#import "NSString+KuoZhanFangFa.h"

@implementation NSString (KuoZhanFangFa)


//传入 中国  返回 zhong guo
+ (NSString*)HanZiZhuanPinYinYeah:(NSString*)HanZiStr
{

    CFStringRef aCFString = (__bridge CFStringRef)HanZiStr;
    CFMutableStringRef string = CFStringCreateMutableCopy(NULL, 0, aCFString);
    CFStringTransform(string, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform(string, NULL, kCFStringTransformStripDiacritics, NO);
    //CFRelease(string);

    return (__bridge NSString*)string;
}

- (NSComparisonResult)stringCompare:(NSString *)otherStr
{
    if(self == otherStr) return NSOrderedSame;
    return (self < otherStr ? NSOrderedAscending : NSOrderedDescending);
}

@end
