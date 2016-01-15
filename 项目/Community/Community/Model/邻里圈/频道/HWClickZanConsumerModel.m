//
//  HWClickZanConsumerModel.m
//  Community
//
//  Created by hw500029 on 15/1/20.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//      姓名         日期               修改内容
//     马一平     2015-01-20           创建文件
//      李中强     2015-01-21          添加mongodbKey
//

#import "HWClickZanConsumerModel.h"

@implementation HWClickZanConsumerModel
@synthesize topicPraiseId;
@synthesize userId;
@synthesize nickName;
@synthesize headUrl;
@synthesize mongodbKey;

- (id)initWithDic:(NSDictionary *)dic
{
    if (self = [super init])
    {
        self.topicPraiseId = [dic stringObjectForKey:@"topicPraiseId"];
        self.userId = [dic stringObjectForKey:@"userId"];
        self.nickName = [dic stringObjectForKey:@"nickName"];
        self.headUrl = [dic stringObjectForKey:@"headUrl"];
        self.mongodbKey = [dic stringObjectForKey:@"mongodbKey"];
    }
    return self;
}

@end
