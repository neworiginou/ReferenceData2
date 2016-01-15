//
//  HWTianTianTuanListModel.m
//  Community
//
//  Created by niedi on 15/7/31.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWTianTianTuanListModel.h"

@implementation HWTianTianTuanListModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        self.modelId = [dict stringObjectForKey:@"id"];
        self.address = [dict stringObjectForKey:@"address"];
        self.brand = [dict stringObjectForKey:@"brand"];
        self.createTime = [dict stringObjectForKey:@"createTime"];
        self.expressName = [dict stringObjectForKey:@"expressName"];
        self.expressNumber = [dict stringObjectForKey:@"expressNumber"];
        self.goodsCount = [dict stringObjectForKey:@"goodsCount"];
        self.goodsId = [dict stringObjectForKey:@"goodsId"];
        self.goodsName = [dict stringObjectForKey:@"goodsName"];
        self.isExport = [dict stringObjectForKey:@"isExport"];
        self.mobile = [dict stringObjectForKey:@"mobile"];
        self.name = [dict stringObjectForKey:@"name"];
        self.orderAmount = [dict stringObjectForKey:@"orderAmount"];
        self.orderCode = [dict stringObjectForKey:@"orderCode"];
        self.orderImg = [dict stringObjectForKey:@"orderImg"];
        self.orderStatus = [dict stringObjectForKey:@"orderStatus"];
        self.payMoney = [dict stringObjectForKey:@"payMoney"];
        self.payOrderId = [dict stringObjectForKey:@"payOrderId"];
        self.payTime = [dict stringObjectForKey:@"payTime"];
        self.payType = [dict stringObjectForKey:@"payType"];
        self.postage = [dict stringObjectForKey:@"postage"];
        self.releaseWarehouseTime = [dict stringObjectForKey:@"releaseWarehouseTime"];
        self.remark = [dict stringObjectForKey:@"remark"];
        self.returnMoneyTime = [dict stringObjectForKey:@"returnMoneyTime"];
        self.returnAmount = [dict stringObjectForKey:@"returnAmount"];
        self.sellPrice = [dict stringObjectForKey:@"sellPrice"];
        self.sendGoodsTime = [dict stringObjectForKey:@"sendGoodsTime"];
        self.sendInfo = [dict stringObjectForKey:@"sendInfo"];
        self.userId = [dict stringObjectForKey:@"userId"];
    }
    return self;
}

@end


