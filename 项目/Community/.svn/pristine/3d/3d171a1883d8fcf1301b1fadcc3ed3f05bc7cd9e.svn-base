//
//  HWKaoLaCoinInfoModel.m
//  Community
//
//  Created by gusheng on 14-12-12.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWKaoLaCoinInfoModel.h"

@implementation HWKaoLaCoinInfoModel
/*
 
 data数据说明：
 accountFlowId	流水号
 flowMoney	金额
 bussinessType	交易类型：1、考拉币充值；2、无底线消费；3、流标返还
 paymentTime	交易时间
 orderStatus	订单状态：1、等待付款；2、已付款；3、已取消；4、手动确认支付
 orderUser	下单用户ID
 orderUserName	下单用户昵称
 tradeProject	支付项目
 tradeAccountName	交易对象
 flowDirection 钱包金额流向 ：1、流入；2、流出
 balance 余额
 redPackageNum红包个数
 */

-(id)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        self.accountFlowId = [dic stringObjectForKey:@"accountFlowId"];
        self.flowMoney = [dic stringObjectForKey:@"flowMoney"];
        self.bussinessType = [dic stringObjectForKey:@"bussinessType"];
        self.paymentTime = [dic stringObjectForKey:@"paymentTime"];
        self.orderStatus = [dic stringObjectForKey:@"orderStatus"];
        self.orderUserName = [dic stringObjectForKey:@"orderUserName"];
        self.tradeProject = [dic stringObjectForKey:@"tradeProject"];
        self.tradeAccountName = [dic stringObjectForKey:@"tradeAccountName"];
        self.flowDirection = [dic stringObjectForKey:@"flowDirection"];
        self.balance = [dic stringObjectForKey:@"balance"];
        self.redPackageNum = [dic stringObjectForKey:@"redPackageNum"];
    }
    return self;
}
@end
