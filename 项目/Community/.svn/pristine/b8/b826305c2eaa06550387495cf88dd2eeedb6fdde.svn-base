//
//  HWNeighbourItemClass.m
//  Community
//
//  Created by zhangxun on 14-9-10.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWNeighbourItemClass.h"

@implementation HWNeighbourItemClass

@synthesize cardID,author,createDate,villageId,villageName,commentCount,cardType,content,pictureURL,audioURL,anonymity,title,headUrl;
@synthesize createName,createId,isShowReport,callId,callTime,callNumber,callName;
@synthesize createCity;
@synthesize coStatus;
@synthesize viewRange;
@synthesize creater;
@synthesize likeCount;
@synthesize isNeighbour;
@synthesize isPraise;
@synthesize replyCount;
@synthesize channelId;
@synthesize channelName;
@synthesize businessType;
@synthesize topicPraiseArr;
@synthesize userId;
@synthesize soundTime;

@synthesize phoneHistoryId;

- (void)dealloc{
    self.cardID = nil;
    self.author = nil;
    self.createDate = nil;
    self.villageId = nil;
    self.villageName = nil;
    self.commentCount = nil;
    self.cardType = nil;
    self.content = nil;
    self.pictureURL = nil;
    self.audioURL = nil;
    self.anonymity = nil;
    self.title = nil;
    self.headUrl = nil;
    
    self.callId = nil;
    self.callTime = nil;
    self.callNumber = nil;
    self.callName = nil;
    
    self.createId = nil;
    self.createName = nil;
    self.createCity = nil;
    
    self.isShowReport = nil;
    
    self.phoneHistoryId = nil;
    
    self.coStatus = nil;
    
    self.shopId = nil;
    
    self.viewRange = nil;
    
    self.creater = nil;
    
    self.likeCount = nil;
    
    self.isNeighbour = nil;
    
    self.isPraise = nil;
    
    self.replyCount = nil;
    self.channelId = nil;
    self.channelName = nil;
    self.businessType = nil;
    self.topicPraiseArr = nil;
    self.userId = nil;
    self.soundTime = nil;
}

- (void)fillObjectWithDictionary:(NSDictionary *)dictonary{
    self.cardID = [dictonary stringObjectForKey:@"topicId"];
    self.author = [dictonary stringObjectForKey:@"nickName"];
    self.createDate = [dictonary stringObjectForKey:@"topicTime"];
    self.villageId = [dictonary stringObjectForKey:@"villageId"];
    self.villageName = [dictonary stringObjectForKey:@"villageName"];
    self.commentCount = [dictonary stringObjectForKey:@"replyCountStr"];
    if (self.commentCount.length == 0) {
        self.commentCount = @"0";
    }
    self.headUrl = [dictonary stringObjectForKey:@"headUrl"];
    self.cardType = [dictonary stringObjectForKey:@"releaseType"];
    if ([cardType isEqualToString:@""]) {
        cardType = @"0";
    }
    self.content = [dictonary stringObjectForKey:@"content"];
    self.pictureURL = [dictonary stringObjectForKey:@"attURL"];
    self.audioURL = [dictonary stringObjectForKey:@"attURL"];
    self.anonymity = [dictonary stringObjectForKey:@"isAnonymous"];
    self.title = [dictonary stringObjectForKey:@"title"];
    self.itemPlayMode = 0;
    
    
    self.callId = [dictonary stringObjectForKey:@"callId"];
    self.callTime = [dictonary stringObjectForKey:@"callTime"];
    self.callNumber = [dictonary stringObjectForKey:@"callNumber"];
    self.callName = [dictonary stringObjectForKey:@"callName"];
    
    self.createId = [dictonary stringObjectForKey:@"createVillageId"];
    self.createName = [dictonary stringObjectForKey:@"createVillageName"];
    self.createCity = [dictonary stringObjectForKey:@"createCity"];
    
    self.isShowReport = [dictonary stringObjectForKey:@"isShowReport"];
    
    self.phoneHistoryId = [dictonary stringObjectForKey:@"phoneHistoryId"];
    
    self.coStatus = [dictonary stringObjectForKey:@"coStatus"];
    
    self.shopId = [dictonary stringObjectForKey:@"shopId"];
    
    self.viewRange = [dictonary stringObjectForKey:@"viewRange"];
    
    self.creater = [dictonary stringObjectForKey:@"creater"];
    
    self.likeCount = [dictonary stringObjectForKey:@"praiseCount"];
    if (self.likeCount.length == 0) {
        self.likeCount = @"0";
    }
    self.isNeighbour = [dictonary stringObjectForKey:@"isNeighbour"];
    self.isPraise = [dictonary stringObjectForKey:@"isPraise"];
    
    self.replyCount = [dictonary stringObjectForKey:@"replyCount"];
    if ([replyCount isEqualToString:@""])
    {
        self.replyCount = @"0";
    }
    self.channelId = [dictonary stringObjectForKey:@"channelId"];
    self.channelName = [dictonary stringObjectForKey:@"channelName"];
    self.businessType = [dictonary stringObjectForKey:@"businessType"];
    
    NSArray *arrPraise = [[dictonary dictionaryObjectForKey:@"topicPraise"] arrayObjectForKey:@"content"];
    for (int i = 0; i < arrPraise.count; i ++)
    {
        HWClickZanConsumerModel *model = [[HWClickZanConsumerModel alloc] initWithDic:arrPraise[i]];
        if (!self.topicPraiseArr) {
            self.topicPraiseArr = [NSMutableArray array];
        }
        [self.topicPraiseArr addObject:model];
    }
    self.userId = [dictonary stringObjectForKey:@"userId"];
    self.soundTime = [dictonary stringObjectForKey:@"soundTime"];
    
}

@end
