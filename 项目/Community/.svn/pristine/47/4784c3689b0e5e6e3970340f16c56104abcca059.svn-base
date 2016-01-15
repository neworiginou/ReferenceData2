//
//  HWRequest.m
//  Haowu_3.0
//
//  Created by PengHuang on 13-11-28.
//  Copyright (c) 2013年 PengHuang. All rights reserved.
//

#import "HWRequest.h"
#import "AFNetworking.h"
//#import "UIKit+AFNetworking.h"

@implementation HWRequest

+ (HWRequest *)getHWRequestInstance {
    static HWRequest *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[HWRequest alloc] init];
    });
    return sharedInstance;
}

@end
