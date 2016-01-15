//
//  NSString+TF.m
//  test
//
//  Created by Tengfei on 15/5/8.
//  Copyright (c) 2015年 tengfei. All rights reserved.
//

#import "NSString+TF.h"
#import <CommonCrypto/CommonDigest.h>

static NSString *token = @"fashfkdashfjkldashfjkdashfjkdahsfjdasjkvcxnm%^&%^$&^uireqwyi1237281643";

@implementation NSString (TF)

 - (NSString *)MD5
{
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(cStr, strlen(cStr), digest);
    
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    return result;
}
@end
