//
//  HWAddressModel.h
//  Community
//
//  Created by caijingpeng.haowu on 14-12-16.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

/**
 *                      "id": null,
 "addressId": 381116,
 "cutUserId": 691,
 "name": "厉1",
 "address": "上海普陀",
 "mobile": "18717959523",
 "isDefault": 1

 */
#import <Foundation/Foundation.h>

@interface HWAddressModel : NSObject

@property (nonatomic, strong)NSString *modelId;
@property (nonatomic, strong)NSString *addressId;
@property (nonatomic, strong)NSString *cutUserId;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *address;
@property (nonatomic, strong)NSString *mobile;
@property (nonatomic, strong)NSString *isDefault;

- (id)initWithAddress:(NSDictionary *)info;

@end
