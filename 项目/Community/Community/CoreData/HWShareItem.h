//
//  HWShareItem.h
//  Community
//
//  Created by caijingpeng.haowu on 14-10-16.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface HWShareItem : NSManagedObject

@property (nonatomic, retain) NSString * activityContent;
@property (nonatomic, retain) NSString * activityId;
@property (nonatomic, retain) NSString * activityTitle;
@property (nonatomic, retain) NSString * freezeRemainMillis;
@property (nonatomic, retain) NSString * haiwaiCountry;
@property (nonatomic, retain) NSString * houseAddress;
@property (nonatomic, retain) NSString * houseAvgPrice;
@property (nonatomic, retain) NSString * houseId;
@property (nonatomic, retain) NSString * houseName;
@property (nonatomic, retain) NSString * housePic;
@property (nonatomic, retain) NSString * housePromo;
@property (nonatomic, retain) NSString * lastTime;
@property (nonatomic, retain) NSString * localPhone;
@property (nonatomic, retain) NSString * restMoney;
@property (nonatomic, retain) NSString * sharedMoney;
@property (nonatomic, retain) NSString * sharedTime;
@property (nonatomic, retain) NSString * shareLinkTitle;
@property (nonatomic, retain) NSString * shareState;
@property (nonatomic, retain) NSString * shareUrl;
@property (nonatomic, retain) NSString * sortKey;
@property (nonatomic, retain) NSString * startTime;
@property (nonatomic, retain) NSString * totalMoney;
@property (nonatomic, retain) NSString * totalSharedAmount;
@property (nonatomic, retain) NSString * started;

@end
