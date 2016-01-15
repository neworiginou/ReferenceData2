//
//  HWProductDetailModel.h
//  Community
//
//  Created by lizhongqiang on 15/4/23.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//  砍价 商品详情


#import <Foundation/Foundation.h>

@interface HWProductDetailModel : NSObject
@property (nonatomic, strong) NSString *bigImg;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *creater;
@property (nonatomic, strong) NSString *disabled;
@property (nonatomic, strong) NSString *endTime;
@property (nonatomic, strong) NSString *Id;
@property (nonatomic, strong) NSString *increasePrice;
@property (nonatomic, strong) NSString *joinCount;
@property (nonatomic, strong) NSString *lowestPrice;
@property (nonatomic, strong) NSString *marketPrice;
@property (nonatomic, strong) NSString *modifier;
@property (nonatomic, strong) NSString *modifyTime;
@property (nonatomic, strong) NSString *onlineTime;
@property (nonatomic, strong) NSString *poundage;
@property (nonatomic, strong) NSString *poundageType;
@property (nonatomic, strong) NSString *productDescribe;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *productStatus;
@property (nonatomic, strong) NSString *remainMs;
@property (nonatomic, strong) NSString *range;
@property (nonatomic, strong) NSString *remark;
@property (nonatomic, strong) NSString *service;
@property (nonatomic, strong) NSString *shareCount;
@property (nonatomic, strong) NSString *shareUrl;
@property (nonatomic, strong) NSString *smallImg;
@property (nonatomic, strong) NSString *startTime;
@property (nonatomic, strong) NSString *tax;
//@property (nonatomic, strong) NSString *version;
//@property (nonatomic, strong) NSString *winPrice;

- (id)initWithDict:(NSDictionary *)info;

@end
