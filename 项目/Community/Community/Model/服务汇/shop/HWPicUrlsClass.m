//
//  HWPicUrlsClass.m
//  Community
//
//  Created by lizhongqiang on 14-9-11.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWPicUrlsClass.h"

@implementation HWPicUrlsClass
@synthesize pic1;
@synthesize pic2;
@synthesize pic3;
@synthesize pic4;
@synthesize pic5;

-(id)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super init])
    {
        self.pic1 = [dic stringObjectForKey:@"pic1"];
        self.pic2 = [dic stringObjectForKey:@"pic2"];
        self.pic3 = [dic stringObjectForKey:@"pic3"];
        self.pic4 = [dic stringObjectForKey:@"pic4"];
        self.pic5 = [dic stringObjectForKey:@"pic5"];
    }
    return self;
}

@end
