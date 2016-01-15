//
//  HWOrderQuestionClass.h
//  Community
//
//  Created by lizhongqiang on 14-9-11.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//  预约物业上门问题类型

#import <Foundation/Foundation.h>

@interface HWOrderQuestionClass : NSObject
@property (nonatomic, strong) NSString *questionId;         //
@property (nonatomic, strong) NSString *questionName;       //

- (id)initWithDictionary:(NSDictionary *)dic;

@end
