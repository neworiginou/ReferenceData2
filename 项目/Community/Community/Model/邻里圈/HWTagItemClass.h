//
//  HWTagItemClass.h
//  Community
//
//  Created by zhangxun on 14-9-16.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWTagItemClass : NSObject

@property (nonatomic,strong)NSString *tagId;
@property (nonatomic,strong)NSString *tagContent;
@property (nonatomic,strong)NSString *tagCount;

- (void)fillWithDictionary:(NSDictionary *)dictionary;
@end
