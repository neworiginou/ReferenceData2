//
//  HWPropertyDetailClass.h
//  Community
//
//  Created by caijingpeng.haowu on 14-8-27.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//
//  物业详情数据模型
//

#import <Foundation/Foundation.h>

@interface HWPropertyDetailClass : NSObject

@property (nonatomic, strong) NSString *tenementId;                 //物业ID
@property (nonatomic, strong) NSString *name;                       //物业名称
@property (nonatomic, strong) NSString *intro;                      //物业介绍
@property (nonatomic, strong) NSString *address;                    //物业地址
@property (nonatomic, strong) NSString *openTime;                   //服务时间
//@property (nonatomic, strong) NSString *tenementTel;                //电话        可能为多个，一期只展示一个
@property (nonatomic, strong) NSArray *tenementTel;
@property (nonatomic, strong) NSString *callTimes;                  //拨打次数
@property (nonatomic, strong) NSString *coStatus;                   //合作物业      0 合作      1 未合作
//@property (nonatomic, strong) NSArray *serviceCatagory;             //提供的服务
@property (nonatomic, strong) NSMutableArray *arrServiceTrack;      //物业动态
@property (nonatomic, strong) NSMutableArray *arrPropertyService;   //物业提供的服务

- (id)initWithDictionary:(NSDictionary *)dic;

@end
