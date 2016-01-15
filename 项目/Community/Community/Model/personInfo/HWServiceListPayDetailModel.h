//
//  HWServiceListPayDetailModel.h
//  Community
//
//  Created by hw500027 on 15/6/25.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWServiceListPayDetailModel : NSObject
@property (nonatomic , strong) NSString *orderId;
@property (nonatomic , strong) NSString *name;
@property (nonatomic , strong) NSString *amount;
@property (nonatomic , strong) NSString *price;
@property (nonatomic , strong) NSString *charge;

- (id)initWithDic:(NSDictionary *)dic;
@end
