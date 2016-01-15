//
//  HWCatoryClass.h
//  Community
//
//  Created by gusheng on 14-9-21.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWCatoryClass : NSObject
@property(nonatomic,strong)NSString* catoryId;
@property(nonatomic,strong)NSString* catoryName;
@property(nonatomic,strong)NSURL* catoryImageUrl;
-(id)initWithDic:(NSDictionary *)dic;
@end
