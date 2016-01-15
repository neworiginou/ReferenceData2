//
//  HWRecordModel.h
//  Community
//
//  Created by caijingpeng.haowu on 14-12-13.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//
//  我参与的详情  砍价记录

#import <Foundation/Foundation.h>

@interface HWRecordModel : NSObject

//@property (nonatomic, strong) NSString *recordId;
//@property (nonatomic, strong) NSString *productId;
//@property (nonatomic, strong) NSString *cutPrice;
//@property (nonatomic, strong) NSString *cutUserId;
//@property (nonatomic, strong) NSString *poundage;
//@property (nonatomic, strong) NSString *source;
//@property (nonatomic, strong) NSString *winUserId;
//@property (nonatomic, strong) NSString *productStatus;  // 商品活动状态（商品状态：0未开始，1 进行中，2流标，3已开奖）
//@property (nonatomic, strong) NSString *guessCount;
//@property (nonatomic, strong) NSString *productName;
//@property (nonatomic, strong) NSString *cutTime;
//@property (nonatomic, strong) NSString *samePriceCount;
//@property (nonatomic, strong) NSString *isLowest;
//@property (nonatomic, strong) NSString *lessPriceCount;
//@property (nonatomic, strong) NSString *startTimeStr;
//@property (nonatomic, strong) NSString *bigImg;
//@property (nonatomic, strong) NSString *smallImg;
//@property (nonatomic, strong) NSString *startTime;

@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *cutPrice;
@property (nonatomic, strong) NSString *isLowest;
@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *samePriceTimes;
@property (nonatomic, strong) NSString *uniqueLowerTimes;

- (id)initWithRecord:(NSDictionary *)info;

@end
