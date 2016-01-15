//
//  HWNeighbourDetailListItemClass.h
//  Community
//
//  Created by zhangxun on 14-9-14.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWNeighbourDetailListItemClass : NSObject

@property (nonatomic,strong)NSString *content;
@property (nonatomic,strong)NSString *createTime;
@property (nonatomic,strong)NSString *creater;
@property (nonatomic,strong)NSString *disabled;
@property (nonatomic,strong)NSString *floor;
@property (nonatomic,strong)NSString *headUrl;
@property (nonatomic,strong)NSString *mongoKey;
@property (nonatomic,strong)NSString *mongodbKey;
@property (nonatomic,strong)NSString *nickName;
@property (nonatomic,strong)NSString *referId;
@property (nonatomic,strong)NSString *replyId;
@property (nonatomic,strong)NSString *replyTime;
@property (nonatomic,strong)NSString *status;
@property (nonatomic,strong)NSString *userName;

//add 1.2.1
@property (nonatomic, strong) NSString *calleeUserId;               //被@人用户id
@property (nonatomic, strong) NSString *calleeUserNickName;         //被@人昵称
@property (nonatomic, strong) NSString *replyAtId;                  //@编号
@property (nonatomic, strong) NSString *userId;                     //评论人ID
@property (nonatomic, strong) NSString *userType;
//用来判断是否楼主
@property (nonatomic, strong) NSString *topicUserId;                //主题作者的用户ID

- (void)fillWithDictionary:(NSDictionary *)dictionary;


@end
