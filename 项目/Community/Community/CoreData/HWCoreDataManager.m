//
//  HWCoreDataManager.m
//  Community
//
//  Created by caijingpeng.haowu on 14-8-27.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//
//  功能描述：数据库管理类 对数据库进行增删改查
//
//  修改记录：
//      姓名         日期               修改内容
//     蔡景鹏     2015-01-14       在用户表中添加 openid weixinNickname isBindWeixin isBindMobile 字段 对应保存和读取用户信息方法
//     杨庆龙     2015-01-14       增加话题的缓存  增\读\删 方法
//     陆晓波     2015-04-08       在用户表中添加 deviceId 字段 对应保存和读取用户信息方法
//

#import "HWCoreDataManager.h"
#import "AppDelegate.h"
#import "HWUser.h"
#import "HWShareItem.h"
#import "HWNeighbour.h"

#import "HWShopItem.h"
#import "HWPropertyItem.h"

#import "HWPropertyDetailData.h"
#import "HWPropertyDynamic.h"
#import "HWPriviledgeModel.h"
#import "HWPriviledgeItem.h"

#import "HWPriviledgeList.h"
#import "HWMyPriviledgeModel.h"

#import "HWApplicationItem.h"
#import "HWApplicationModel.h"
#import "HWActivityItem.h"
#import "HWActivityModel.h"
#import "HWShareItemClass.h"

#import "HWChannelItem.h"
#import "HWChannelModel.h"
#import "HWAlertItem.h"
#import "HWNeighbourBanner.h"
#import "HWNeighbourBannerModel.h"

#import "HWServiceBannerCompany.h"

#import "HWServiceIconModel.h"
#import "HWServiceIconItem.h"

@implementation HWCoreDataManager

+ (BOOL)saveContext:(NSManagedObjectContext *)context
{
    AppDelegate* delegate = SHARED_APP_DELEGATE;
    
    [context performBlock:^{
        
        [context save:nil];
        [delegate.managedObjectContext performBlock:^{
            NSError* error;
            if (![delegate.managedObjectContext save:&error])
            {
                NSLog(@"error is %@",error);
            }
        }];
        
    }];
    
    return YES;
}

+ (BOOL)deleteOneEntityAllData:(NSString *)coreDataEntityName
{
    NSError *error = nil;
    AppDelegate* delegate = SHARED_APP_DELEGATE;
    
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    context.parentContext = delegate.managedObjectContext;
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:coreDataEntityName inManagedObjectContext:context];
    [request setEntity:entity];
    NSArray *resultArr = [context executeFetchRequest:request error:&error];
    if (resultArr == nil || error != nil)
    {
        return YES;
    }
    for (id obj in resultArr)
    {
        [context deleteObject:obj];
    }
    BOOL successful = [self saveContext:context];
    
    return successful;
}

#pragma mark -
#pragma mark    用户表 操作

+ (BOOL)saveUserInfo
{
    [HWCoreDataManager clearUserInfo];
    
    AppDelegate* delegate = SHARED_APP_DELEGATE;
    HWUserLogin *userLogin = [HWUserLogin currentUserLogin];
    
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    context.parentContext = delegate.managedObjectContext;
    
    HWUser *user = [NSEntityDescription insertNewObjectForEntityForName:@"HWUser" inManagedObjectContext:context];
    user.avatarUrl = userLogin.avatar;
    user.nickname = userLogin.nickname;
    user.gender = userLogin.gender;
    user.favorite = userLogin.favorite;
    user.key = userLogin.key;
    user.cityId = userLogin.cityId;
    user.cityName = userLogin.cityName;
    user.villageId = userLogin.villageId;
    user.villageName = userLogin.villageName;
    user.villageAddress = userLogin.villageAddress;
    user.tenementId = userLogin.tenementId;
    user.shopId = userLogin.shopId;
    user.residentId = userLogin.residendId;
    user.userId = userLogin.userId;
    user.telephoneNum = userLogin.telephoneNum;
    user.latitude = [NSNumber numberWithFloat: userLogin.latitude];
    user.latitude = [NSNumber numberWithFloat: userLogin.longitude];
    user.dataVersion = userLogin.dataVersion;
    user.cityName = userLogin.cityName;
    user.gpsCityId = userLogin.gpsCityId;
    user.gpsCityName = userLogin.gpsCityName;
    user.acceptNotify = userLogin.acceptNotify;
    user.propertyNotify = userLogin.propertyNotify;
    user.shopNotify = userLogin.shopNotify;
    user.soundNotify = userLogin.soundNotify;
    user.shakeNotify = userLogin.shakeNotify;
    user.openId = userLogin.openId;
    user.weixinNickname = userLogin.weixinNickname;
    user.isBindMobile = userLogin.isBindMobile;
    user.isBindWeixin = userLogin.isBindWeixin;
    user.deviceId = userLogin.deviceId;
    user.coStatus = userLogin.coStatus;
    user.isAuth = userLogin.isAuth;
    user.source = userLogin.source;
    
    BOOL successful = [self saveContext:context];
    return successful;
}

+ (void)loadUserInfo
{
    NSError *err = nil;
    AppDelegate *delegate = SHARED_APP_DELEGATE;
    HWUserLogin *userLogin = [HWUserLogin currentUserLogin];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"HWUser" inManagedObjectContext:delegate.managedObjectContext];
    [request setEntity:entity];
    NSArray *users = [delegate.managedObjectContext executeFetchRequest:request error:&err];
    if (!users)
    {
        //NSLog(@"!!!! load user error : %@",err);
    }
    if (users.count == 0) {
        return;
    }
    
    HWUser *user = [users lastObject];
    userLogin.avatar = user.avatarUrl;
    userLogin.nickname = user.nickname;
    userLogin.gender =  user.gender;
    userLogin.favorite = user.favorite;
    userLogin.key = user.key;
    userLogin.cityId = user.cityId;
    userLogin.villageId = user.villageId;
    userLogin.villageName = user.villageName;
    userLogin.tenementId = user.tenementId;
    userLogin.shopId = user.shopId;
    userLogin.residendId = user.residentId;
    userLogin.telephoneNum = user.telephoneNum;
    userLogin.userId = user.userId;
    userLogin.latitude = [user.latitude floatValue];
    userLogin.longitude = [user.longitude floatValue];
    userLogin.dataVersion = user.dataVersion;
    userLogin.cityName = user.cityName;
    userLogin.gpsCityId = user.gpsCityId;
    userLogin.gpsCityName = user.gpsCityName;
    userLogin.acceptNotify = user.acceptNotify;
    userLogin.propertyNotify = user.propertyNotify;
    userLogin.shopNotify = user.shopNotify;
    userLogin.soundNotify = user.soundNotify;
    userLogin.shakeNotify = user.shakeNotify;
    userLogin.openId = user.openId;
    userLogin.weixinNickname = user.weixinNickname;
    userLogin.isBindMobile = user.isBindMobile;
    userLogin.isBindWeixin = user.isBindWeixin;
    userLogin.deviceId = user.deviceId;
    userLogin.coStatus = user.coStatus;
    userLogin.isAuth = user.isAuth;
    userLogin.source = user.source;
    [userLogin loadUserAlertTime];
}

+ (BOOL)clearUserInfo
{
    return [self deleteOneEntityAllData:@"HWUser"];
}

+ (BOOL)savePropertyData:(HWPropertyDetailClass *)proList
{
    [self clearPropertyData];
    
    AppDelegate *delegate = SHARED_APP_DELEGATE;
    
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    context.parentContext = delegate.managedObjectContext;
    
    HWPropertyDetailData *proData = [NSEntityDescription insertNewObjectForEntityForName:@"HWPropertyDetailData" inManagedObjectContext:context];
    proData.tenementId = proList.tenementId;
    proData.name = proList.name;
    proData.intro = proList.intro;
    proData.address = proList.address;
    proData.openTime = proList.openTime;
    proData.callTimes = proList.callTimes;
  
    for (int j = 0 ; j < proList.arrServiceTrack.count ; j++)
    {
        HWPropertyDynamic *dynamic = [NSEntityDescription insertNewObjectForEntityForName:@"HWPropertyDynamic" inManagedObjectContext:context];
        HWPropertyNewsClass *news = proList.arrServiceTrack[j];
        dynamic.sortId = [NSNumber numberWithInt:j];
        dynamic.topicId = news.topicId;
        dynamic.topic = news.topic;
        dynamic.releaseType = news.releaseType;
        dynamic.url = news.url;
        dynamic.content = news.content;
        dynamic.creater = news.creater;
        dynamic.createTime = news.createTime;
        dynamic.systemTime = news.systemTime;
        dynamic.timeDistance = news.timeDistance;
        dynamic.fileName = news.fileName;
        
        [proData addTenementTopicDtoListObject:dynamic];
    }
    
    BOOL successful = [self saveContext:context];
    return successful;
}

+ (HWPropertyDetailClass *)searchAllPropertyData
{
    NSError *err = nil;
    AppDelegate *delegate = SHARED_APP_DELEGATE;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"HWPropertyDetailData" inManagedObjectContext:delegate.managedObjectContext];
    [request setEntity:entity];
    
//    NSSortDescriptor *sortDes = [NSSortDescriptor sortDescriptorWithKey:@"sortId" ascending:YES];
//    [request setSortDescriptors:[NSArray arrayWithObject:sortDes]];
    
    NSArray *proData = [delegate.managedObjectContext executeFetchRequest:request error:&err];
    if (proData.count <= 0)
    {
        return nil;
    }
    HWPropertyDetailData *data = proData[0];
    HWPropertyDetailClass *property = [[HWPropertyDetailClass alloc] init];
    property.name = data.name;
    property.intro = data.intro;
    property.address = data.address;
    property.openTime = data.openTime;
    property.tenementId = data.tenementId;
    property.callTimes = data.callTimes;

    NSSet *listSet = data.tenementTopicDtoList;
    
    NSSortDescriptor *sd = [[NSSortDescriptor alloc] initWithKey:@"sortId" ascending:YES];
    
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sd, nil];
    NSArray *array = [listSet sortedArrayUsingDescriptors:sortDescriptors];
    NSMutableArray *arrNews = [NSMutableArray array];
    for (int i = 0; i < array.count; i ++)
    {
        HWPropertyDynamic *dynamic = (HWPropertyDynamic *)array[i];
        HWPropertyNewsClass *news = [[HWPropertyNewsClass alloc] init];
        news.content = dynamic.content;
        news.creater = dynamic.creater;
        news.createTime = dynamic.createTime;
        news.fileName = dynamic.fileName;
        news.releaseType = dynamic.releaseType;
        news.systemTime = dynamic.systemTime;
        news.timeDistance = dynamic.timeDistance;
        news.topic = dynamic.topic;
        news.topicId = dynamic.topicId;
        news.url = dynamic.url;
        [arrNews addObject:news];
    }
    
    property.arrServiceTrack = arrNews;
    
    return property;
    
}

+ (BOOL)clearPropertyData
{
    return [self deleteOneEntityAllData:@"HWPropertyDetailData"];
}

+ (BOOL)saveNeighbourList:(NSArray *)neighbourList
{
    if (![self clearNeighbourList])
    {
        NSLog(@"清除邻里圈列表失败");
    }
    AppDelegate *delegate = SHARED_APP_DELEGATE;
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    context.parentContext = delegate.managedObjectContext;
    
    for (int i = 0; i < neighbourList.count; i++)
    {
        HWNeighbourItemClass *itemClass = neighbourList[i];
        
        HWNeighbour *neighbour = [NSEntityDescription insertNewObjectForEntityForName:@"HWNeighbour" inManagedObjectContext:context];
        neighbour.sortId = [NSNumber numberWithInt:i];
        neighbour.anonymity = itemClass.anonymity;
        neighbour.audioURL = itemClass.audioURL ;
        neighbour.author = itemClass.author ;
        neighbour.cardID = itemClass.cardID ;
        neighbour.cardType = itemClass.cardType ;
        neighbour.commentCount = itemClass.commentCount ;
        neighbour.content = itemClass.content ;
        neighbour.createDate = itemClass.createDate ;
        neighbour.headUrl = itemClass.headUrl ;
        neighbour.pictureURL = itemClass.pictureURL ;
        neighbour.title = itemClass.title ;
        neighbour.villageId = itemClass.villageId ;
        neighbour.villageName = itemClass.villageName ;
        neighbour.callId = itemClass.callId;
        neighbour.callTime = itemClass.callTime;
        neighbour.callNumber = itemClass.callNumber;
        neighbour.callName = itemClass.callName;
        neighbour.createId = itemClass.createId;
        neighbour.createName = itemClass.createName;
        neighbour.createCity = itemClass.createCity;
        neighbour.isShowReport = itemClass.isShowReport;
        neighbour.phoneHistoryId = itemClass.phoneHistoryId;
        neighbour.coStatus = itemClass.coStatus;
        neighbour.shopId = itemClass.shopId;
        neighbour.viewRange = itemClass.viewRange;
        neighbour.creater = itemClass.creater;
        neighbour.likeCount = itemClass.likeCount;
        neighbour.isPraise = itemClass.isPraise;
        neighbour.isNeighbour = itemClass.isNeighbour;
        neighbour.soundTime = itemClass.soundTime;
        neighbour.replyCount = itemClass.replyCount;
        neighbour.channelId = itemClass.channelId;
        neighbour.channelName = itemClass.channelName;
        neighbour.businessType = itemClass.businessType;
        neighbour.userId = itemClass.userId;
        
    }
    BOOL successful = [self saveContext:context];
    return successful;
}

/**
 *	@brief	更新一条数据
 *
 *	@param 	item 	更改后的对象
 *
 *	@return	N/A
 */
+ (BOOL)updateNeighbour:(HWNeighbourItemClass *)item
{
    AppDelegate *delegate = SHARED_APP_DELEGATE;
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    context.parentContext = delegate.managedObjectContext;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"cardID=%@",item.cardID];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"HWNeighbour" inManagedObjectContext:context];
    [request setEntity:entity];
    [request setPredicate:predicate];
    NSError *error = nil;
    NSArray *neighbourArray = [context executeFetchRequest:request error:&error];
    HWNeighbour *neighbour = [neighbourArray pObjectAtIndex:0];
    neighbour.isPraise = item.isPraise;
    neighbour.likeCount = item.likeCount;
    BOOL successful = [self saveContext:context];
    return successful;
}


+ (NSMutableArray *)loadNieghbourList
{
    NSError *error = nil;
    AppDelegate *delegate = SHARED_APP_DELEGATE;
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"HWNeighbour" inManagedObjectContext:delegate.managedObjectContext];
    [request setEntity:entity];
    
    NSSortDescriptor *sortDes = [NSSortDescriptor sortDescriptorWithKey:@"sortId" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:sortDes]];
    
    NSArray *neighbourList = [delegate.managedObjectContext executeFetchRequest:request error:&error];
    if (!neighbourList)
    {
        NSLog(@"查询无结果");
    }
    NSMutableArray *neighbourArray = [NSMutableArray array];
    for (int i = 0; i < neighbourList.count; i++)
    {
        
        HWNeighbour *neighbour = neighbourList[i];
        HWNeighbourItemClass *itemClass = [[HWNeighbourItemClass alloc]init];
        itemClass.cardID = neighbour.cardID;
        itemClass.anonymity = neighbour.anonymity ;
        itemClass.audioURL = neighbour.audioURL ;
        itemClass.author = neighbour.author ;
        itemClass.cardType = neighbour.cardType ;
        itemClass.commentCount = neighbour.commentCount ;
        itemClass.content = neighbour.content ;
        itemClass.createDate = neighbour.createDate ;
        itemClass.headUrl = neighbour.headUrl ;
        itemClass.pictureURL = neighbour.pictureURL ;
        itemClass.title = neighbour.title ;
        itemClass.villageName = neighbour.villageName ;
        itemClass.villageId = neighbour.villageId;
        itemClass.callId = neighbour.callId;
        itemClass.callTime = neighbour.callTime;
        itemClass.callNumber = neighbour.callNumber;
        itemClass.callName = neighbour.callName;
        itemClass.createId = neighbour.createId;
        itemClass.createName = neighbour.createName;
        itemClass.isShowReport = neighbour.isShowReport;
        itemClass.createCity = neighbour.createCity;
        itemClass.phoneHistoryId = neighbour.phoneHistoryId;
        itemClass.coStatus = neighbour.coStatus;
        itemClass.shopId = neighbour.shopId;
        itemClass.viewRange = neighbour.viewRange;
        
        itemClass.likeCount = neighbour.likeCount;
        itemClass.isPraise = neighbour.isPraise;
        itemClass.isNeighbour = neighbour.isNeighbour;
        itemClass.soundTime = neighbour.soundTime;
        itemClass.replyCount = neighbour.replyCount;
        itemClass.channelId = neighbour.channelId;
        itemClass.channelName = neighbour.channelName;
        itemClass.businessType = neighbour.businessType;
        itemClass.userId = neighbour.userId;
        itemClass.creater = neighbour.creater;
        
        
        [neighbourArray addObject:itemClass];
    }
    
    return neighbourArray;
}
+ (BOOL)clearNeighbourList
{
    return [self deleteOneEntityAllData:@"HWNeighbour"];
}


#pragma mark -
#pragma mark    **表 操作

/**
 *	@brief	添加新通知
 *
 *	@param 	notifyDic 	通知参数
 *
 *	@return	YES/NO
 */
+ (BOOL)addNotification:(NSDictionary *)notifyDic
{
    // content
    return YES;
}

/**
 *	@brief	查询所有通知
 *
 *	@return	数组
 */
+ (NSArray *)searchAllNotification
{
    // content
    return nil;
}

/**
 *	@brief	删除所有通知
 *
 *	@return	YES/NO
 */
+ (BOOL)removeAllNotification
{
    // content
    return YES;
}

/**
 *	@brief	根据Id删除指定通知
 *
 *	@param 	targetId 	目标id
 *
 *	@return	YES/NO
 */
+ (BOOL)removeNotificationBy:(NSString *)targetId
{
    // content
    return YES;
}
//add by gusheng
#pragma - mark 优惠劵做缓存
//优惠劵列表数据缓存
+(BOOL)addPriviledgeItem:(NSArray *)priviledgeList
{
    AppDelegate* delegate = SHARED_APP_DELEGATE;
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    context.parentContext = delegate.managedObjectContext;
    for (int i = 0 ; i < [priviledgeList count] ; i++)
    {
        HWPriviledgeModel *priviledgeModel = [priviledgeList objectAtIndex:i];
        HWPriviledgeItem*priviledgeItem = [NSEntityDescription insertNewObjectForEntityForName:@"HWPriviledgeItem" inManagedObjectContext:context];
        priviledgeItem.couponId = priviledgeModel.priviledgeId;
        priviledgeItem.timestr = priviledgeModel.timeStr;
        priviledgeItem.listPic = priviledgeModel.priviledgeImageUrl;
        priviledgeItem.status = priviledgeModel.priviledgeType;
        priviledgeItem.sortKey = [NSString stringWithFormat:@"%d",i + 1 + 100];
    }
    BOOL successful = [self saveContext:context];
    return successful;
}
+ (NSArray *)searchAllPriviledgeItem
{
    AppDelegate *delegate = SHARED_APP_DELEGATE;
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"HWPriviledgeItem" inManagedObjectContext:delegate.managedObjectContext];
    [request setEntity:entity];
    NSSortDescriptor *sortDes = [NSSortDescriptor sortDescriptorWithKey:@"sortKey" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:sortDes]];
    
    NSArray *items = [delegate.managedObjectContext executeFetchRequest:request error:nil];
    NSMutableArray *result = [NSMutableArray array];
    for (HWPriviledgeItem *item in items)
    {
        HWPriviledgeModel *priviledgeItem = [[HWPriviledgeModel alloc] init];
        priviledgeItem.priviledgeId = item.couponId;
        priviledgeItem.timeStr = item.timestr;
        priviledgeItem.priviledgeImageUrl = item.listPic;
        priviledgeItem.priviledgeType = item.status;
        [result addObject:priviledgeItem];
    }
    return result;
    
}
+ (BOOL)removeAllPriviledgeItem
{
    return [self deleteOneEntityAllData:@"HWPriviledgeItem"];
}

#pragma - mark  我的优惠劵列表
+(BOOL)addPriviledgeListItem:(NSArray *)priviledgeList
{
    AppDelegate* delegate = SHARED_APP_DELEGATE;
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    context.parentContext = delegate.managedObjectContext;
    
    for (int i=0; i<[priviledgeList count]; i++)
    {
        HWMyPriviledgeModel *priviledgeModel = [priviledgeList objectAtIndex:i];
        HWPriviledgeList*priviledgeItem = [NSEntityDescription insertNewObjectForEntityForName:@"HWPriviledgeList" inManagedObjectContext:context];
        priviledgeItem.priviledgeId = priviledgeModel.priviledgeIdStr;
        priviledgeItem.priviledgeNum = priviledgeModel.priviledgeNumStr;
        priviledgeItem.priviledgeUrl = priviledgeModel.priviledgeImageUrl;
        priviledgeItem.status = priviledgeModel.priviledgeStatus;
        
        priviledgeItem.sortKey = [NSString stringWithFormat:@"%d",i + 1 + 100];
    }
    BOOL successful = [self saveContext:context];
    return successful;
}
+ (NSArray *)searchAllPriviledgeListItem
{
    AppDelegate *delegate = SHARED_APP_DELEGATE;
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"HWPriviledgeList" inManagedObjectContext:delegate.managedObjectContext];
    [request setEntity:entity];
    NSSortDescriptor *sortDes = [NSSortDescriptor sortDescriptorWithKey:@"sortKey" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:sortDes]];
    
    NSArray *items = [delegate.managedObjectContext executeFetchRequest:request error:nil];
    NSMutableArray *result = [NSMutableArray array];
    for (HWPriviledgeList *item in items)
    {
        HWMyPriviledgeModel *priviledgeItem = [[HWMyPriviledgeModel alloc] init];
        priviledgeItem.priviledgeIdStr = item.priviledgeId;
        priviledgeItem.priviledgeNumStr = item.priviledgeNum;
        priviledgeItem.priviledgeImageUrl = item.priviledgeUrl;
        priviledgeItem.priviledgeStatus = item.status;
        [result addObject:priviledgeItem];
    }
    return result;
    
}
+ (BOOL)removeAllPriviledgeListItem
{
    return [self deleteOneEntityAllData:@"HWPriviledgeList"];
}
//end

+ (BOOL)addShareItem:(NSArray *)shareList
{
    AppDelegate* delegate = SHARED_APP_DELEGATE;
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    context.parentContext = delegate.managedObjectContext;
    for (int i = 0; i < shareList.count; i++)
    {
        HWShareItemClass *item = [shareList objectAtIndex:i];
        HWShareItem *shareItem = [NSEntityDescription insertNewObjectForEntityForName:@"HWShareItem" inManagedObjectContext:context];
        shareItem.activityId = item.activityId;
        shareItem.houseId = item.houseId;
        shareItem.shareUrl = item.shareUrl;
        shareItem.housePic = item.housePic;
        shareItem.activityTitle = item.activityTitle;
        shareItem.activityContent = item.activityContent;
        shareItem.lastTime = item.lastTime;
        shareItem.housePromo = item.housePromo;
        shareItem.houseAvgPrice = item.houseAvgPrice;
        shareItem.houseAddress = item.houseAddress;
        shareItem.houseName = item.houseName;
        shareItem.shareState = item.shareState;
        shareItem.totalMoney = item.totalMoney;
        shareItem.sharedMoney = item.sharedMoney;
        shareItem.restMoney = item.restMoney;
        shareItem.shareLinkTitle = item.shareLinkTitle;
        shareItem.localPhone = item.localPhone;
        shareItem.totalSharedAmount = item.totalSharedAmount;
        shareItem.startTime = item.startTime;
        shareItem.freezeRemainMillis = item.freezeRemainMillis;
        shareItem.haiwaiCountry = item.haiwaiCountry;
        shareItem.sharedTime = item.sharedTime;
        shareItem.started = item.started;
        shareItem.sortKey = [NSString stringWithFormat:@"%d",i + 1 + 100];
    }
    BOOL successful = [self saveContext:context];
    return successful;
}


+ (NSArray *)searchAllShareItem
{
    AppDelegate *delegate = SHARED_APP_DELEGATE;
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"HWShareItem" inManagedObjectContext:delegate.managedObjectContext];
    [request setEntity:entity];
    NSSortDescriptor *sortDes = [NSSortDescriptor sortDescriptorWithKey:@"sortKey" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:sortDes]];
    
    NSArray *items = [delegate.managedObjectContext executeFetchRequest:request error:nil];
    NSMutableArray *result = [NSMutableArray array];
    for (HWShareItem *item in items)
    {
        HWShareItemClass *shareItem = [[HWShareItemClass alloc] init];
        shareItem.activityId = item.activityId;
        shareItem.houseId = item.houseId;
        shareItem.shareUrl = item.shareUrl;
        shareItem.housePic = item.housePic;
        shareItem.activityTitle = item.activityTitle;
        shareItem.activityContent = item.activityContent;
        shareItem.lastTime = item.lastTime;
        shareItem.housePromo = item.housePromo;
        shareItem.houseAvgPrice = item.houseAvgPrice;
        shareItem.houseAddress = item.houseAddress;
        shareItem.houseName = item.houseName;
        shareItem.shareState = item.shareState;
        shareItem.totalMoney = item.totalMoney;
        shareItem.sharedMoney = item.sharedMoney;
        shareItem.restMoney = item.restMoney;
        shareItem.shareLinkTitle = item.shareLinkTitle;
        shareItem.localPhone = item.localPhone;
        shareItem.totalSharedAmount = item.totalSharedAmount;
        shareItem.startTime = item.startTime;
        shareItem.freezeRemainMillis = item.freezeRemainMillis;
        shareItem.haiwaiCountry = item.haiwaiCountry;
        shareItem.sharedTime = item.sharedTime;
        shareItem.started = item.started;
        [result addObject:shareItem];
    }
    
    return result;
    
}
+ (BOOL)removeAllShareItem
{
    return [self deleteOneEntityAllData:@"HWShareItem"];
}

//服务汇banner（合作物业）
+ (BOOL)saveServiceBannerForCompanyWuYeModelArr:(NSArray *)modelArr
{
    [self removeAllBannerModelCompany];
    
    AppDelegate *delegate = SHARED_APP_DELEGATE;
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    context.parentContext = delegate.managedObjectContext;
    for (int i = 0; i < modelArr.count; i ++)
    {
        HWActivityModel *activityModel = modelArr[i];
        HWServiceBannerCompany *activityItem = [NSEntityDescription insertNewObjectForEntityForName:@"HWServiceBannerCompany" inManagedObjectContext:context];
        activityItem.activityId = activityModel.activityId;
        activityItem.activityUrl = activityModel.activityURL;
        activityItem.activityName = activityModel.activityName;
        activityItem.activityPictureUrl = activityModel.activityPictureURL;
    }
    BOOL successful = [self saveContext:context];
    return successful;
}
+ (NSArray *)searchAllBannerModelForCompanyWuYe
{
    NSError *err = nil;
    AppDelegate *delegate = SHARED_APP_DELEGATE;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"HWServiceBannerCompany" inManagedObjectContext:delegate.managedObjectContext];
    [request setEntity:entity];
    NSArray *activityArr = [delegate.managedObjectContext executeFetchRequest:request error:&err];
    NSMutableArray *arrResult = [[NSMutableArray alloc] init];
    for (int i = 0; i < activityArr.count; i ++)
    {
        HWActivityModel *activityModel = [[HWActivityModel alloc] init];
        HWServiceBannerCompany *activityItem = activityArr[i];
        activityModel.activityId = activityItem.activityId;
        activityModel.activityURL = activityItem.activityUrl;
        activityModel.activityName = activityItem.activityName;
        activityModel.activityPictureURL = activityItem.activityPictureUrl;
        [arrResult addObject:activityModel];
    }
    
    return arrResult;
}
+ (BOOL)removeAllBannerModelCompany;
{
    return [self deleteOneEntityAllData:@"HWServiceBannerCompany"];
}

//首页Icon缓存
+ (BOOL)saveServiceIcomForCompanyModelArr:(NSArray *)modelArr
{
    AppDelegate* delegate = SHARED_APP_DELEGATE;
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    context.parentContext = delegate.managedObjectContext;
    for (int i = 0; i < modelArr.count; i++)
    {
        HWServiceIconModel *model = [modelArr objectAtIndex:i];
        HWServiceIconItem *iconItem = [NSEntityDescription insertNewObjectForEntityForName:@"HWServiceIconItem" inManagedObjectContext:context];
        iconItem.name = model.name;
        iconItem.iconMongoKey = model.iconMongoKey;
        iconItem.iconImgName = model.iconImgName;
        iconItem.linkUrl = model.linkUrl;
        iconItem.modelType = model.modelType;
        iconItem.classStr = model.classStr;
        iconItem.sortKey = [NSString stringWithFormat:@"%d",i + 1 + 100];
    }
    BOOL successful = [self saveContext:context];
    return successful;
}

+ (NSArray *)searchAllIcomModelForCompanyWuYe
{
    AppDelegate *delegate = SHARED_APP_DELEGATE;
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"HWServiceIconItem" inManagedObjectContext:delegate.managedObjectContext];
    [request setEntity:entity];
    NSSortDescriptor *sortDes = [NSSortDescriptor sortDescriptorWithKey:@"sortKey" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:sortDes]];
    
    NSArray *items = [delegate.managedObjectContext executeFetchRequest:request error:nil];
    NSMutableArray *result = [NSMutableArray array];
    for (HWServiceIconItem *iconItem in items)
    {
        HWServiceIconModel *model = [[HWServiceIconModel alloc] init];
        model.name = iconItem.name;
        model.iconMongoKey = iconItem.iconMongoKey;
        model.iconImgName = iconItem.iconImgName;
        model.linkUrl = iconItem.linkUrl;
        model.modelType = iconItem.modelType;
        model.classStr = iconItem.classStr;
        [result addObject:model];
    }
    
    return result;
}

+ (BOOL)removeAllIconModelForCompanyWuYe
{
    return [self deleteOneEntityAllData:@"HWServiceIconItem"];
}

+ (BOOL)saveShopList:(NSArray *)shopList
{
    [self clearShopList];
    AppDelegate *delegate = SHARED_APP_DELEGATE;
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    context.parentContext = delegate.managedObjectContext;
    for (int i = 0; i < shopList.count; i ++)
    {
        HWShopItemClass *shopItem = shopList[i];
        HWShopItem *shop = [NSEntityDescription insertNewObjectForEntityForName:@"HWShopItem" inManagedObjectContext:context];
        shop.shopId = shopItem.shopId;
        shop.shopName = shopItem.shopName;
        shop.dialCount = shopItem.dialCount;
        shop.sourceType = shopItem.sourceType;
        shop.iconUrl = shopItem.iconUrl;
        shop.phoneNumber = shopItem.phoneNumber;
        shop.mobileNumber = shopItem.mobileNumber;
        shop.auditStatus = shopItem.auditStatus;
        shop.outSell = shopItem.outSell;
        shop.outSellPic = shopItem.outSellPic;
//        shop.sortKey = [NSString stringWithFormat:@"%d", i];
    }
    BOOL successful = [self saveContext:context];
    return successful;
}
+ (NSMutableArray *)searchAllShopList
{
    NSError *err = nil;
    AppDelegate *delegate = SHARED_APP_DELEGATE;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"HWShopItem" inManagedObjectContext:delegate.managedObjectContext];
    [request setEntity:entity];
    NSArray *shops = [delegate.managedObjectContext executeFetchRequest:request error:&err];
    NSMutableArray *arrResult = [[NSMutableArray alloc] init];
    for (int i = 0; i < shops.count; i ++)
    {
        HWShopItemClass *shopClass = [[HWShopItemClass alloc] init];
        HWShopItem *shopItem = shops[i];
        shopClass.shopId = shopItem.shopId;
        shopClass.shopName = shopItem.shopName;
        shopClass.dialCount = shopItem.dialCount;
        shopClass.sourceType = shopItem.sourceType;
        shopClass.iconUrl = shopItem.iconUrl;
        shopClass.phoneNumber = shopItem.phoneNumber;
        shopClass.mobileNumber = shopItem.mobileNumber;
        shopClass.auditStatus = shopItem.auditStatus;
        shopClass.outSell = shopItem.outSell;
        shopClass.outSellPic = shopItem.outSellPic;
//        shopClass.sortKey = shopItem.sortKey;
        
        [arrResult addObject:shopClass];
    }
//    NSArray *tmpArray = [arrResult sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
//        
//        HWShopItemClass *app1 = (HWShopItemClass *)obj1;
//        HWShopItemClass *app2 = (HWShopItemClass *)obj2;
//        
//        if (app1.sortKey.intValue > app2.sortKey.intValue)
//        {
//            return NSOrderedDescending;
//        }
//        else if (app1.sortKey.intValue < app2.sortKey.intValue)
//        {
//            return NSOrderedAscending;
//        }
//        return NSOrderedSame;
//        
//    }];
    
    return arrResult;
}

+ (BOOL)clearShopList
{
    return [self deleteOneEntityAllData:@"HWShopItem"];
}

+ (BOOL)savePropertyList:(HWPropertyItemClass *)propertyList
{
    [self clearPropertyList];
    
    AppDelegate *delegate = SHARED_APP_DELEGATE;
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    context.parentContext = delegate.managedObjectContext;
    HWPropertyItem *propertyItem = [NSEntityDescription insertNewObjectForEntityForName:@"HWPropertyItem" inManagedObjectContext:context];
    propertyItem.propertyId = propertyList.propertyId;
    propertyItem.propertyName = propertyList.propertyName;
    propertyItem.phoneNumber = propertyList.phoneNumber;
    propertyItem.publicInform = propertyList.publicInform;
    propertyItem.dialCount = propertyList.dialCount;
    propertyItem.iconUrl = propertyList.iconUrl;
    
    BOOL successful = [self saveContext:context];
    return successful;
    
    return YES;
}

+ (HWPropertyItemClass *)searchAllPropertyList
{
    NSError *err = nil;
    AppDelegate *delegate = SHARED_APP_DELEGATE;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"HWPropertyItem" inManagedObjectContext:delegate.managedObjectContext];
    [request setEntity:entity];
    NSArray *propertys = [delegate.managedObjectContext executeFetchRequest:request error:&err];
    
    if (propertys.count == 0)
    {
        return nil;
    }
    
    HWPropertyItemClass *propertyClass = [[HWPropertyItemClass alloc] init];
    HWPropertyItem *propertyItem = propertys.lastObject;
    propertyClass.propertyId = propertyItem.propertyId;
    propertyClass.propertyName = propertyItem.propertyName;
    propertyClass.publicInform = propertyItem.publicInform;
    propertyClass.phoneNumber = propertyItem.phoneNumber;
    propertyClass.iconUrl = propertyItem.iconUrl;
    propertyClass.dialCount = propertyItem.dialCount;
    
    return propertyClass;
}

+ (BOOL)clearPropertyList
{
    return [self deleteOneEntityAllData:@"HWPropertyItem"];
}

// 首页应用图标
+ (BOOL)addApplicationListItem:(NSArray *)applicationList
{
    AppDelegate *delegate = SHARED_APP_DELEGATE;
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    context.parentContext = delegate.managedObjectContext;
    
    for (int i = 0; i < applicationList.count; i++)
    {
        HWApplicationModel *app = [applicationList objectAtIndex:i];
        HWApplicationItem *application = [NSEntityDescription insertNewObjectForEntityForName:@"HWApplicationItem" inManagedObjectContext:context];
        application.modelId = app.applicationId;
        application.name = app.name;
        application.type = app.type;
        application.iconUrl = app.iconUrl;
        application.appRangeDTOList = app.appRangeDTOList;
        application.appOrFolderIndex = app.appOrFolderIndex;
        application.iconMongodbKey = app.iconMongodbKey;
        application.isShelves = app.isShelves;
        application.sortKey = [NSString stringWithFormat:@"%d", i];
    }
    
    BOOL successful = [self saveContext:context];
    return successful;
}

+ (NSArray *)searchAllApplicaitionListItem
{
    NSError *err = nil;
    AppDelegate *delegate = SHARED_APP_DELEGATE;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"HWApplicationItem" inManagedObjectContext:delegate.managedObjectContext];
    NSSortDescriptor *sortDes = [NSSortDescriptor sortDescriptorWithKey:@"appOrFolderIndex" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:sortDes]];
    [request setEntity:entity];
    
    NSArray *applications = [delegate.managedObjectContext executeFetchRequest:request error:&err];
    NSMutableArray *arrResult = [[NSMutableArray alloc] init];
    for (int i = 0; i < applications.count; i++)
    {
        HWApplicationItem *application = [applications objectAtIndex:i];
        
        HWApplicationModel *app = [[HWApplicationModel alloc] init];
        app.applicationId = application.modelId;
        app.name = application.name;
        app.type = application.type;
        app.iconUrl = application.iconUrl;
        app.appRangeDTOList = application.appRangeDTOList;
        app.appOrFolderIndex = application.appOrFolderIndex;
        app.iconMongodbKey = application.iconMongodbKey;
        app.isShelves = application.isShelves;
        app.sortKey = application.sortKey;
        
        [arrResult addObject:app];
    }
    NSArray *tmpArray = [arrResult sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        HWApplicationModel *app1 = (HWApplicationModel *)obj1;
        HWApplicationModel *app2 = (HWApplicationModel *)obj2;
        
        if (app1.sortKey.intValue > app2.sortKey.intValue)
        {
            return NSOrderedDescending;
        }
        else if (app1.sortKey.intValue < app2.sortKey.intValue)
        {
            return NSOrderedAscending;
        }
        return NSOrderedSame;
        
    }];
    
    return tmpArray;
}

+ (BOOL)removeAllApplicationListItem
{
    return [self deleteOneEntityAllData:@"HWApplicationItem"];
}

// 首页广告
+ (BOOL)addActivityListItem:(NSArray *)activityList
{
    AppDelegate *delegate = SHARED_APP_DELEGATE;
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    context.parentContext = delegate.managedObjectContext;
    
    for (int i = 0; i < activityList.count; i++)
    {
        HWActivityModel *act = [activityList objectAtIndex:i];
        HWActivityItem *activity = [NSEntityDescription insertNewObjectForEntityForName:@"HWActivityItem" inManagedObjectContext:context];
        activity.activityId = act.activityId;
        activity.activityName = act.activityName;
        activity.activityPictureUrl = act.activityPictureURL;
        activity.activityUrl = act.activityURL;
        
    }
    BOOL successful = [self saveContext:context];
    return successful;
    
    return YES;
}

+ (NSArray *)searchAllActivityListItem
{
    NSError *err = nil;
    AppDelegate *delegate = SHARED_APP_DELEGATE;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"HWActivityItem" inManagedObjectContext:delegate.managedObjectContext];
    [request setEntity:entity];
    
    NSArray *activities = [delegate.managedObjectContext executeFetchRequest:request error:&err];
    NSMutableArray *arrResult = [[NSMutableArray alloc] init];
    for (int i = 0; i < activities.count; i++)
    {
        HWActivityItem *activity = [activities objectAtIndex:i];
        
        HWActivityModel *act = [[HWActivityModel alloc] init];
        act.activityId = activity.activityId;
        act.activityName = activity.activityName;
        act.activityPictureURL = activity.activityPictureUrl;
        act.activityURL = activity.activityUrl;
        
        [arrResult addObject:act];
    }
    return arrResult;
}

+ (BOOL)removeAllActivityListItem
{
    return [self deleteOneEntityAllData:@"HWActivityItem"];
}

//缓存推荐列表
+ (BOOL)addChannelItemForRecommend:(NSArray *)channelList
{
    [self removeAllChannelItemForRecommend];
    AppDelegate *delegate = SHARED_APP_DELEGATE;
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    context.parentContext = delegate.managedObjectContext;
    for (int i = 0; i < channelList.count; i++)
    {
        HWChannelModel *model = [channelList pObjectAtIndex:i];
        HWChannelItem *item = [NSEntityDescription insertNewObjectForEntityForName:@"HWChannelItem" inManagedObjectContext:context];
        item.chanaleId = model.channelId;
        item.channelIcon = model.channelIcon;
        item.channelName = model.channelName;
        item.partInCount = model.partInCount;
        item.createrName = model.createrName;
        item.sortKey = [NSString stringWithFormat:@"%d",i + 1 + 100];
    }
    return [self saveContext:context];
}

//读取推荐列表
+ (NSArray *)channelItemForRecommend
{
    NSError *error = nil;
    AppDelegate *del = SHARED_APP_DELEGATE;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"HWChannelItem"];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"HWChannelItem" inManagedObjectContext:del.managedObjectContext];
    [request setEntity:entity];
    NSSortDescriptor *sortDes = [NSSortDescriptor sortDescriptorWithKey:@"sortKey" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:sortDes]];
    
    NSArray * array = [del.managedObjectContext executeFetchRequest:request error:&error];
    NSMutableArray *mutalbeArr = [[NSMutableArray alloc]init];
    for (NSInteger i = 0; i < array.count; i++) {
        HWChannelItem *item = [array pObjectAtIndex:i];
        HWChannelModel *model = [[HWChannelModel alloc]init];
        model.channelName = item.channelName;
        model.channelId = item.chanaleId;
        model.channelIcon = item.channelIcon;
        model.createrName = item.createrName;
        model.partInCount = item.partInCount;
        model.channelColor = [Utility randColor];
        [mutalbeArr addObject:model];
    }
    return mutalbeArr;
}
//清空推荐列表
+ (BOOL)removeAllChannelItemForRecommend
{
    return [self deleteOneEntityAllData:@"HWChannelItem"];
}

//缓存足迹列表
+ (BOOL)addChannelItemForPastRecords:(NSArray *)channelList
{
    [self removeAllChannelItemForPastRecords];
    AppDelegate *delegate = SHARED_APP_DELEGATE;
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    context.parentContext = delegate.managedObjectContext;
    for (NSInteger i = 0; i < channelList.count; i++) {
        HWChannelModel *model = [channelList pObjectAtIndex:i];
        HWChannelItem *item = [NSEntityDescription insertNewObjectForEntityForName:@"HWChannelItemPastRecode" inManagedObjectContext:context];
        item.chanaleId = model.channelId;
        item.channelIcon = model.channelIcon;
        item.channelName = model.channelName;
        item.partInCount = model.partInCount;
        item.createrName = model.createrName;
    }
    return [self saveContext:context];
}

//读取足迹列表
+ (NSArray *)channelItemForPastRecords
{
    NSError *error = nil;
    AppDelegate *del = SHARED_APP_DELEGATE;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"HWChannelItemPastRecode"];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"HWChannelItemPastRecode" inManagedObjectContext:del.managedObjectContext];
    [request setEntity:entity];
    NSArray * array = [del.managedObjectContext executeFetchRequest:request error:&error];
    NSMutableArray *mutalbeArr = [[NSMutableArray alloc]init];
    for (NSInteger i = 0; i < array.count; i++) {
        HWChannelItem *item = [array pObjectAtIndex:i];
        HWChannelModel *model = [[HWChannelModel alloc]init];
        model.channelName = item.channelName;
        model.channelId = item.chanaleId;
        model.channelIcon = item.channelIcon;
        model.createrName = item.createrName;
        model.partInCount = item.partInCount;
        model.channelColor = [Utility randColor];
        [mutalbeArr addObject:model];
    }
    return mutalbeArr;
}

//清空足迹列表
+ (BOOL)removeAllChannelItemForPastRecords
{
    return [self deleteOneEntityAllData:@"HWChannelItemPastRecode"];
}

+ (BOOL)addNeighbourBannerModel:(NSArray *)bannerArr
{
    [self removeAllBannerModel];
    
    AppDelegate *delegate = SHARED_APP_DELEGATE;
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    context.parentContext = delegate.managedObjectContext;
    for (NSInteger i = 0; i < bannerArr.count; i++) {
        HWNeighbourBannerModel *model = [bannerArr pObjectAtIndex:i];
        HWNeighbourBanner *item = [NSEntityDescription insertNewObjectForEntityForName:@"HWNeighbourBanner" inManagedObjectContext:context];
        item.activityId = model.activityId;
        item.activityName = model.activityName;
        item.activityPictureURL = model.activityPictureURL;
        item.activityURL = model.activityURL;
    }
    return [self saveContext:context];
}

+ (NSArray *)bannerModel
{
    NSError *error = nil;
    AppDelegate *del = SHARED_APP_DELEGATE;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"HWNeighbourBanner"];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"HWNeighbourBanner" inManagedObjectContext:del.managedObjectContext];
    [request setEntity:entity];
    NSArray * array = [del.managedObjectContext executeFetchRequest:request error:&error];
    NSMutableArray *mutalbeArr = [[NSMutableArray alloc]init];
    for (NSInteger i = 0; i < array.count; i++) {
        HWNeighbourBanner *item = [array pObjectAtIndex:i];
        HWNeighbourBannerModel *model = [[HWNeighbourBannerModel alloc]init];
        model.activityId = item.activityId;
        model.activityName = item.activityName;
        model.activityPictureURL = item.activityPictureURL;
        model.activityURL = item.activityURL;
        [mutalbeArr addObject:model];
    }
    return mutalbeArr;
}

+ (BOOL)removeAllBannerModel
{
    return [self deleteOneEntityAllData:@"HWNeighbourBanner"];
}

+ (BOOL)addAlertTime:(NSMutableArray *)itemArr
{
    [HWCoreDataManager removeAllAlertItme];
    
    AppDelegate *delegate = SHARED_APP_DELEGATE;
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    context.parentContext = delegate.managedObjectContext;
    
    for (int i = 0; i < itemArr.count; i++)
    {
        HWAlertModel *item = [itemArr objectAtIndex:i];
        HWAlertItem *model = [NSEntityDescription insertNewObjectForEntityForName:@"HWAlertItem" inManagedObjectContext:context];
        model.goodsId = item.goodsId;
        model.alertTime = item.alertTime;
    }
    
    return [self saveContext:context];
}
+ (NSArray *)searchAllAlertTime
{
    NSError *err = nil;
    AppDelegate *delegate = SHARED_APP_DELEGATE;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"HWAlertItem" inManagedObjectContext:delegate.managedObjectContext];
    [request setEntity:entity];
    
    NSArray *alertItems = [delegate.managedObjectContext executeFetchRequest:request error:&err];
    NSMutableArray *arrResult = [[NSMutableArray alloc] init];
    for (int i = 0; i < alertItems.count; i++)
    {
        HWAlertItem *activity = [alertItems objectAtIndex:i];
        
        HWAlertModel *act = [[HWAlertModel alloc] init];
        act.goodsId = activity.goodsId;
        act.alertTime = activity.alertTime;
        
        [arrResult addObject:act];
    }
    return arrResult;
}
+ (BOOL)removeAlertItmeByGoodsId:(NSString *)goodsId
{
    NSError *error = nil;
    AppDelegate *delegate = SHARED_APP_DELEGATE;
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    context.parentContext = delegate.managedObjectContext;
    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"HWAlertItem" inManagedObjectContext:context];
    [request setEntity:entity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"goodsId=%@",goodsId];
    [request setPredicate:predicate];
    NSArray *array = [context executeFetchRequest:request error:&error];
    if (!array)
    {
        
    }
    else
    {
        for (NSInteger i = 0; i < array.count; i++)
        {
            HWAlertItem *item = [array pObjectAtIndex:i];
            [context deleteObject:item];
        }
    }
    return [self saveContext:context];
}

+ (BOOL)removeAllAlertItme
{
    return [self deleteOneEntityAllData:@"HWAlertItem"];
}



@end
