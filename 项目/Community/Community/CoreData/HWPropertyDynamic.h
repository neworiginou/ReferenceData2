//
//  HWPropertyDynamic.h
//  Community
//
//  Created by lizhongqiang on 14/11/5.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class HWPropertyDetailData;

@interface HWPropertyDynamic : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSString * creater;
@property (nonatomic, retain) NSString * createTime;
@property (nonatomic, retain) NSString * fileName;
@property (nonatomic, retain) NSString * releaseType;
@property (nonatomic, retain) NSString * systemTime;
@property (nonatomic, retain) NSString * timeDistance;
@property (nonatomic, retain) NSString * topic;
@property (nonatomic, retain) NSString * topicId;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSNumber * sortId;
@property (nonatomic, retain) HWPropertyDetailData *list;

@end
