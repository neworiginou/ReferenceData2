//
//  HWGoodsListModel.h
//  Community
//
//  Created by lizhongqiang on 15/4/13.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWGoodsListModel : NSObject

@property (nonatomic, strong) NSString *productName;        //商品名称
@property (nonatomic, strong) NSString *productId;          //商品id
@property (nonatomic, strong) NSString *bigImg;             //图片key
@property (nonatomic, strong) NSString *marketPrice;        //市场价
@property (nonatomic, strong) NSString *status;             //状态
@property (nonatomic, strong) NSString *remainMs;           //开始倒计时


- (id)initWithDict:(NSDictionary *)info;

@end
