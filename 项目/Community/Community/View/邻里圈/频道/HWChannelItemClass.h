//
//  HWChannelItemClass.h
//  Community
//
//  Created by zhangxun on 15/1/20.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWChannelItemClass : NSObject

@property (nonatomic, strong) NSString *channelId;
@property (nonatomic, strong) NSString *channelName;
@property (nonatomic, strong) NSString *nickName;//主题作者昵称
@property (nonatomic, strong) NSString *headUrl;//头像地址
@property (nonatomic, strong) NSString *isAnonymous;//是否匿名
@property (nonatomic, strong) NSString *topicId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *replyCount;
@property (nonatomic, strong) NSString *praiseCount;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *createTimeStr;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *releaseType;
@property (nonatomic, strong) NSString *villageName;
@property (nonatomic, strong) NSString *villageId;
@property (nonatomic, strong) NSString *cityId;
@property (nonatomic, strong) NSString *districtId;
@property (nonatomic, strong) NSString *areaName;
@property (nonatomic, strong) NSString *hasPraise;
@property (nonatomic, strong) NSString *mongodbKey;
@property (nonatomic, strong) NSString *fileName;
@property (nonatomic, strong) NSString *soundTime;
@property (nonatomic, assign)PlayMode itemPlayMode;

- (void)fillWithDictionary:(NSDictionary *)dict;

- (void)fillWithDictForPersonalTheme:(NSDictionary *)dict;

@end
