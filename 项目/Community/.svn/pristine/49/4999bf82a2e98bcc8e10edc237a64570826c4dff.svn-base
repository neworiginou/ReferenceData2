//
//  TaeSDK.h
//  taesdk
//
//  Created by 友和(lai.zhoul@alibaba-inc.com) on 14-8-2.
//  Copyright (c) 2014年 com.taobao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "TaeWebViewUISettings.h"

#import "TaeTest.h"
#import "TaeTopClient.h"

static NSString * _TAE_SDK_VERSION = @"1.6.0";//当前TaeSDK的版本号


@class TaeWebViewUISettings;

#pragma -mark SDK 回调定义
/**
 *  初始化结果回调
 */
typedef void (^initSuccessCallback)();
typedef void (^initFailedCallback)(NSError *error);




@interface TaeSDK : NSObject

#pragma -mark SDK 基础API
/**
 *
 *  @return 返回单例
 */
+ (instancetype) sharedInstance ;

/**
 *  TaeSDK初始化，异步执行
 */
-(void)asyncInit;

/**
 *  TaeSDK初始化，异步执行
 *
 *  @param sucessCallback 初始化成功回调
 *  @param failedCallback 初始化失败回调
 */
-(void)asyncInit:(initSuccessCallback) sucessCallback
  failedCallback:(initFailedCallback) failedCallback;



/**
 *  用于处理其他App的回跳
 *
 *  @param url
 *
 *  @return 是否经过了TaeSDK的处理
 */
-(BOOL)handleOpenURL:(NSURL *) url;






#pragma -mark SDK 环境定义

typedef enum{
    TaeSDKEnvironmentDaily,  //测试环境
    TaeSDKEnvironmentPreRelease,//预发环境
    TaeSDKEnvironmentRelease,//线上环境
    TaeSDKEnvironmentSandBox//沙箱环境
    
} TaeSDKEnvironment;


TaeSDKEnvironment TaeSDKCurrentEnvironment();//当前环境
/**
 *  设置SDK 环境信息，Tae内部测试使用
 *
 *  @param environmentType 见TaeSDKEnvironment
 */
-(void)setTaeSDKEnvironment:(TaeSDKEnvironment) environmentType;


#pragma -mark SDK 回调Code定义

typedef enum{
    TAE_INIT_FAILED=1000,//SDK初始化失败
    TAE_INIT_SERVER_CER_LOAD_FAILED=1002,//初始化下载服务端证书失败
    TAE_INIT_SERVER_CER_EVAL_FAIELD=1003,//服务端证书验证失败
    TAE_INIT_LOCAL_CER_EVAL_FAIELD=1004,//本地证书验证失败
    TAE_INIT_REFRESH_SESSION_FAIELD=1005,//刷新当前会话失败
    TAE_LOGIN_FAILED=2001,//登录失败
    TAE_LOGIN_CANCELLED=2002,//用户取消了登录
    TAE_TRADE_PROCESS_FAILED=3001 ,//交易链路失败
    TAE_TRADE_PROCESS_CANCELLED=3002, //交易链路中用户取消了操作
    TAE_TRADE_PROCESS_PAY_FAILED =3003,//交易链路中发生支付但是支付失败
    TAE_TRADE_PROCESS_ITEMID_INVALID=3004//itemId无效
    
} TaeSDKCode;


#pragma -mark SDK 业务开关

/**
 *  打开debug日志
 *
 *  @param isDebugLogOpen
 */
-(void) setDebugLogOpen:(BOOL) isDebugLogOpen;

/**
 *  是否开启阿里云推送功能,默认不开启
 *
 *  @param isCloudPushSDKOpen
 */
-(void) setCloudPushSDKOpen:(BOOL) isCloudPushSDKOpen;

/**
 *  关闭TAE的user-agent
 */
-(void) closeTaeUserAgent;


/**
 *  关闭TAE设置的crashHandler
 */
-(void) closeCrashHandler;

-(NSString *) getAppKey;
/**
 *  如果引入了高德地图SDK，TAE会返回对应的高德key
 *
 *  @return <#return value description#>
 */
-(NSString *) getGaoDeAPIKey;

/**
 *  如果引入了UmengSDK，TAE会返回对应的友盟的appkey
 *
 *  @return <#return value description#>
 */
-(NSString *) getUMengAPIKey;


#pragma -mark 插件相关API

/**
 *  获取TAESDK以及所有插件SDK暴露的service 实例
 *
 *  @param protocol service的协议
 *
 *  @return service实例
 */
-(id) getService:(Protocol *) protocol;


#pragma -mark 自定义API

/**
 *  指定当前APP的版本，以便关联相关日志和crash分析信息,//如果不设置默认会取plist里的Bundle version
 *
 *  @param version
 */
-(void) setAppVersion:(NSString *)version;

-(void) setWebViewUISettings: (TaeWebViewUISettings *)webViewUISettings;
-(TaeWebViewUISettings *) getWebViewUISettings;

/**
 *  指定身份图片的后缀
 *
 *  @param postFix <#postFix description#>
 */
-(void) setSecGuardImagePostfix:(NSString *) postFix;


/**
 * 设置SDK发布渠道,包含渠道类型和渠道名
 * 如：
 */
-(void) setChanne:(NSString *) type name:(NSString *) name;


-(TaeSDKEnvironment) getTaeSDKCurrentEnvironment;
@end
