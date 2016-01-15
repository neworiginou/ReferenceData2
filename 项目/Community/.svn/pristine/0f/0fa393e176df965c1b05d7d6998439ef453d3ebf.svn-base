//
//  HWCoinDetailModel.m
//  Community
//
//  Created by gusheng on 14-12-12.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWCoinDetailModel.h"

@implementation HWCoinDetailModel
@synthesize tradeType;
@synthesize orderNum;
@synthesize orderStatus;
@synthesize money;
@synthesize user;
@synthesize project;
@synthesize tradeObject;
@synthesize tradeTime;
@synthesize isDisabled;
/*
 参数名	描述
 status	接口返回状态：1，成功；0失败
 data	接口返回数据
 detail	接口返回提示信息
 key	用户 key
 data数据说明：
 accountFlowId	流水号
 flowMoney	金额
 bussinessType	交易类型
 paymentTime	交易时间
 orderStatus	订单状态：1、等待付款；2、已付款；3、已取消；4、手动确认支付
 orderUser	下单用户ID
 orderUserName	下单用户昵称
 tradeProject	支付项目
 tradeAccountName	交易对象
 disabled	是否禁用
 */
-(id)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        self.tradeType = [dic stringObjectForKey:@"bussinessType"];
        self.orderNum = [dic stringObjectForKey:@"accountFlowId"];
        self.orderStatus =[dic stringObjectForKey:@"orderStatus"];
        self.money = [dic stringObjectForKey:@"flowMoney"];
        self.user = [dic stringObjectForKey:@"orderUserName"];
        self.project = [dic stringObjectForKey:@"tradeProject"];
        self.tradeObject = [dic stringObjectForKey:@"tradeAccountName"];
        self.tradeTime = [dic stringObjectForKey:@"paymentTime"];
        self.isDisabled = [dic stringObjectForKey:@"disabled"];
    }
    return self;
}
@end
