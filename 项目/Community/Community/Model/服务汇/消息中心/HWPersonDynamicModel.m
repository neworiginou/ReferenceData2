//
//  HWPersonDynamicModel.m
//  Community
//
//  Created by hw500027 on 15/1/12.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：个人动态model
//  修改记录：
//	姓名   日期　　　　　　修改内容
//  陆晓波　2015-01-15　　新增是否已读状态字段
//  陆晓波　2015-01-19　　添加字段
//  陆晓波　2015-01-21　　添加字段
//  陆晓波　2015-01-22　　添加字段
//  陆晓波　2015-01-29   添加字段

#import "HWPersonDynamicModel.h"

@implementation HWPersonDynamicModel

-(id)initWithDic:(NSDictionary *)dic
{
    if (self = [super init])
    {
        self.itemPlayMode = 0;
        /*******个人动态重复字段*******/
        self.userId = [dic stringObjectForKey:@"userId"]; // 评论用户id,
        self.nickName = [dic stringObjectForKey:@"nickName"]; // 评论人昵称,
        self.headUrl = [dic stringObjectForKey:@"headUrl"]; // 评论人头像url,
        self.topicContent = [dic stringObjectForKey:@"topicContent"]; // 主题内容,
        self.topicAttUrl = [dic stringObjectForKey:@"topicAttUrl"]; // 主题附件url,
        self.soundTime = [dic stringObjectForKey:@"soundTime"]; // 主题附件时长,
        self.createTimeStr = [dic stringObjectForKey:@"createTimeStr"]; // 创建时间,
        self.isRead = [dic stringObjectForKey:@"isRead"]; //是否已读0，未读；1，已读
        self.releaseType = [dic stringObjectForKey:@"releaseType"]; // 0:图片、文字 1:纯文字 2:音频
        
        /*******个人动态-赞*******/
        self.sendPraiseHeadUrl = [dic stringObjectForKey:@"sendPraiseHeadUrl"]; // 发出人头像url
        self.receivePraiseHeadUrl = [dic stringObjectForKey:@"receivePraiseHeadUrl"]; // 接受人头像url
        self.sendPraiseNickName = [dic stringObjectForKey:@"sendPraiseNickName"]; // 发送人昵称
        self.receivePraiseNickName = [dic stringObjectForKey:@"receivePraiseNickName"]; // 接受人昵称
        self.sendPraiseUserId = [dic stringObjectForKey:@"sendPraiseUserId"]; // 发送人用户id
        self.receivePraiseUserId = [dic stringObjectForKey:@"receivePraiseUserId"]; // 接收人用户id
        
        /*******个人动态-主题*******/
        self.businessType = [dic stringObjectForKey:@"businessType"]; // 业务类型
        
        /*******个人动态-评论*******/
        self.replyId = [dic stringObjectForKey:@"replyId"]; // 评论id,
        self.replyContent = [dic stringObjectForKey:@"replyContent"]; // 评论内容,
        self.topicId = [dic stringObjectForKey:@"topicId"]; // 主题id
        self.replyUserId = [dic stringObjectForKey:@"replyUserId"]; // 评论用户id,
        self.replyCreateTimeStr = [dic stringObjectForKey:@"replyCreateTimeStr"];
        self.replyUserNickName = [dic stringObjectForKey:@"replyUserNickName"];
        self.replyUserHeadUrl = [dic stringObjectForKey:@"replyUserHeadUrl"];
        self.topicUserNickName = [dic stringObjectForKey:@"topicUserNickName"];
        
        /*******个人动态-（@）我的*******/
        self.replyAtId = [dic stringObjectForKey:@"replyAtId"]; //@id,
        self.callerUserId = [dic stringObjectForKey:@"callerUserId"]; // 发送@人用户id,
        self.calleeUserId = [dic stringObjectForKey:@"calleeUserId"]; // 接受@人用户id,
        self.userNickName = [dic stringObjectForKey:@"userNickName"]; // 接受@人昵称
        self.topicNickName = [dic stringObjectForKey:@"topicNickName"]; //主题人昵称
    }
    return self;
}
@end
