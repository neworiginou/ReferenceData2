//
//  HWChannelItemPastRecode.h
//  Community
//
//  Created by niedi on 15/5/6.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface HWChannelItemPastRecode : NSManagedObject

@property (nonatomic, retain) NSString * chanaleId;
@property (nonatomic, retain) NSString * channelIcon;
@property (nonatomic, retain) NSString * channelName;
@property (nonatomic, retain) NSString * createrName;
@property (nonatomic, retain) NSString * partInCount;

@end
