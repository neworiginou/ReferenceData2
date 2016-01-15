//
//  TaeOrderItem.h
//  taesdk
//
//  Created by 友和(lai.zhoul@alibaba-inc.com) on 14-8-13.
//  Copyright (c) 2014年 com.taobao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaeOrderItem : NSObject


@property(nonatomic, strong) NSString *itemId;
@property(nonatomic, strong) NSString *skuId;
@property(nonatomic, strong) NSNumber *quantity;
@end
