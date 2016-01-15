//
//  HWServiceIconModel.m
//  Community
//
//  Created by niedi on 15/6/9.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWServiceIconModel.h"

@implementation HWServiceIconModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        self.name = [dict stringObjectForKey:@"name"];
        self.linkUrl = [dict stringObjectForKey:@"linkUrl"];
        self.iconMongoKey = [dict stringObjectForKey:@"iconMongoKey"];
        self.modelType = [dict stringObjectForKey:@"type"];
        self.iconImgName = [dict stringObjectForKey:@"iconImgName"];
        
        if (self.iconMongoKey.length == 0 || [self.iconMongoKey isEqualToString:@" "])
        {
            if ([[self.linkUrl lowercaseString] isEqualToString:@"kaola:xt:wuye"])
            {
                self.iconImgName = @"wuye";
            }
            else if ([[self.linkUrl lowercaseString] isEqualToString:@"kaola:wyfw:jiaofei"])
            {
                self.iconImgName = @"wuyejiaofei";
            }
            self.iconMongoKey = @" ";
        }
        
        if (self.linkUrl.length == 0)
        {
            self.linkUrl = @" ";
        }
        if (self.modelType.length == 0)
        {
            self.modelType = @" ";
        }
        if (self.name.length == 0)
        {
            self.name = @" ";
        }
    }
    return self;
}



@end
