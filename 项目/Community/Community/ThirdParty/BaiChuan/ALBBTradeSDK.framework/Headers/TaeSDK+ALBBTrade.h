//
//  TaeSDK+ALBBTrade.h
//  ALBBTradeSDK
//
//  Created by 友和(lai.zhoul@alibaba-inc.com) on 15/2/28.
//  Copyright (c) 2015年 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "ALBBItemService.h"
#import "ALBBOrderService.h"
#import "ALBBCartService.h"
#import "ALBBPromotionService.h"

#import "TaeH5PageServiceProtocol.h"



@interface TaeSDK(ALBBTrade)<ALBBItemService,ALBBOrderService,ALBBPromotionService,ALBBCartService,TaeH5PageServiceProtocol>





@end
