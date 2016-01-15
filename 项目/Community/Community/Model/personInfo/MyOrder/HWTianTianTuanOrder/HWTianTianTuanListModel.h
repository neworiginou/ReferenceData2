//
//  HWTianTianTuanListModel.h
//  Community
//
//  Created by niedi on 15/7/31.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWTianTianTuanListModel : NSObject

@property (nonatomic, strong) NSString *modelId;        //订单id
@property (nonatomic, strong) NSString *orderCode;
@property (nonatomic, strong) NSString *payOrderId;
@property (nonatomic, strong) NSString *goodsId;        //商品id
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *sendInfo;
@property (nonatomic, strong) NSString *orderStatus;    //订单状态 (订单状态 0未支付，1已支付未发货，2订单已退款，3已发货，4订单已关闭)
@property (nonatomic, strong) NSString *remark;
@property (nonatomic, strong) NSString *releaseWarehouseTime;
@property (nonatomic, strong) NSString *orderAmount;    //订单金额
@property (nonatomic, strong) NSString *goodsCount;
@property (nonatomic, strong) NSString *payType;
@property (nonatomic, strong) NSString *payMoney;       //支付金额
@property (nonatomic, strong) NSString *payTime;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *isExport;
@property (nonatomic, strong) NSString *expressName;
@property (nonatomic, strong) NSString *expressNumber;
@property (nonatomic, strong) NSString *sendGoodsTime;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *returnMoneyTime;
@property (nonatomic, strong) NSString *returnAmount;
@property (nonatomic, strong) NSString *brand;
@property (nonatomic, strong) NSString *sellPrice;
@property (nonatomic, strong) NSString *goodsName;
@property (nonatomic, strong) NSString *postage;
@property (nonatomic, strong) NSString *orderImg;
@property (nonatomic, strong) NSString *userId;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end

//{ "id": 5,订单id "orderCode": null, "payOrderId": null, "goodsId": null,商品id "address": null, "sendInfo": null, "orderStatus": 0,订单状态 (订单状态0未支付，1已支付未发货，2订单已退款，3已发货，4订单已关闭) "remark": null, "orderAmount": 100.0000,订单金额 "goodsCount": 2, "payType": null, "payMoney": null,支付金额 "payTime": null, "mobile": null, "name": null, "isExport": null, "expressName": null, "expressNumber": null, "sendGoodsTime": null, "createTime": null, "returnMoneyTime": null, "brand": null, "sellPrice": 50.0000, "goodsName": "红苹果", "postage": null, "orderImg": "xxx3", "userId": 1030431030435 }


