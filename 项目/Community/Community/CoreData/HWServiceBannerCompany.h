//
//  HWServiceBannerCompany.h
//  Community
//
//  Created by niedi on 15/7/13.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface HWServiceBannerCompany : NSManagedObject

@property (nonatomic, retain) NSString * activityId;
@property (nonatomic, retain) NSString * activityUrl;
@property (nonatomic, retain) NSString * activityName;
@property (nonatomic, retain) NSString * activityPictureUrl;

@end
