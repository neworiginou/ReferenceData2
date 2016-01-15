//
//  HWWuYeAddHouseModel.h
//  Community
//
//  Created by niedi on 15/6/23.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWWuYeAddHouseModel : NSObject

@property (nonatomic, strong) NSString *buildingNo;
@property (nonatomic, strong) NSString *roomNo;
@property (nonatomic, strong) NSString *unitNo;
@property (nonatomic, strong) NSString *villageId;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
