//
//  ALBBTradeService.h
//  ALBBTradeSDK
//  电商接口基础service
//  Created by 友和(lai.zhoul@alibaba-inc.com) on 15/3/4.
//  Copyright (c) 2015年 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TaeTradeProcessResult.h"
#import "TaeTaokeParams.h"


@protocol ALBBTradeService <NSObject>

/**
 * 交易流程结果回调
 */
typedef void (^tradeProcessSuccessCallback)(TaeTradeProcessResult *tradeProcessResult);
typedef void (^tradeProcessFailedCallback)(NSError *error);


/**
 *  加入商品到购物车的结果回调
 */
typedef void (^addCartSuccessCallback)();
typedef void (^addCartCacelledCallback)();


@end
