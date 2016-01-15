//
//  AddressModel.h
//  Community
//
//  Created by hw500028 on 14/12/8.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressModel : NSObject

@property (nonatomic, strong) NSString *addressId;
@property (nonatomic, strong) NSString *cutUserId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *creater;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *modifier;
@property (nonatomic, strong) NSString *modifyTime;
@property (nonatomic, strong) NSString *version;
@property (nonatomic, strong) NSString *disabled;
@property (nonatomic, strong) NSString *isDefault;      // 1 默认  0 不是默认
//add by gusheng
@property (nonatomic,strong)NSString *orderIdStr;
//end
- (id)initWithDic:(NSDictionary *)dic;

@end
