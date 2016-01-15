//
//  HWServiceIconModel.h
//  Community
//
//  Created by niedi on 15/6/9.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWServiceIconModel : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *iconMongoKey;
@property (nonatomic, strong) NSString *iconImgName;
@property (nonatomic, strong) NSString *linkUrl;
@property (nonatomic, strong) NSString *modelType;
@property (nonatomic, strong) NSString *classStr;


- (instancetype)initWithDict:(NSDictionary *)dict;


@end
