//
//  TaeTradeProcessResult.h
//  taesdk
//
//  Created by 友和(lai.zhoul@alibaba-inc.com) on 14-8-13.
//  Copyright (c) 2014年 com.taobao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaeTradeProcessResult : NSObject

@property(nonatomic, strong) NSArray *paySuccessOrders;
@property(nonatomic, strong) NSArray *payFailedOrders;

@end
