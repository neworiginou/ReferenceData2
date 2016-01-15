//
//  ALBBCartService.h
//  ALBBTradeSDK
//
//  Created by 友和(lai.zhoul@alibaba-inc.com) on 15/3/4.
//  Copyright (c) 2015年 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ALBBTradeService.h"

@protocol ALBBCartService <ALBBTradeService>

/**
 *  打开购物车页面
 *
 *  @param parentController            <#parentController description#>
 *  @param isNeedPush                  <#isNeedPush description#>
 *  @param webViewUISettings           <#webViewUISettings description#>
 *  @param tradeProcessSuccessCallback <#tradeProcessSuccessCallback description#>
 *  @param tradeProcessFailedCallback  <#tradeProcessFailedCallback description#>
 */
-(void) showCart:(UIViewController*)parentController
      isNeedPush:(BOOL) isNeedPush
webViewUISettings:(TaeWebViewUISettings *)webViewUISettings
tradeProcessSuccessCallback:(tradeProcessSuccessCallback)tradeProcessSuccessCallback
tradeProcessFailedCallback:(tradeProcessFailedCallback)tradeProcessFailedCallback;


/**
 *  添加商品到购物车
 *
 *  @param parentController        app当前的Controller
 *  @param isNeedPush              是否需要使用parentController进行push
 *  @param webViewUISettings        可以自定义的webview配置项
 *  @param itemId                   商品混淆id
 *  @param addCartSuccessCallback   用户点击确定，添加到购物车成功的回调
 *  @param addCartCacelledCallback  用户点击返回，取消了添加的回调
 */
-(void) addItem2Cart:(UIViewController *) parentController
          isNeedPush:(BOOL) isNeedPush
   webViewUISettings:(TaeWebViewUISettings *)webViewUISettings
              itemId:(NSString *)itemId
addCartSuccessCallback:(addCartSuccessCallback)addCartSuccessCallback
addCartCacelledCallback:(addCartCacelledCallback)addCartCacelledCallback;



/**
 *  添加淘客商品到购物车
 *
 *  @param parentController        app当前的Controller
 *  @param isNeedPush              是否需要使用parentController进行push
 *  @param webViewUISettings       可以自定义的webview配置项
 *  @param itemId                  商品混淆id
 *  @param taoKeParams             淘客参数
 *  @param addCartSuccessCallback   用户点击确定，添加到购物车成功的回调
 *  @param addCartCacelledCallback  用户点击返回，取消了添加的回调
 */
-(void) addTaoKeItem2Cart:(UIViewController *) parentController
               isNeedPush:(BOOL) isNeedPush
        webViewUISettings:(TaeWebViewUISettings *)webViewUISettings
                   itemId:(NSString *)itemId
              taoKeParams:(TaeTaokeParams *) taoKeParams
   addCartSuccessCallback:(addCartSuccessCallback)addCartSuccessCallback
  addCartCacelledCallback:(addCartCacelledCallback)addCartCacelledCallback;




@end
