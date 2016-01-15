//
//  Utility-OC.h
//  Partner-Swift
//
//  Created by caijingpeng.haowu on 15/2/23.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Define-OC.h"
#import <CoreLocation/CoreLocation.h>

@interface Utility_OC : NSObject

+ (NSStringDrawingOptions)combine;
+ (NSString *)getUUID;
+ (BOOL)isPureInt:(NSString*)string;

+ (BOOL)isPureFloat:(NSString*)string;

+ (NSValue *)valueWithPoint:(CGPoint)pos;
+ (NSNumber *)numberWithFloat:(CGFloat)y;

//根据Xib生成
id loadObjectFromNib(NSString *nib, Class cls, id owner);

// 统一返回按钮
+ (UIBarButtonItem*)navLeftBackBtn:(id)_target action:(SEL)selector;

// 创建navigation title view
+ (UIView *)navTitleView:(NSString *)_title;

+ (UIBarButtonItem *)navButton:(id)_target action:(SEL)selector image:(UIImage *)image;

// 单纯文字导航
+ (UIBarButtonItem *)navButton:(id)_target title:(NSString*)title action:(SEL)selector;

+ (BOOL)isCardNo:(NSString *)bankCardNumber;

+ (NSURL *)getStaticMapUrlByCoordinate2D:(CLLocationCoordinate2D)coordinate;

+ (NSString *)conversionThousandth:(NSString *)string;

//参数转换
+ (NSString *)getMoneyTypeWithStr:(NSString *)str;

+ (NSString *)encryptParameter:(NSDictionary *)dic;
+ (NSString *)md5:(NSString *)str;

@end
