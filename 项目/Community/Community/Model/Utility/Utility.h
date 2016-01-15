//
//  Utility.h
//  Community
//
//  Created by caijingpeng.haowu on 14-8-27.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//
//  工具函数类
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef enum{
    
    LogicLine_GetMoney = 1, // 点击提现-->提示绑定-->提示设置提现密码-->设置提现密码-->绑定银行卡-->提现
    LogicLine_BindCard = 2,  // 点击绑定银行卡-->提示验证提现密码-->验证-->绑定银行卡
    LoginLine_UnBindCard = 3,  // 解绑银行卡
    LoginLine_SettingPassward = 4//设置提现密码
    
}LogicLine;

@interface Utility : NSObject

// ----------- 功能 ---------------

// 计算字符串字数 区分 中英文字符
+ (int)calculateTextLength:(NSString *)text;

// 计算两点坐标之间的距离
+ (int)calculateDistanceCoordinateFrom:(CLLocationCoordinate2D)coordinate1 to:(CLLocationCoordinate2D)coordinate2;

// 校验手机号
+ (BOOL)validateMobile:(NSString *)mobileNum;

// 校验手机号前三位
+ (BOOL)validateMobileWithFirstThree:(NSString *)mobileNum;

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

+ (BOOL)isChineseWord:(NSString *)text;

+ (BOOL)isCardNo:(NSString *)bankCardNumber;

+ (NSString *)getUUID;

+ (NSString *)getUUIDWithoutSymbol;

+ (NSString *)imageDownloadUrl:(NSString *)subStr;

+ (NSString *)imageDownloadWithUrl:(NSString *)url;

// ------------- 样式 -----------------
+ (UIBarButtonItem *)navShareButton:(id)_target action:(SEL)selector;//分享
// 创建navigation title view
+ (UIView *)navTitleView:(NSString *)_title;

// 统一返回按钮
+ (UIBarButtonItem*)navLeftBackBtn:(id)_target action:(SEL)selector;

// segment
+ (UIView *)navTitleViewSegmentCtrlWithItems:(NSArray *)items target:(id)target selector:(SEL)selector;

// 提现
+ (UIBarButtonItem *)navWalletButton:(id)_target action:(SEL)selector;

// 单纯文字导航
+ (UIBarButtonItem *)navButton:(id)_target title:(NSString*)title action:(SEL)selector;

// 显示角标数字
+ (UIBarButtonItem *)navButton:(id)_target title:(NSString*)title action:(SEL)selector count:(int)count;

// 发布按钮
+ (UIBarButtonItem *)navPublishButton:(id)_target action:(SEL)selector;

// 图片类型navButton
+ (UIBarButtonItem *)navButton:(id)_target image:(NSString *)imgName action:(SEL)selector;

//加载动画
+ (void)showLoadingAnimationInView:(UIView *)view;

//删除动画
+ (void)hideLoadingAnimationInView:(UIView *)view;

// toast 提示框

+ (void)showToastWithMessage:(NSString *)message inView:(UIView *)view;

+ (void)showToastWithMessage:(NSString *)message inView:(UIView *)view yoffest:(CGFloat)offest;

+ (void)showToastMBProgress:(UIView *)_targetView message:(NSString *)_msg imageName:(NSString *)_imgName;

+ (void)show3SecondToastWithMessage:(NSString *)message inView:(UIView *)view;

// alert提示框
+ (void)showAlertWithMessage:(NSString *)message;

+ (void)showMBProgress:(UIView *)_targetView message:(NSString *)_msg;

+ (void)hideMBProgress:(UIView*)_targetView;

//图像保存路径
+ (NSString *)savedPath;
//根据Xib生成
id loadObjectFromNib(NSString *nib, Class cls, id owner);

+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;

//获取当前版本号
+ (NSString *)getLocalAppVersion;

//获取当前位置的城市ID
+(NSString*)getCityId:(NSString *)cityName;

+ (NSString *)getCityNameById:(NSString *)cityId;

//获取当前位置的区域Id
+(NSString *)getCityAreaId:(NSString *)areaName city:(NSString *)cityName;
//
+ (UIView *)navTitleView:(NSString *)_title action:(SEL)selector target:(id)_target;

+ (void)showAlertWithMessageAndSureCancelBtn:(NSString *)messagecancelStr delegate:(id)delegate;
//是否登录
+ (BOOL)isUserLogin;
//是否游客登录
+ (BOOL)isGuestLogin;
//判断是否是微信登录（且未绑定手机号）
+ (BOOL)isWeiXinUser;

//将时间戳转换为时间
+ (NSString *)getDateWithTimestamp:(NSString *)strTimestamp;
+ (NSString *)getDetailTimeWithTimestamp:(NSString *)strTimestamp;
+ (NSString *)getMinTimeWithTimestamp:(NSString *)strTimestamp;
+ (NSString *)getTimeWithTimestamp:(NSString *)strTimestamp WithDateFormat:(NSString *)strDateFormat;

+ (NSString *)getTimeWithTimestamp:(NSString *)strTimestamp;
+ (NSString *)getTimeWithTimestampChinese:(NSString *)strTimestamp;
+ (NSString *)getMonthTimeWithTimestamp:(NSString *)strTimestamp;
+ (NSString *)getHourTimeWithTimestamp:(NSString *)strTimestamp;
+ (NSString *)getTimeStampToStrRule:(NSString *)strTimestamp;
+ (NSString *)DateToMDMSAndToday:(NSString *)DateStr;
+ (NSString *)getRandomString;
+ (NSString *)calculateRemainedTimeWithTimeInterval:(long long)interval;

+ (void)playShake;
+ (void)playAudioEffect;


//根据picMongoDbKey拼接图片URL
+ (NSString *)imageDownloadWithMongoDbKey:(NSString *)strKey;

+ (BOOL)stringContainsEmoji:(NSString *)string;

//获得屏幕图像
+ (UIImage *)imageFromView:(UIView *)theView;

//获得某个范围内的屏幕图像
+ (UIImage *)imageFromView:(UIView *)theView atFrame:(CGRect)r;

+ (NSString *)getMacAddress;
+ (NSString *)getIDFA;
//动态计算label高度
+ (CGSize)calculateStringHeight:(NSString *)string font:(UIFont *)font constrainedSize:(CGSize)cSize;
//动态计算label宽度
+ (CGSize)calculateStringWidth:(NSString *)string font:(UIFont *)font constrainedSize:(CGSize)cSize;

+ (NSString *)parseProductStatus:(NSString *)status;
+ (UIColor *)parseProductStatusTextColor:(NSString *)status;

+ (NSString *)formatTimeDisplay:(int)timestamp;
+ (NSString *)format2TimeDisplay:(int)timestamp;
/**
 *  随机颜色
 */
+ (UIColor *)randColor;
/**
 *  纯色带字背景
 */
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size withString:(NSString *)string;
+ (NSString *)parseGenderByValue:(NSString *)value;
+ (NSString *)parseGenderByString:(NSString *)string;

+ (UIView *)drawLineWithFrame:(CGRect)rect;

//计算千分位
+ (NSString *)conversionThousandth:(NSString *)string;
//navRight筛选按钮
+ (UIBarButtonItem *)navrightDownBtn:(id)_target withTitle:(NSString *)title sel:(SEL)selector;

//判断网络
+ (BOOL)isConnectionAvailable;

+ (void)bottomLine:(UIView*)aView;
+ (void)topLine:(UIView*)aView;

//画横线
+(UIImageView *)drawLine:(CGPoint)position width:(CGFloat)width;

//画竖直线
+(UIImageView *)drawVerticalLine:(CGPoint)position height:(CGFloat)height;

//指定字符串中 改变指定字符字体及颜色
+(NSMutableAttributedString *)setFullStr:(NSString *)fullStr fullStrWithFont:(UIFont *)fullStrFont fullStrWithColor:(UIColor *)fullStrColor needChangeStrArray:(NSArray *)changeStrArray changeStrWithFont:(UIFont *)changeStrFont changeStrColor:(UIColor *)changeStrColor;

+ (NSString *)getTimeStampForUnix;
+ (NSString *)encryptParameter:(NSMutableDictionary *)parDict;
+ (NSString *)convertStr:(NSString *)str;

//取消本地通知
+ (void)removeAlertItemWithProductId:(NSString *)productId;


//1.5.4添加
//是否同时存在微信和QQ
+ (BOOL)isInstalledQQAndInstalledWX;
+ (BOOL)isNullQQAndWX;
+ (BOOL)isInstalledQQ;
+ (BOOL)isInstalledWX;


+ (NSData *)convertImgTo256K:(UIImage *)img;

@end
