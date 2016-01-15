//
//  HWServiceItemClass.h
//  Community
//
//  Created by caijingpeng.haowu on 14-8-27.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//
//  服务汇 首页 列表项 数据模型
// 

#import <Foundation/Foundation.h>
#import "HWPropertyItemClass.h"
#import "HWShopItemClass.h"

@interface HWServiceItemClass : NSObject

//@property (nonatomic, strong)NSMutableArray *propertyArray;         //物业

@property (nonatomic, strong) HWPropertyItemClass *propertyDic;     //
@property (nonatomic, strong)NSMutableArray *shopArray;             //商铺
- (id)initWithDictionary:(NSDictionary *)dic;
@end
