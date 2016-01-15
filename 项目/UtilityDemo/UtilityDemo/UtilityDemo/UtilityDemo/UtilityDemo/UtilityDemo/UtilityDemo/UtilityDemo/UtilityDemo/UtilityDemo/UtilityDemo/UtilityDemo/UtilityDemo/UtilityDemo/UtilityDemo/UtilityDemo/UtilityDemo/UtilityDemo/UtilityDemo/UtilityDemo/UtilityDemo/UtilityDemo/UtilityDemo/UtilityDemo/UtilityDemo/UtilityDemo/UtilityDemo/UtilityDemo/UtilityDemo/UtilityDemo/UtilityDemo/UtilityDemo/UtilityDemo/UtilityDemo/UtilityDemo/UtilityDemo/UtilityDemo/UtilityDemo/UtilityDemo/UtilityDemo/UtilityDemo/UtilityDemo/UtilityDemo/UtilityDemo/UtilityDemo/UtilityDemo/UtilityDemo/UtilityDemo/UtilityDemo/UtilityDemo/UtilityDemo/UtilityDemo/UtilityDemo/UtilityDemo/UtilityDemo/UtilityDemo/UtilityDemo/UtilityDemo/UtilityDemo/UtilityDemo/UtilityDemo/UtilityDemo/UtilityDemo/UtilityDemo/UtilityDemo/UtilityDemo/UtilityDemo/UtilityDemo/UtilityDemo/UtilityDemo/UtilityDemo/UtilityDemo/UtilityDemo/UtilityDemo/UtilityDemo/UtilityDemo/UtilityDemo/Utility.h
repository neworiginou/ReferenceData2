//
//  Utility.h
//  UtilityDemo
//
//  Created by wuxiaohong on 15/3/30.
//  Copyright (c) 2015年 hw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

@interface Utility : NSObject
//计算字符串的字数，
+ (int)calculateTextLength:(NSString *)text;

//动态计算字符串高度
+ (CGSize)calculateStringHeight:(NSString *)string font:(UIFont *)font constrainedSize:(CGSize)cSize;
//计算两点经纬度之间的距离
+ (double)calculateDistanceCoordinateFrom:(CLLocationCoordinate2D)coordinate1 to:(CLLocationCoordinate2D)coordinate2;

//数字转弧度
+(CGFloat)convertNumToArc:(double)num;

//校验手机号
+ (BOOL)validateMobile:(NSString *)mobileNum;

//判断固话
+ (BOOL)validatePhoneTel:(NSString *)phoneNum;

// 判断有效密码
+ (BOOL)validatePassword:(NSString *)pwd;

// 手机号部分隐藏
+ (NSString *)securePhoneNumber:(NSString *)pNum;

// 判断字符是否全为空格
+ (BOOL)isAllSpaceWithString:(NSString *)string;

// 反转数组
+ (void)reverseArray:(NSMutableArray *)targetArray;

//创建navigation title
+ (UIView *)navTitleView:(NSString *)_title;

//创建navigation 右按钮是字的
+ (UIBarButtonItem *)navRightBackBtn:(id)_target action:(SEL)selector imageStr:(NSString *)imageStr;

//创建navigation 右按钮是图片的
+ (UIBarButtonItem *)navButton:(id)_target action:(SEL)selector image:(UIImage *)image;

// 统一返回按钮
+ (UIBarButtonItem*)navLeftBackBtn:(id)_target action:(SEL)selector;

// toast 提示框
+ (void)showToastWithMessage:(NSString *)message inView:(UIView *)view;

// alert提示框
+ (void)showAlertWithMessage:(NSString *)message delegate:(id)delegate;

//风火轮加载
+ (void)showMBProgress:(UIView *)_targetView message:(NSString *)_msg;

//隐藏风火轮
+ (void)hideMBProgress:(UIView*)_targetView;

//图片的颜色和尺寸
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;

//获取当前版本号
+ (NSString *)getLocalAppVersion;

//图像保存路径
+ (NSString *)savedPath;

//是否登录
+ (BOOL)isUserLogin;

//将时间戳转换为时间
+ (NSString *)getTimeWithTimestamp:(NSString *)strTimestamp WithDateFormat:(NSString *)strDateFormat;

//将时间转换为时间戳
+ (NSString *)getTimeStampWithDate:(NSString *)strDate;

//日期显示规则        本日显示时间，昨日显示“昨日”，之前日期显示具体日期
+ (NSString *)showDateWithStringDate:(NSString *)strDate;

// 根据 解析的key 图片链接
+ (NSString *)imageDownloadUrl:(NSString *)url;

//千分位的格式
+ (NSString *)conversionThousandth:(NSString *)string;

//判断网络
+ (BOOL)isConnectionAvailable;

//画底部的线
+ (void)bottomLine:(UIView*)aView;

//画顶部的线
+ (void)topLine:(UIView*)aView;

//画线
+(UIImageView *)drawLine:(CGPoint)position width:(CGFloat)width;

+(UIImage * )getPlaceHolderImage:(CGSize)size string:(NSString *)imageName;
@end
