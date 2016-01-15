//
//  HWShopTypeClass.h
//  Community
//
//  Created by lizhongqiang on 14-9-11.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//  商铺类型

#import <Foundation/Foundation.h>

@interface HWShopTypeClass : NSObject
@property (nonatomic, strong) NSString *serviceId;              //
@property (nonatomic, strong) NSString *serviceName;            //
@property (nonatomic, strong) NSString *serviceIcon;            //

- (id)initWithDictionary:(NSDictionary *)dic;

@end
