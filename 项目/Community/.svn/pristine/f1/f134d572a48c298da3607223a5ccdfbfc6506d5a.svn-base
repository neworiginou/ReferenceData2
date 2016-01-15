//
//  HWNeighbourDetailListItemClass.m
//  Community
//
//  Created by zhangxun on 14-9-14.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//  功能描述：邻里圈评论model
//  修改记录
//      李中强 2015-01-21 添加V1.2.1字段

#import "HWNeighbourDetailListItemClass.h"

@implementation HWNeighbourDetailListItemClass

//@property (nonatomic,strong)NSString *content;
//@property (nonatomic,strong)NSString *createTime;
//@property (nonatomic,strong)NSString *creater;
//@property (nonatomic,strong)NSString *disabled;
//@property (nonatomic,strong)NSString *floor;
//@property (nonatomic,strong)NSString *headUrl;
//@property (nonatomic,strong)NSString *mongoKey;
//@property (nonatomic,strong)NSString *mongodbKey;
//@property (nonatomic,strong)NSString *nickName;
//@property (nonatomic,strong)NSString *referId;
//@property (nonatomic,strong)NSString *replyId;
//@property (nonatomic,strong)NSString *replyTime;
//@property (nonatomic,strong)NSString *status;
//@property (nonatomic,strong)NSString *userName;

@synthesize content,createTime,creater,disabled,floor,headUrl,mongoKey,mongodbKey,nickName,referId,replyId,replyTime,status,userName;

@synthesize calleeUserId;
@synthesize calleeUserNickName;
@synthesize replyAtId;
@synthesize userId;
@synthesize userType;
@synthesize topicUserId;

- (void)fillWithDictionary:(NSDictionary *)dictionary{
    self.content = [dictionary stringObjectForKey:@"content"];
    self.createTime = [dictionary stringObjectForKey:@"createTime"];
    self.creater = [dictionary stringObjectForKey:@"nickName"];
    self.disabled = [dictionary stringObjectForKey:@"disabled"];
    self.floor = [dictionary stringObjectForKey:@"floor"];
    self.headUrl = [dictionary stringObjectForKey:@"headUrl"];
    self.mongoKey = [dictionary stringObjectForKey:@"mongoKey"];
    self.mongodbKey = [dictionary stringObjectForKey:@"mongodbKey"];
    self.nickName = [dictionary stringObjectForKey:@"nickName"];
    self.referId = [dictionary stringObjectForKey:@"referId"];
    self.replyId = [dictionary stringObjectForKey:@"replyId"];
    self.replyTime = [dictionary stringObjectForKey:@"replyTime"];
    self.status = [dictionary stringObjectForKey:@"status"];
    self.userName = [dictionary stringObjectForKey:@"userName"];
    
    self.calleeUserId = [dictionary stringObjectForKey:@"calleeUserId"];
    self.calleeUserNickName = [dictionary stringObjectForKey:@"calleeUserNickName"];
    self.replyAtId = [dictionary stringObjectForKey:@"replyAtId"];
    self.userId = [dictionary stringObjectForKey:@"userId"];
    self.userType = [dictionary stringObjectForKey:@"userType"];
    self.topicUserId = [dictionary stringObjectForKey:@"topicUserId"];
}

@end
