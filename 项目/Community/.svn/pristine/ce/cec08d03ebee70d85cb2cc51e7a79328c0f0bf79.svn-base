//
//  HWCommondityDetailModel.h
//  Community
//
//  Created by ryder on 7/31/15.
//  Copyright (c) 2015 caijingpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWCommondityDetailModel : NSObject

@property (nonatomic, strong) NSString *bigImg;
@property (nonatomic, strong) NSString *brand;
@property (nonatomic, strong) NSString *brandUrl;
@property (nonatomic, strong) NSString *buyGoodsCount;
@property (nonatomic, strong) NSString *costPrice;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *creater;
@property (nonatomic, strong) NSString *currentTime;
@property (nonatomic, strong) NSString *disabled;
@property (nonatomic, strong) NSString *endTime;
@property (nonatomic, strong) NSString *freePostageAmount;
@property (nonatomic, strong) NSString *freePostageNum;
@property (nonatomic, strong) NSString *freePostageType;
@property (nonatomic, strong) NSString *goodsId;
@property (nonatomic, strong) NSString *goodsInfo;
@property (nonatomic, strong) NSString *goodsName;
@property (nonatomic, strong) NSString *goodsRemark;
@property (nonatomic, strong) NSString *isAuthBuy;
@property (nonatomic, strong) NSString *limitCount;
@property (nonatomic, strong) NSString *marketPrice;
@property (nonatomic, strong) NSString *modifier;
@property (nonatomic, strong) NSString *modifyTime;
@property (nonatomic, strong) NSString *orderImg;
@property (nonatomic, strong) NSString *postage;
@property (nonatomic, strong) NSString *reduceStockType;
@property (nonatomic, strong) NSString *sellPrice;
@property (nonatomic, strong) NSString *showDistanceEndTime;
@property (nonatomic, strong) NSString *showDistanceStartTime;
@property (nonatomic, strong) NSString *showSurplus;
@property (nonatomic, strong) NSString *smallImg;
@property (nonatomic, strong) NSString *startTime;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *stock;
@property (nonatomic, strong) NSString *surplusStock;
@property (nonatomic, strong) NSString *version;

- (instancetype)initWithdictionary:(NSDictionary *)dictionary;

@end

/*
 url：http://172.16.10.110:8080/hw-sq-app-web/grpBuyGoods/getGrpBuyGoodDetail.do
 输入参数说明：
 key：考拉社区登录成功用户被授权的key(必填)
 goodsId：被查看的商品id(必填)
 
 输出结果：
 
 {
 status: "1",
 data:
 { goodsId: 10349274824, goodsName: "红苹果", startTime: 1437840000000, endTime: 1438240641000, marketPrice: 20.44, sellPrice: 50, costPrice: null, postage: 5, freePostageType: 0, freePostageNum: 3, freePostageAmount: 20, bigImg: null, smallImg: "xxx1", orderImg: null, showDistanceEndTime: 1, showDistanceStartTime: 1, stock: null, surplusStock: null, reduceStockType: null, brand: "西部商贸有限公司", brandUrl: "www.baidu.com", showSurplus: null, limitCount: 10, goodsRemark: "xxx5", goodsInfo: "xxx4", buyGoodsCount: 1, currentTime: 1438254270534, isAuthBuy: null, status: "3", creater: null, createTime: null, modifier: null, modifyTime: null, version: null, disabled: null, surplusStock:30 }
 
 ,
 detail: "请求数据成功!",
 key: "3e801f50-10d8-44d7-9ce7-83e57fe582f1"
 }
 
 输出参数说明：
 
 goodsId：商品id
 goodsName：商品名称
 goodsRemark：商品描述
 goodsInfo：商品简介
 orderBigImg：app显示的商品列表页大图(1440x1939)
 bigImg：app显示的商品列表页详情图片(640x400)
 smallImg：app显示的商品页列表图片( 640x860)
 orderImg：app显示商品订单页图片(124x124)
 marketPrice：市场参考价
 sellPrice：出售价格
 showDistanceEndTime：是否显示剩余倒计时(0:否 1：是)
 showDistanceStartTime：是否显示开始倒计时(0:否 1：是)
 startTime：开始上架时间
 endTime：下架时间
 currentTime：当前后台服务器系统时间
 isAuthBuy：是否认证购买 (0:否 1：是)
 buyGoodsCount：已经售出数量
 limitCount：限购数量
 postage：邮费
 freePostageType：免邮类型
 freePostageNum：免邮份数
 freePostageAmount：免邮金额
 brand：品牌商
 brandUrl：品牌商连接
 status：当前商品状态(0即将开始,1进行中,2已售完，3已下架，4未知状态)
 showSurplus：是否显示剩余 (0:否 1：是)
 surplusStock:剩余库存*/

