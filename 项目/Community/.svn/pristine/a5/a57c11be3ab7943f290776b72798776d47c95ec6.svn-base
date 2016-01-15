//
//  HWCallDetectCenter.m
//  UnitTest
//
//  Created by caijingpeng.haowu on 14-9-13.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWCallDetectCenter.h"

@implementation HWCallDetectCenter

static HWCallDetectCenter *_shareCenter = nil;

+ (id)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareCenter = [[HWCallDetectCenter alloc] init];
        [_shareCenter detectCall];
    });
    return _shareCenter;
}

- (void)detectCall
{
    _callCenter = [[CTCallCenter alloc] init];
    _callCenter.callEventHandler=^(CTCall* call)
    {
        if (call.callState == CTCallStateDisconnected)
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:HWCallDetectCenterStateDisconnectedNotification object:nil];
            NSLog(@"Call has been disconnected");
            //self.viewController.signalStatus=YES;
        }
        else if (call.callState == CTCallStateConnected)
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:HWCallDetectCenterStateConnectedNotification object:nil];
            NSLog(@"Call has just been connected");
        }
        else if(call.callState == CTCallStateIncoming)
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:HWCallDetectCenterStateIncomingNotification object:nil];
            NSLog(@"Call is incoming");
            //self.viewController.signalStatus=NO;
        }
        
        else if (call.callState == CTCallStateDialing)
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:HWCallDetectCenterStateDialingNotification object:nil];
            //self.viewController.signalStatus=YES;
            
            NSLog(@"call is dialing");
        }
        else
        {
            // [mySelf popAlertView];
            NSLog(@"Nothing is done");
        }
    };
}



@end
