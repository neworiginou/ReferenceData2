//
//  HWActivityItem.h
//  Community
//
//  Created by caijingpeng.haowu on 14-12-14.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface HWActivityItem : NSManagedObject

@property (nonatomic, retain) NSString * activityId;
@property (nonatomic, retain) NSString * activityUrl;
@property (nonatomic, retain) NSString * activityName;
@property (nonatomic, retain) NSString * activityPictureUrl;

@end
