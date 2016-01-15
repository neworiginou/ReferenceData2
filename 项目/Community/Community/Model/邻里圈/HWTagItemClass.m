//
//  HWTagItemClass.m
//  Community
//
//  Created by zhangxun on 14-9-16.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWTagItemClass.h"

@implementation HWTagItemClass

- (void)dealloc
{
    self.tagId = nil;
    self.tagContent = nil;
    self.tagCount = nil;
}

- (void)fillWithDictionary:(NSDictionary *)dictionary
{
//    NSLog(@"%@",dictionary);
    self.tagId = [dictionary stringObjectForKey:@"tagId"];
    self.tagContent = [dictionary stringObjectForKey:@"tagName"];
    self.tagCount = [dictionary stringObjectForKey:@"tagCount"];
}

@end
