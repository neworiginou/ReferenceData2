//
//  ALBBOpenTradePluginServiceProtocol.h
//  ALBBOpenTradePluginAdapter
//
//  Created by 友和(lai.zhoul@alibaba-inc.com) on 14/11/26.
//  Copyright (c) 2014年 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ALBBOpenTradeService <NSObject>

typedef void (^ALBBOpenCreateOrderCalback)(NSNumber *orderId,NSError *error);
typedef void (^ALBBOpenTradeProcessCallback)(NSDictionary *resultDic,NSError *error);

/**
 *  创建OpenTrade订单
 *
 *  @param isvOrderId <#isvOrderId description#>
 *  @param itemId     <#itemId description#>
 *  @param itemTitle  <#itemTitle description#>
 *  @param amount     <#amount description#>
 *  @param data       <#data description#>
 *  @param callback   <#callback description#>
 */
-(void)createOrder:(NSString *)isvOrderId
            itemId:(NSNumber *)itemId
            itemTitle:(NSString *)itemTitle
            amount:(NSNumber *)amount
             data:(NSDictionary *)data
    callback:(ALBBOpenCreateOrderCalback) callback;


/**
 *  显示OpenTrade订单支付
 *
 *  @param parentController <#parentController description#>
 *  @param orderId          <#orderId description#>
 *  @param isvOrderId       <#isvOrderId description#>
 *  @param outPayId         <#outPayId description#>
 *  @param amount           <#amount description#>
 *  @param timeout          <#timeout description#>
 *  @param callback         <#callback description#>
 */
-(void)showPayOrder:(UIViewController*)parentController
            orderId:(NSNumber *)orderId
         isvOrderId:(NSString *)isvOrderId
           outPayId:(NSString *)outPayId
            amount:(NSNumber *)amount
            timeout:(NSString *)timeout
    callback:(ALBBOpenTradeProcessCallback) callback;



@end
