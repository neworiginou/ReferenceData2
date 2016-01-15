//
//  HWNeighbourItemClass.h
//  Community
//
//  Created by zhangxun on 14-9-10.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//  功能描述：邻里圈model
//  修改记录：
//      李中强 2015-01-21 增加v1.2.1 字段

#import <Foundation/Foundation.h>
#import "HWTagItemClass.h"
#import "HWClickZanConsumerModel.h"

@interface HWNeighbourItemClass : NSObject



//基础字段
@property (nonatomic,strong)NSString *cardID;                   //主题ID topicId
@property (nonatomic,strong)NSString *author;                   //昵称 nickName
@property (nonatomic,strong)NSString *createDate;               //主题发表时间 topicTime
@property (nonatomic,strong)NSString *villageId;                //主题所在小区ID
@property (nonatomic,strong)NSString *villageName;              //小区名称
//评论总数
@property (nonatomic,strong)NSString *commentCount;
//@property (nonatomic,strong)NSMutableArray *tag;
//@property (nonatomic,strong)HWTagItemClass *currentTag;
@property (nonatomic,strong)NSString *cardType;                 //
@property (nonatomic,strong)NSString *content;                  //
@property (nonatomic,strong)NSString *pictureURL;               //
@property (nonatomic,strong)NSString *audioURL;                 //
@property (nonatomic,strong)NSString *anonymity;                //
@property (nonatomic,strong)NSString *title;                    //
@property (nonatomic,strong)NSString *headUrl;                  //
@property (nonatomic,assign)PlayMode itemPlayMode;              //

//拨打电话增加的返回字段
@property (nonatomic,strong)NSString *callId;                   //
@property (nonatomic,strong)NSString *callTime;                 //
@property (nonatomic,strong)NSString *callNumber;               //
@property (nonatomic,strong)NSString *callName;                 //
//创建小区成功增加的返回字段
@property (nonatomic,strong)NSString *createId;                 //
@property (nonatomic,strong)NSString *createName;               //
@property (nonatomic,strong)NSString *createCity;               //
//是否显示举报（自己发表的不显示，其它显示）
@property (nonatomic,strong)NSString *isShowReport;             //
//
@property (nonatomic,strong)NSString *phoneHistoryId;           //
//是否合作物业，0是 1否
@property (nonatomic,strong)NSString *coStatus;                 //

//店铺Id
@property (nonatomic,strong)NSString *shopId;
// 0 周边小区 1 城市 2 全国
@property (nonatomic,strong)NSString *viewRange;

@property (nonatomic,strong)NSString *creater;
//赞数
@property (nonatomic,strong)NSString *likeCount;
//是否赞过 1是，0否
@property (nonatomic,strong)NSString *isPraise;
//是否邻居
@property (nonatomic,strong)NSString *isNeighbour;
//时长
@property (nonatomic,strong)NSString *soundTime;
//add by 李中强
@property (nonatomic,strong)NSString *replyCount;               //点赞总数量  commentCount
@property (nonatomic,strong)NSString *channelId;                //话题ID
@property (nonatomic,strong)NSString *channelName;              //话题名称
@property (nonatomic,strong)NSString *businessType;             //主题类型   0主题 1公告 2留言 3通知（比如系统产生的）
@property (nonatomic,strong)NSMutableArray *topicPraiseArr;     //点赞数组
@property (nonatomic,strong)NSString *userId;                   //发表主题的用户ID



- (void)fillObjectWithDictionary:(NSDictionary *)dictonary;

@end



