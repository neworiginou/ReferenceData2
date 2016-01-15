//
//  HWPicUrlsClass.h
//  Community
//
//  Created by lizhongqiang on 14-9-11.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//  店铺图片 最多5张

#import <Foundation/Foundation.h>

@interface HWPicUrlsClass : NSObject
@property (nonatomic, strong) NSString *pic1;
@property (nonatomic, strong) NSString *pic2;
@property (nonatomic, strong) NSString *pic3;
@property (nonatomic, strong) NSString *pic4;
@property (nonatomic, strong) NSString *pic5;

- (id)initWithDictionary:(NSDictionary *)dic;

@end
