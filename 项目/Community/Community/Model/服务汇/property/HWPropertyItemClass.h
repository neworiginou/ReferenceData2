//
//  HWPropertyItemClass.h
//  Community
//
//  Created by lizhongqiang on 14-9-11.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//  服务汇首页 物业

#import <Foundation/Foundation.h>

@interface HWPropertyItemClass : NSObject
@property (nonatomic, strong) NSString *propertyId;             //物业ID
@property (nonatomic, strong) NSString *propertyName;           //物业名称
@property (nonatomic, strong) NSString *dialCount;              //电话拨打次数
@property (nonatomic, strong) NSString *iconUrl;                //物业图片
@property (nonatomic, strong) NSString *phoneNumber;            //电话号码
@property (nonatomic, strong) NSString *publicInform;           //公告

- (id)initWithDictionary:(NSDictionary *)dic;

@end
