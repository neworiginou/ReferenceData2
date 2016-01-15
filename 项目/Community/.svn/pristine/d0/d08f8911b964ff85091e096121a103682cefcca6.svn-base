//
//  HWApplicationModel.m
//  Community
//
//  Created by caijingpeng.haowu on 14-12-10.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWApplicationModel.h"

@implementation HWApplicationModel

@synthesize applicationId;
@synthesize name;
@synthesize type;
@synthesize iconUrl;
@synthesize appOrFolderIndex;
@synthesize iconMongodbKey;
@synthesize isShelves;

- (id)initWithApplicationInfo:(NSDictionary *)info
{
    self = [super init];
    if (self)
    {
        self.applicationId = [info stringObjectForKey:@"id"];
        self.name = [info stringObjectForKey:@"name"];
        self.type = [info stringObjectForKey:@"type"];
        self.iconUrl = [info stringObjectForKey:@"iconUrl"];
        self.appOrFolderIndex = [info stringObjectForKey:@"appOrFolderIndex"];
        self.iconMongodbKey = [info stringObjectForKey:@"iconMongodbKey"];
        self.isShelves = [info stringObjectForKey:@"isShelves"];
        self.appRangeDTOList = [info stringObjectForKey:@"appRangeDTOList"];
    }
    return self;
}

@end
