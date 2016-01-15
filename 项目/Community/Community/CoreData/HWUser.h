//
//  HWUser.h
//  Community
//
//  Created by niedi on 15/8/4.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface HWUser : NSManagedObject

@property (nonatomic, retain) NSString * acceptNotify;
@property (nonatomic, retain) NSString * avatarUrl;
@property (nonatomic, retain) NSString * cityId;
@property (nonatomic, retain) NSString * cityName;
@property (nonatomic, retain) NSString * coStatus;
@property (nonatomic, retain) NSString * dataVersion;
@property (nonatomic, retain) NSString * deviceId;
@property (nonatomic, retain) NSString * favorite;
@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSString * gpsCityId;
@property (nonatomic, retain) NSString * gpsCityName;
@property (nonatomic, retain) NSString * gpsLocation;
@property (nonatomic, retain) NSString * isAuth;
@property (nonatomic, retain) NSString * isBindMobile;
@property (nonatomic, retain) NSString * isBindWeixin;
@property (nonatomic, retain) NSString * key;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * nickname;
@property (nonatomic, retain) NSString * openId;
@property (nonatomic, retain) NSString * propertyNotify;
@property (nonatomic, retain) NSString * residentId;
@property (nonatomic, retain) NSString * saveFrontGpsCityId;
@property (nonatomic, retain) NSString * shakeNotify;
@property (nonatomic, retain) NSString * shopId;
@property (nonatomic, retain) NSString * shopNotify;
@property (nonatomic, retain) NSString * soundNotify;
@property (nonatomic, retain) NSString * telephoneNum;
@property (nonatomic, retain) NSString * tenementId;
@property (nonatomic, retain) NSString * userId;
@property (nonatomic, retain) NSString * villageAddress;
@property (nonatomic, retain) NSString * villageId;
@property (nonatomic, retain) NSString * villageName;
@property (nonatomic, retain) NSString * weixinNickname;
@property (nonatomic, retain) NSString * source;

@end
