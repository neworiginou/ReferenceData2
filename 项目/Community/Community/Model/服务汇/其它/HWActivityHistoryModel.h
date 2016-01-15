//
//  HWActivityHistoryModel.h
//  Community
//
//  Created by caijingpeng.haowu on 14-12-11.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//
/**


 "endTime": null,
 "service": null,
 "joinCount": null,
 "source": null,
 "showOrderId": null,
 "showOrderTime": null,
 "userId": null


 */


#import <Foundation/Foundation.h>

@interface HWActivityHistoryModel : NSObject
@property (nonatomic, strong) NSString *distanceInSec;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *showContent;
@property (nonatomic, strong) NSString *showImg;
@property (nonatomic, strong) NSString *showOrderId;
@property (nonatomic, strong) NSString *Id;
@property (nonatomic, strong) NSString *endTime;
@property (nonatomic, strong) NSString *showOrderTime;
@property (nonatomic, strong) NSString *showHeadImg;
@property (nonatomic, strong) NSString *remark;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *tax;
@property (nonatomic, strong) NSString *source;
@property (nonatomic, strong) NSString *creater;
@property (nonatomic, strong) NSString *winPrice;
@property (nonatomic, strong) NSString *joinCount;
@property (nonatomic, strong) NSString *lowestPrice;
@property (nonatomic, strong) NSString *modifier;
@property (nonatomic, strong) NSString *service;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *version;
@property (nonatomic, strong) NSString *poundageType;
@property (nonatomic, strong) NSString *startTime;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *modifyTime;
@property (nonatomic, strong) NSString *startTimeStr;
@property (nonatomic, strong) NSString *historyId;
@property (nonatomic, strong) NSString *productStatus;
@property (nonatomic, strong) NSString *increasePrice;
@property (nonatomic, strong) NSString *poundage;
@property (nonatomic, strong) NSString *marketPrice;
@property (nonatomic, strong) NSString *onlyLowestPrice;
@property (nonatomic, strong) NSString *smallImg;
@property (nonatomic, strong) NSString *bigImg;
@property (nonatomic, strong) NSString *disabled;

- (id)initWithHistoryInfo:(NSDictionary *)info;

@end
