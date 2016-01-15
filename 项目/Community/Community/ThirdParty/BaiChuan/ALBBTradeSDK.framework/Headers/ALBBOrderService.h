//
//  ALBBOrderService.h
//  ALBBTradeSDK
//
//  Created by 友和(lai.zhoul@alibaba-inc.com) on 15/3/4.
//  Copyright (c) 2015年 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ALBBTradeService.h"

#import "TaeOrderItem.h"

@protocol ALBBOrderService <ALBBTradeService>

/**
 *  打开订单页面
 *
 *  @param parentController  app当前的Controller
 *  @param isNeedPush            是否需要使用parentController进行push
 *  @param webViewUISettings        可以自定义的webview配置项
 *  @param orderItems                      订单请求参数数组，参数类型见 TaeOrderItem
 *  @param tradeProcessSuccessCallback    交易流程成功完成订单支付的回调
 *  @param tradeProcessFailedCallback  交易流程未完成的回调
 */
-(void)showOrder:(UIViewController*)parentController
      isNeedPush:(BOOL) isNeedPush
webViewUISettings:(TaeWebViewUISettings *)webViewUISettings
      orderItems:(NSArray *)orderItems
tradeProcessSuccessCallback:(tradeProcessSuccessCallback)tradeProcessSuccessCallback
tradeProcessFailedCallback:(tradeProcessFailedCallback)tradeProcessFailedCallback;


/**
 *  以淘客方式打开订单页面
 *
 *  @param parentController  app当前的Controller
 *  @param isNeedPush            是否需要使用parentController进行push
 *  @param webViewUISettings        可以自定义的webview配置项
 *  @param orderItem                      订单请求参数，参数类型见 TaeOrderItem
 *  @param taoKeParams                        淘客参数
 *  @param tradeProcessSuccessCallback    交易流程成功完成订单支付的回调
 *  @param tradeProcessFailedCallback  交易流程未完成的回调
 */
-(void)showTaoKeOrder:(UIViewController*)parentController
           isNeedPush:(BOOL) isNeedPush
    webViewUISettings:(TaeWebViewUISettings *)webViewUISettings
            orderItem:(TaeOrderItem *)orderItem
          taoKeParams:(TaeTaokeParams *) taoKeParams
tradeProcessSuccessCallback:(tradeProcessSuccessCallback)tradeProcessSuccessCallback
tradeProcessFailedCallback:(tradeProcessFailedCallback)tradeProcessFailedCallback;


/**
 *  带sku选择页的商品下单接口
 *
 *  @param parentController            app当前的Controller
 *  @param isNeedPush                  是否需要使用parentController进行push
 *  @param webViewUISettings           可以自定义的webview配置项
 *  @param itemId                      商品混淆id
 *  @param params                      扩展参数
 *  @param tradeProcessSuccessCallback 交易流程成功完成订单支付的回调
 *  @param tradeProcessFailedCallback  交易流程未完成的回调
 */
-(void)showOrderWithSku:(UIViewController*)parentController
             isNeedPush:(BOOL) isNeedPush
      webViewUISettings:(TaeWebViewUISettings *)webViewUISettings
                 itemId:(NSString *)itemId
                 params:(NSDictionary *)params
tradeProcessSuccessCallback:(tradeProcessSuccessCallback)tradeProcessSuccessCallback
tradeProcessFailedCallback:(tradeProcessFailedCallback)tradeProcessFailedCallback;


/**
 *  带sku选择页的淘客商品下单接口
 *
 *  @param parentController            app当前的Controller
 *  @param isNeedPush                  是否需要使用parentController进行push
 *  @param webViewUISettings           可以自定义的webview配置项
 *  @param itemId                      商品混淆id
 *  @param params                      扩展参数
 *  @param taoKeParams                  淘客参数
 *  @param tradeProcessSuccessCallback 交易流程成功完成订单支付的回调
 *  @param tradeProcessFailedCallback  交易流程未完成的回调
 */
-(void)showTaoKeOrderWithSku:(UIViewController*)parentController
                  isNeedPush:(BOOL) isNeedPush
           webViewUISettings:(TaeWebViewUISettings *)webViewUISettings
                      itemId:(NSString *)itemId
                      params:(NSDictionary *)params
                 taoKeParams:(TaeTaokeParams *) taoKeParams
 tradeProcessSuccessCallback:(tradeProcessSuccessCallback)tradeProcessSuccessCallback
  tradeProcessFailedCallback:(tradeProcessFailedCallback)tradeProcessFailedCallback;



@end
