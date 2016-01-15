//
//  UIDevice+Resolutions.h
//  HaoWuAgenciesEdition
//
//  Created by zhuming on 14-6-14.
//  Copyright (c) 2014年 ZhuMing. All rights reserved.
//

#import <UIKit/UIKit.h>
enum {
    // iPhone 1,3,3GS 标准分辨率(320x480px)
    UIDevice_iPhoneStandardRes      = 1,
    // iPhone 4,4S 高清分辨率(640x960px)
    UIDevice_iPhoneHiRes            = 2,
    // iPhone 5 高清分辨率(640x1136px)
    UIDevice_iPhoneTallerHiRes      = 3,
    // iPad 1,2 标准分辨率(1024x768px)
    UIDevice_iPadStandardRes        = 4,
    // iPad 3 High Resolution(2048x1536px)
    UIDevice_iPadHiRes              = 5
}; typedef NSUInteger UIDeviceResolution;

@interface UIDevice (Resolutions)

+ (UIDeviceResolution) currentResolution;

+ (BOOL)isRunningOniPhone5;

+ (BOOL)isRunningOniPhone;

@end
