//
//  HWMyBargainOrderModel.h
//  Community
//
//  Created by D on 14/12/14.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWMyBargainOrderModel : NSObject
@property (nonatomic, strong) NSString *sendStatus; //订单状态
@property (nonatomic, strong) NSString *orderStatus;//支付状态
@property (nonatomic, strong) NSString *bigImg;   //图
@property (nonatomic, strong) NSString *smallImg;
@property (nonatomic, strong) NSString *productName;//商品名称
@property (nonatomic, strong) NSString *marketPrice;//市场价
@property (nonatomic, strong) NSString *orderAmount;//订单数量
@property (nonatomic, strong) NSString *winPrice;//实付价格
@property (nonatomic, strong) NSString *payMoney;//实际支付钱数
@property (nonatomic, strong) NSDictionary*addressDto;//判断是否有默认地址
@property (nonatomic, strong) NSString *orderNum;//订单号


//add by gusheng
/*
 cutAddressId 地址id
 cutUserId 砍价用户id
 orderId 砍价订单id
 address 邮寄地址
 userName 收件人
 phone 电话号码
 */
@property(nonatomic,strong)NSString *cutAddressIdStr;
@property(nonatomic,strong)NSString *cutUserIdStr;
@property(nonatomic,strong)NSString *orderIdStr;
@property(nonatomic,strong)NSString *addressStr;
@property(nonatomic,strong)NSString *userNameStr;
@property(nonatomic,strong)NSString *phoneStr;
//end



- (id)initWithBargainOrderDic:(NSDictionary *)dict;
@end
