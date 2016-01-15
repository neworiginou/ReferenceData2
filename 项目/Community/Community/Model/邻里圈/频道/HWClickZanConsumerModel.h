//
//  HWClickZanConsumerModel.h
//  Community
//
//  Created by hw500029 on 15/1/20.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWClickZanConsumerModel : NSObject

@property (nonatomic,copy)NSString *topicPraiseId;
@property (nonatomic,copy)NSString *userId;
@property (nonatomic,copy)NSString *nickName;
@property (nonatomic,copy)NSString *headUrl;
@property (nonatomic,strong)NSString *mongodbKey;       //图片

- (id)initWithDic:(NSDictionary *)dic;

@end
