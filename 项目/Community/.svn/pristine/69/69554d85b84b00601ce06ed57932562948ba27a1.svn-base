//
//  TuiGuangYuan.h
//  TuiGuangYuan
//
//  Created by DingXiao on 14-6-15.
//  Copyright (c) 2014年 DingXiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#define TuiGuangYuan_APP_KEY @"10007"    //appKey
#define TuiGuangYuan_APP_SECRECT @"htg8l8d866wfsrqbgynw" //appSecret

@interface TuiGuangYuanUI : NSObject
/**
 *   active the app With the appKey and appSecrect;
 */
+ (void)activeTuiGuangYuanWithAppKey:(NSString *)appKey andAppScrect:(NSString *)appSecret;

/**
 *   show the promotion vc
 */
+ (void)showTuiGuangYuanPromotionWith:(UIViewController *)viewController andAppkey:(NSString *)appKey andAppSecret:(NSString*)appSecret;

/**
 *  custom event
 */

+ (void)customEventWithAppKey:(NSString *)appKey AndAppScrect:(NSString *)appSecret AndEventCode:(NSString *)eventCode AndAmount:(NSString *)amount AndContent:(NSString *)content;

/**
 * device id
 */
+(NSString *)deviceId;

/**
 * startup
 */

+(void)startUpAppKey:(NSString *)appKey AndAppScrect:(NSString *)appSecret;


@end
