//
//  HWPriviledgeItem.h
//  Community
//
//  Created by gusheng on 14-12-11.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface HWPriviledgeItem : NSManagedObject

@property (nonatomic, retain) NSString * couponId;
@property (nonatomic, retain) NSString * timestr;
@property (nonatomic, retain) NSString * listPic;
@property (nonatomic, retain) NSString * sortKey;
@property (nonatomic, retain) NSString * status;

@end
