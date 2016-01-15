//
//  ALBBItemService.h
//  ALBBTradeSDK
//  电商接口 商品详情service
//  Created by 友和(lai.zhoul@alibaba-inc.com) on 15/3/4.
//  Copyright (c) 2015年 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ALBBTradeService.h"
@protocol ALBBItemService <ALBBTradeService>

/**
 *  使用TaeSDK的webview打开H5页面，可以自动实现淘宝安全免登
 *
 *  @param parentController  app当前的Controller
 *  @param isNeedPush            是否需要使用parentController进行push
 *  @param pageUrl                  页面的url
 *  @param webViewUISettings        可以自定义的webview配置项
 */
-(void) showPage:(UIViewController *) parentController
      isNeedPush:(BOOL) isNeedPush
         openUrl:(NSString *)openUrl;

/**
 *  使用TaeSDK的webview打开H5页面，可以自动实现淘宝安全免登
 *
 *  @param parentController  app当前的Controller
 *  @param isNeedPush            是否需要使用parentController进行push
 *  @param pageUrl                  页面的url
 *  @param webViewUISettings        可以自定义的webview配置项
 *  @param tradeProcessSuccessCallback    交易流程成功完成订单支付的回调
 *  @param tradeProcessFailedCallback  交易流程未完成的回调
 */
-(void) showPage:(UIViewController *) parentController
      isNeedPush:(BOOL) isNeedPush
         pageUrl:(NSString *)pageUrl
webViewUISettings:(TaeWebViewUISettings *)webViewUISettings
tradeProcessSuccessCallback:(tradeProcessSuccessCallback)tradeProcessSuccessCallback
tradeProcessFailedCallback:(tradeProcessFailedCallback)tradeProcessFailedCallback;


/**
 *  通过商品真实itemId打开商品详情页面
 *
 *  @param parentController  app当前的Controller
 *  @param isNeedPush            是否需要使用parentController进行push
 *  @param pageUrl                  页面的url
 *  @param webViewUISettings        可以自定义的webview配置项
 *  @param itemId                   商品真实Id(itemId)
 *  @param tradeProcessSuccessCallback    交易流程成功完成订单支付的回调
 *  @param tradeProcessFailedCallback  交易流程未完成的回调
 */
- (void)showItemDetailByItemId:(UIViewController *)parentController
                    isNeedPush:(BOOL)isNeedPush
             webViewUISettings:(TaeWebViewUISettings *)webViewUISettings
                        itemId:(NSNumber *)itemId
                      itemType:(NSInteger)itemType
                        params:(NSDictionary *)params
   tradeProcessSuccessCallback:(tradeProcessSuccessCallback)tradeProcessSuccessCallback tradeProcessFailedCallback:(tradeProcessFailedCallback)tradeProcessFailedCallback;

/**
 *  通过商品混淆itemId打开商品详情页面
 *
 *  @param parentController  app当前的Controller
 *  @param isNeedPush            是否需要使用parentController进行push
 *  @param webViewUISettings        可以自定义的webview配置项
 *  @param itemId                      商品混淆Id(OpenId)
 *  @param itemType                      商品类型:1代表淘宝，2代表天猫
 *  @param params                        商品详情页请求附加参数
 *  @param tradeProcessSuccessCallback    交易流程成功完成订单支付的回调
 *  @param tradeProcessFailedCallback  交易流程未完成的回调
 */
- (void)showItemDetailByOpenId:(UIViewController *)parentController
                    isNeedPush:(BOOL)isNeedPush
             webViewUISettings:(TaeWebViewUISettings *)webViewUISettings
                    itemId:(NSString *)itemId
                      itemType:(NSInteger)itemType
                        params:(NSDictionary *)params
   tradeProcessSuccessCallback:(tradeProcessSuccessCallback)tradeProcessSuccessCallback tradeProcessFailedCallback:(tradeProcessFailedCallback)tradeProcessFailedCallback;

/**
 * 此方法不建议使用，请使用 showItemDetailByOpenId
 * 打开商品详情页面
 *
 *  @param parentController  app当前的Controller
 *  @param isNeedPush            是否需要使用parentController进行push
 *  @param webViewUISettings        可以自定义的webview配置项
 *  @param itemId                      商品混淆id
 *  @param itemType                      商品类型:1代表淘宝，2代表天猫
 *  @param params                        商品详情页请求附加参数
 *  @param tradeProcessSuccessCallback    交易流程成功完成订单支付的回调
 *  @param tradeProcessFailedCallback  交易流程未完成的回调
 */
-(void)showItemDetail:(UIViewController*)parentController
           isNeedPush:(BOOL) isNeedPush
    webViewUISettings:(TaeWebViewUISettings *)webViewUISettings
               itemId:(NSString *)itemId
             itemType:(NSInteger) itemType
               params:(NSDictionary *)params
tradeProcessSuccessCallback:(tradeProcessSuccessCallback)tradeProcessSuccessCallback
tradeProcessFailedCallback:(tradeProcessFailedCallback)tradeProcessFailedCallback;


/**
 *  通过ItemId以淘客方式打开商品详情页面
 *
 *  @param parentController  app当前的Controller
 *  @param isNeedPush            是否需要使用parentController进行push
 *  @param webViewUISettings        可以自定义的webview配置项
 *  @param itemId                      商品真实Id(itemId)
 *  @param itemType                      商品类型:1代表淘宝，2代表天猫
 *  @param params                        商品详情页请求附加参数
 *  @param taoKeParams                        淘客参数
 *  @param tradeProcessSuccessCallback    交易流程成功完成订单支付的回调
 *  @param tradeProcessFailedCallback  交易流程未完成的回调
 */
- (void)showTaoKeItemDetailByItemId:(UIViewController *)parentController
                         isNeedPush:(BOOL)isNeedPush
                  webViewUISettings:(TaeWebViewUISettings *)webViewUISettings
                             itemId:(NSNumber *)itemId
                           itemType:(NSInteger)itemType
                             params:(NSDictionary *)params
                        taoKeParams:(TaeTaokeParams *)taoKeParams
        tradeProcessSuccessCallback:(tradeProcessSuccessCallback)tradeProcessSuccessCallback tradeProcessFailedCallback:(tradeProcessFailedCallback)tradeProcessFailedCallback;
/**
 *  通过OpenId以淘客方式打开商品详情页面
 *
 *  @param parentController  app当前的Controller
 *  @param isNeedPush            是否需要使用parentController进行push
 *  @param webViewUISettings        可以自定义的webview配置项
 *  @param itemId                      商品混淆Id(openId)
 *  @param itemType                      商品类型:1代表淘宝，2代表天猫
 *  @param params                        商品详情页请求附加参数
 *  @param taoKeParams                        淘客参数
 *  @param tradeProcessSuccessCallback    交易流程成功完成订单支付的回调
 *  @param tradeProcessFailedCallback  交易流程未完成的回调
 */

- (void)showTaoKeItemDetailByOpenId:(UIViewController *)parentController
                         isNeedPush:(BOOL)isNeedPush
                  webViewUISettings:(TaeWebViewUISettings *)webViewUISettings
                             itemId:(NSString *)itemId
                           itemType:(NSInteger)itemType
                             params:(NSDictionary *)params
                        taoKeParams:(TaeTaokeParams *)taoKeParams
        tradeProcessSuccessCallback:(tradeProcessSuccessCallback)tradeProcessSuccessCallback tradeProcessFailedCallback:(tradeProcessFailedCallback)tradeProcessFailedCallback;
/**
 *  此方法不建议使用，请使用 showItemDetailByOpenId
 *  以淘客方式打开商品详情页面
 *
 *  @param parentController  app当前的Controller
 *  @param isNeedPush            是否需要使用parentController进行push
 *  @param webViewUISettings        可以自定义的webview配置项
 *  @param itemId                      商品混淆id
 *  @param itemType                      商品类型:1代表淘宝，2代表天猫
 *  @param params                        商品详情页请求附加参数
 *  @param taoKeParams                        淘客参数
 *  @param tradeProcessSuccessCallback    交易流程成功完成订单支付的回调
 *  @param tradeProcessFailedCallback  交易流程未完成的回调
 */
-(void)showTaoKeItemDetail:(UIViewController*)parentController
                isNeedPush:(BOOL) isNeedPush
         webViewUISettings:(TaeWebViewUISettings *)webViewUISettings
                    itemId:(NSString *)itemId
                  itemType:(NSInteger) itemType
                    params:(NSDictionary *)params
               taoKeParams:(TaeTaokeParams *) taoKeParams
tradeProcessSuccessCallback:(tradeProcessSuccessCallback)tradeProcessSuccessCallback
tradeProcessFailedCallback:(tradeProcessFailedCallback)tradeProcessFailedCallback;







@end
