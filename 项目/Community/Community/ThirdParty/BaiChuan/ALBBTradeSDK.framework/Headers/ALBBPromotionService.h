//
//  ALBBPromotionService.h
//  ALBBTradeSDK
//
//  Created by 友和(lai.zhoul@alibaba-inc.com) on 15/3/4.
//  Copyright (c) 2015年 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ALBBTradeService.h"

@protocol ALBBPromotionService<ALBBTradeService>


/**
 *  打开优惠卷页面
 *  其中param和type都为必填选项，
 *  type：shop时，param传递为sellerNick；
 *  type：auction时，param传递为商品的混淆id；
 *
 *  @param parentController            <#parentController description#>
 *  @param isNeedPush                  <#isNeedPush description#>
 *  @param webViewUISettings           <#webViewUISettings description#>
 *  @param param                       <#param description#>
 *  @param type                        <#type description#>
 *  @param tradeProcessSuccessCallback <#tradeProcessSuccessCallback description#>
 *  @param tradeProcessFailedCallback  <#tradeProcessFailedCallback description#>
 */
-(void)showPromotions:(UIViewController*)parentController
           isNeedPush:(BOOL) isNeedPush
    webViewUISettings:(TaeWebViewUISettings *)webViewUISettings
                param:(NSString *)param
                 type:(NSString *)type
tradeProcessSuccessCallback:(tradeProcessSuccessCallback)tradeProcessSuccessCallback
tradeProcessFailedCallback:(tradeProcessFailedCallback)tradeProcessFailedCallback;


/**
 *  打开电子凭证页面
 *
 *  @param parentController            <#parentController description#>
 *  @param isNeedPush                  <#isNeedPush description#>
 *  @param webViewUISettings           <#webViewUISettings description#>
 *  @param orderId                     订单Id
 *  @param tradeProcessSuccessCallback <#tradeProcessSuccessCallback description#>
 *  @param tradeProcessFailedCallback  <#tradeProcessFailedCallback description#>
 */
-(void)showETicketDetail :(UIViewController*)parentController
               isNeedPush:(BOOL) isNeedPush
        webViewUISettings:(TaeWebViewUISettings *)webViewUISettings
                  orderId:(NSString *)orderId
tradeProcessSuccessCallback:(tradeProcessSuccessCallback)tradeProcessSuccessCallback
tradeProcessFailedCallback:(tradeProcessFailedCallback)tradeProcessFailedCallback;

@end
