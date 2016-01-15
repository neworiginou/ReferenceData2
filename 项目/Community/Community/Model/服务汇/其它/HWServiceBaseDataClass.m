//
//  HWServiceBaseDataClass.m
//  Community
//
//  Created by lizhongqiang on 14-9-23.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWServiceBaseDataClass.h"

@implementation HWServiceBaseDataClass
@synthesize dictCodeText;
@synthesize dictId;
@synthesize disabled;
@synthesize iconMongodbKey;
@synthesize iconMongodbUrl;
-(id)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super init])
    {
        self.dictId = [dic stringObjectForKey:@"dictId"];
        self.dictCodeText = [dic stringObjectForKey:@"dictCodeText"];
        self.disabled = [dic stringObjectForKey:@"disabled"];
        self.iconMongodbKey = [dic stringObjectForKey:@"iconMongodbKey"];
        self.iconMongodbUrl = [dic stringObjectForKey:@"iconMongodbUrl"];
        
    }
    
    return self;
}
@end
