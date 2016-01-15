//
//  HWShareItemClass.h
//  Community
//
//  Created by caijingpeng.haowu on 14-9-15.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWShareItemClass : NSObject

@property (nonatomic, strong) NSString *activityId;
@property (nonatomic, strong) NSString *houseId;
@property (nonatomic, strong) NSString *shareUrl;
@property (nonatomic, strong) NSString *housePic;
@property (nonatomic, strong) NSString *activityTitle;
@property (nonatomic, strong) NSString *activityContent;
@property (nonatomic, strong) NSString *lastTime;
@property (nonatomic, strong) NSString *housePromo;
@property (nonatomic, strong) NSString *houseAvgPrice;
@property (nonatomic, strong) NSString *houseAddress;
@property (nonatomic, strong) NSString *houseName;
@property (nonatomic, strong) NSString *shareState;
@property (nonatomic, strong) NSString *totalMoney;
@property (nonatomic, strong) NSString *sharedMoney;
@property (nonatomic, strong) NSString *restMoney;
@property (nonatomic, strong) NSString *shareLinkTitle;
@property (nonatomic, strong) NSString *localPhone;
@property (nonatomic, strong) NSString *totalSharedAmount;
@property (nonatomic, strong) NSString *startTime;
@property (nonatomic, strong) NSString *freezeRemainMillis;
@property (nonatomic, strong) NSString *haiwaiCountry;
@property (nonatomic, strong) NSString *sharedTime;
@property (nonatomic, strong) NSString *started;

@property (nonatomic, strong) NSString * maxSharedMoney;
@property (nonatomic, strong) NSString * restNum;
@property (nonatomic, strong) NSString * shareMethod;



- (id)initWithDictionary:(NSDictionary *)dic;

@end
