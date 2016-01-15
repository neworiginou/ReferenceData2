//
//  HWCatoryClass.m
//  Community
//
//  Created by gusheng on 14-9-21.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWCatoryClass.h"

@implementation HWCatoryClass
@synthesize catoryId;
@synthesize catoryImageUrl;
@synthesize catoryName;
-(id)initWithDic:(NSDictionary *)dic
{
    if (self = [super init])
    {
        self.catoryName = [dic stringObjectForKey:@"dictCodeText"];
        NSURL *catoryUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@/hw-sq-app-web/file/downloadByKey.do?mKey=%@&key=%@",kUrlBase,[dic stringObjectForKey:@"iconMongodbKey"],[HWUserLogin currentUserLogin].key]];
        self.catoryImageUrl = catoryUrl;
        self.catoryId = [dic stringObjectForKey:@"dictId"];
    }
    return self;
}
@end
