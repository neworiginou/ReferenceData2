//
//  HWCheckForceUpdateWidget.h
//  MoreHouse
//
//  Created by caijingpeng.haowu on 14/12/25.
//  Copyright (c) 2014年 lizhongqiang. All rights reserved.
//
//  强制更新 检查更新模块

#import <Foundation/Foundation.h>
#import "Reachability.h"

@interface HWCheckForceUpdateWidget : NSObject<UIAlertViewDelegate>
{
    NSString *_isForceUpdate;
    NSString *_forceUpdateMsg;
}

@property (nonatomic, strong) UIView *dependView;
@property (nonatomic, strong) Reachability *reachabiltiy;

- (id)initWithDependView:(UIView *)view;

- (void)checkForceUpdateVersion;

//- (void)checkAppVersion; // app store 检查更新
//- (void)checkForceUpdate;  // 在程序启动时检查是否有强制更新
//- (void)checkAppVersionNoAlert;

@end
