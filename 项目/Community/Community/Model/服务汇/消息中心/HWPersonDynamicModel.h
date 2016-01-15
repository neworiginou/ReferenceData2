//
//  HWPersonDynamicModel.h
//  Community
//
//  Created by hw500027 on 15/1/12.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWPersonDynamicModel : NSObject

@property (nonatomic,assign)PlayMode itemPlayMode;
/*******个人动态重复字段*******/
@property (nonatomic, strong) NSString * userId; // 评论用户id,
@property (nonatomic, strong) NSString * nickName; // 评论人昵称,
@property (nonatomic, strong) NSString * headUrl; // 评论人头像url,
@property (nonatomic, strong) NSString * topicContent; // 主题内容,
@property (nonatomic, strong) NSString * topicAttUrl; // 主题附件url,
@property (nonatomic, strong) NSString * soundTime; // 主题附件时长,
@property (nonatomic, strong) NSString * createTimeStr; // 创建时间,
@property (nonatomic, strong) NSString * isRead; // 是否已读0，未读；1，已读
@property (nonatomic, strong) NSString * releaseType; //0:图片、文字 1:纯文字 2:音频

/*******个人动态-赞*******/
@property (nonatomic, strong) NSString * sendPraiseHeadUrl; // 发出人头像url
@property (nonatomic, strong) NSString * receivePraiseHeadUrl; // 接受人头像url
@property (nonatomic, strong) NSString * sendPraiseNickName; // 发送人昵称
@property (nonatomic, strong) NSString * receivePraiseNickName; // 接受人昵称
@property (nonatomic, strong) NSString * sendPraiseUserId; // 发送人用户id
@property (nonatomic, strong) NSString * receivePraiseUserId; // 接收人用户id

/*******个人动态-主题*******/
@property (nonatomic, strong) NSString * businessType; // 业务类型

/*******个人动态-评论*******/
@property (nonatomic, strong) NSString * replyId; // 评论id,
@property (nonatomic, strong) NSString * replyContent; // 评论内容,
@property (nonatomic, strong) NSString * topicId; // 主题id
@property (nonatomic, strong) NSString * replyUserId; // 评论用户id,
@property (nonatomic, strong) NSString * replyCreateTimeStr; //
@property (nonatomic, strong) NSString * replyUserNickName; //评论人昵称
@property (nonatomic, strong) NSString * replyUserHeadUrl; //评论人头像Url
@property (nonatomic, strong) NSString * topicUserNickName;
/*******个人动态-（@）我的*******/
@property (nonatomic, strong) NSString * replyAtId; //@id,
@property (nonatomic, strong) NSString * callerUserId; // 发送@人用户id,
@property (nonatomic, strong) NSString * calleeUserId; // 接受@人用户id,
@property (nonatomic, strong) NSString * userNickName; // 接受@人昵称
@property (nonatomic, strong) NSString * topicNickName;

-(id)initWithDic:(NSDictionary *)dic;
@end
