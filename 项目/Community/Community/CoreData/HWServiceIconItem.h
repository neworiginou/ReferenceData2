//
//  HWServiceIconItem.h
//  Community
//
//  Created by niedi on 15/7/13.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface HWServiceIconItem : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * iconMongoKey;
@property (nonatomic, retain) NSString * iconImgName;
@property (nonatomic, retain) NSString * linkUrl;
@property (nonatomic, retain) NSString * modelType;
@property (nonatomic, retain) NSString * classStr;
@property (nonatomic, retain) NSString * sortKey;

@end
