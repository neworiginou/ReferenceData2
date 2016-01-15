//
//  HWWuYePublishNoticeModel.h
//  Community
//
//  Created by niedi on 15/6/11.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWWuYePublishNoticeModel : NSObject

@property (nonatomic, strong) NSString *topicId;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *content;


- (instancetype)initWithDict:(NSDictionary *)dict;


@end
