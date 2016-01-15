//
//  HWCutPriceModel.h
//  Community
//
//  Created by lizhongqiang on 15/4/20.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWCutPriceModel : NSObject
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *cutPrice;
@property (nonatomic, strong) NSString *isLowest;
@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *samePriceTimes;
@property (nonatomic, strong) NSString *uniqueLowerTimes;

- (id)initWithDict:(NSDictionary *)info;

@end
