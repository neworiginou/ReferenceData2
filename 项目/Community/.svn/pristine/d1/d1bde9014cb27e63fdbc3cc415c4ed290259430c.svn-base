//
//  ALBBLoginSDKPluginServiceProtocol.h
//  ALBBLoginSDKPluginAdapter
//
//  Created by 友和(lai.zhoul@alibaba-inc.com) on 14/11/26.
//  Copyright (c) 2014年 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "TaeSession.h"
#import "TaeUser.h"
@protocol ALBBLoginService




/**
 *  登录授权结果回调
 */
typedef void (^loginSuccessCallback)(TaeSession *session);
typedef void (^loginFailedCallback)(NSError *error);

/**
 *  会话登入和登出的监听Handler
 *
 *  @param session 返回状态更新后的会话
 */
typedef void (^sessionStateChangedHandler)(TaeSession *session);



/**
 *
 *  @param handler 会话登录状态改变时候的处理handler,可以通过TaeSession isLogin判断当前登录态
 */
-(void) setSessionStateChangedHandler:(sessionStateChangedHandler) handler;

/**
 *  退出登录
 */
-(void) logout;


/**
 *  请求登录授权，跳转到手机淘宝登录或者本地弹出登录界面
 *
 *  @param parentController app当前的Controller
 *  @param successCallback      登录授权成功的回调，返回TaeSession
 *  @param failedCallback       登录授权失败的回调，返回NSError
 */
-(void) showLogin:(UIViewController *) parentController
  successCallback:(loginSuccessCallback) successCallback
   failedCallback:(loginFailedCallback) failedCallback;

/**
 *  请求登录授权，跳转到手机淘宝登录或者本地弹出登录界面
 *
 *  @param parentController app当前的Controller
 *  @param successCallback      登录授权成功的回调，返回TaeSession
 *  @param failedCallback       登录授权失败的回调，返回NSError
 *  @param notUseTaobaoAppLogin       YES表示不要使用手机淘宝APP的登录授权，直接使用本地登录页面
 */
-(void) showLogin:(UIViewController *) parentController
  successCallback:(loginSuccessCallback) successCallback
   failedCallback:(loginFailedCallback) failedCallback
notUseTaobaoAppLogin:(BOOL)notUseTaobaoAppLogin;


-(void) showLogin:(UIViewController *) parentController
  successCallback:(loginSuccessCallback) successCallback
   failedCallback:(loginFailedCallback) failedCallback
notUseTaobaoAppLogin:(BOOL)notUseTaobaoAppLogin
isBackButtonHidden:(BOOL)isBackButtonHidden;

-(void) showLoginOnRootView:(UIWindow *) window
            successCallback:(loginSuccessCallback) successCallback
             failedCallback:(loginFailedCallback) failedCallback
       notUseTaobaoAppLogin:(BOOL)notUseTaobaoAppLogin
         isBackButtonHidden:(BOOL)isBackButtonHidden;



@end
