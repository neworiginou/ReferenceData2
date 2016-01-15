//
//  NSString+SHA1.h
//  Community
//
//  Created by caijingpeng.haowu on 14-10-17.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(SHA1)

- (NSString*)sha1;
- (NSString *)md5:(NSString *)str;

+ (NSString *)encodeToPercentEscapeString: (NSString *) input;
+ (NSString *)decodeFromPercentEscapeString: (NSString *) input;
@end
