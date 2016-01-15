//
//  HWActivityModel.m
//  Community
//
//  Created by caijingpeng.haowu on 14-12-12.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWActivityModel.h"

@implementation HWActivityModel

@synthesize activityId;
@synthesize activityName;
@synthesize activityPictureURL;
@synthesize activityURL;

- (id)initWithAcitivity:(NSDictionary *)info
{
    self = [super init];
    if (self)
    {
        self.activityId = [info stringObjectForKey:@"activityId"];
        self.activityName = [info stringObjectForKey:@"activityName"];
        self.activityPictureURL = [info stringObjectForKey:@"activityPictureURL"];
        self.activityURL = [info stringObjectForKey:@"activityURL"];
    }
    return self;
}

@end
