//
//  HWCallDetectCenter.h
//  UnitTest
//
//  Created by caijingpeng.haowu on 14-9-13.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//
//  电话监听中心
//

#import <Foundation/Foundation.h>
#import <CoreTelephony/CTCallCenter.h>
#import <CoreTelephony/CTCall.h>

#define HWCallDetectCenterStateDisconnectedNotification         @"DisconnectedNotification"
#define HWCallDetectCenterStateConnectedNotification            @"ConnectedNotification"
#define HWCallDetectCenterStateIncomingNotification             @"IncomingNotification"
#define HWCallDetectCenterStateDialingNotification              @"DialingNotification"


@interface HWCallDetectCenter : NSObject
{
    CTCallCenter *_callCenter;
}

+ (id)shareInstance;

@end
