//
//  HWCoreDataManager.h
//  Community
//
//  Created by caijingpeng.haowu on 14-8-27.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//
//  对数据库表进行增删改查操作的管理模块
//

#import <Foundation/Foundation.h>
#import "HWPropertyDetailClass.h"
#import "HWNeighbourItemClass.h"
#import "HWPropertyItemClass.h"
#import "HWAlertModel.h"
@interface HWCoreDataManager : NSObject

// 用户表相关操作
+ (BOOL)saveUserInfo;
+ (void)loadUserInfo;
+ (BOOL)clearUserInfo;

// 拨打电话后通知表
+ (BOOL)addNotification:(NSArray *)notifyList;
+ (NSArray *)searchAllNotification;
+ (BOOL)removeAllNotification;
+ (BOOL)removeNotificationBy:(NSString *)targetId;

// 分享列表缓存
+ (BOOL)addShareItem:(NSArray *)shareList;
+ (NSArray *)searchAllShareItem;
+ (BOOL)removeAllShareItem;

//邻里圈列表相关操作
+ (BOOL)saveNeighbourList:(NSArray *)neighbourList;
+ (NSMutableArray *)loadNieghbourList;
+ (BOOL)updateNeighbour:(HWNeighbourItemClass *)item;
+ (BOOL)clearNeighbourList;

//服务汇banner（合作物业）
+ (BOOL)saveServiceBannerForCompanyWuYeModelArr:(NSArray *)modelArr;
+ (NSArray *)searchAllBannerModelForCompanyWuYe;
+ (BOOL)removeAllBannerModelCompany;

//首页Icon缓存
+ (BOOL)saveServiceIcomForCompanyModelArr:(NSArray *)modelArr;
+ (NSArray *)searchAllIcomModelForCompanyWuYe;
+ (BOOL)removeAllIconModelForCompanyWuYe;

//服务汇列表
+ (BOOL)savePropertyList:(HWPropertyItemClass *)propertyList;
+ (HWPropertyItemClass *)searchAllPropertyList;
+ (BOOL)clearPropertyList;

//店铺
+ (BOOL)saveShopList:(NSArray *)shopList;
+ (NSMutableArray *)searchAllShopList;
+ (BOOL)clearShopList;


//物业详情
+ (BOOL)savePropertyData:(HWPropertyDetailClass *)proList;
+ (HWPropertyDetailClass *)searchAllPropertyData;
+ (BOOL)clearPropertyData;

//优惠劵列表
+ (NSArray *)searchAllPriviledgeItem;
+ (BOOL)addPriviledgeItem:(NSArray *)priviledgeList;
+ (BOOL)removeAllPriviledgeItem;

//我的优惠劵列表
+ (BOOL)addPriviledgeListItem:(NSArray *)priviledgeList;
+ (NSArray *)searchAllPriviledgeListItem;
+ (BOOL)removeAllPriviledgeListItem;

// 首页应用图标
+ (BOOL)addApplicationListItem:(NSArray *)applicationList;
+ (NSArray *)searchAllApplicaitionListItem;
+ (BOOL)removeAllApplicationListItem;

// 首页广告
+ (BOOL)addActivityListItem:(NSArray *)priviledgeList;
+ (NSArray *)searchAllActivityListItem;
+ (BOOL)removeAllActivityListItem;

//邻里圈首页推荐列表缓存
+ (BOOL)addChannelItemForRecommend:(NSArray *)channelList;
+ (NSArray *)channelItemForRecommend;
+ (BOOL)removeAllChannelItemForRecommend;

//邻里圈首页足迹列表缓存
+ (BOOL)addChannelItemForPastRecords:(NSArray *)channelList;
+ (NSArray *)channelItemForPastRecords;
+ (BOOL)removeAllChannelItemForPastRecords;

//邻里圈首页推荐页面banner缓存
+ (BOOL)addNeighbourBannerModel:(NSArray *)bannerArr;
+ (NSArray *)bannerModel;
+ (BOOL)removeAllBannerModel;

+ (BOOL)addAlertTime:(NSMutableArray *)itemArr;
+ (NSArray *)searchAllAlertTime;
+ (BOOL)removeAlertItmeByGoodsId:(NSString *)goodsId;
+ (BOOL)removeAllAlertItme;

@end
