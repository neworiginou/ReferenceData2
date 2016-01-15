//
//  HWApplicationModel.h
//  Community
//
//  Created by caijingpeng.haowu on 14-12-10.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWApplicationModel : NSObject

@property (nonatomic, strong) NSString *applicationId;
@property (nonatomic, strong) NSString *name;           // 店主姓名
@property (nonatomic, strong) NSString *type;           // 
@property (nonatomic, strong) NSString *iconUrl;
@property (nonatomic, strong) NSString *appOrFolderIndex;
@property (nonatomic, strong) NSString *appRangeDTOList;
@property (nonatomic, strong) NSString *iconMongodbKey;
@property (nonatomic, strong) NSString *isShelves;
@property (nonatomic, strong) NSString *sortKey;

- (id)initWithApplicationInfo:(NSDictionary *)info;

@end
