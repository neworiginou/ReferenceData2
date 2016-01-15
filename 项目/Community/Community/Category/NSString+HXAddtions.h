//
//  NSString+HXAddtions.h
//  Community
//
//  Created by gusheng on 14-9-18.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HXAddtions)
+(NSString *) jsonStringWithDictionary:(NSDictionary *)dictionary;
+(NSString *) jsonStringWithArray:(NSArray *)array;
+(NSString *) jsonStringWithString:(NSString *) string;
+(NSString *) jsonStringWithObject:(id) object;
@end
