//
//  HWCutResultModel.h
//  Community
//
//  Created by lizhongqiang on 15/4/28.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWCutResultModel : NSObject

@property (nonatomic, strong) NSString *award;                      //是否中奖
@property (nonatomic, strong) NSString *bonus;                      //中奖金额
@property (nonatomic, strong) NSString *createTime;                 //
@property (nonatomic, strong) NSString *cutPrice;                   //砍价金额
@property (nonatomic, strong) NSString *isLowest;                   //是否最低
@property (nonatomic, strong) NSString *kaoLabonus;                 //中奖考拉币
@property (nonatomic, strong) NSString *productId;                  //
@property (nonatomic, strong) NSString *samePriceTimes;             //相同次数
@property (nonatomic, strong) NSString *uniqueLowerTimes;           //更低唯一价次数

- (id)initWithDict:(NSDictionary *)info;

@end
