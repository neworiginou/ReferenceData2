//
//  HWRentsData.h
//  Community
//
//  Created by lizhongqiang on 14-9-11.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//  租售数据单例类

#import <Foundation/Foundation.h>

@interface HWRentsData : NSObject

@property (nonatomic, strong) NSString *strIntention;               //租售意向
@property (nonatomic, strong) NSString *strName;                    //名字
@property (nonatomic, strong) NSString *strPhone;                   //电话
@property (nonatomic, strong) NSString *strAddress;                 //地址
@property (nonatomic, strong) NSString *strArea;                    //面积
@property (nonatomic, strong) NSString *strHuXing;                  //户型
@property (nonatomic, strong) NSString *buildNo;                    //楼号
@property (nonatomic, strong) NSString *roomNo;                     //房号
+ (HWRentsData *)getRentsData;

@end
