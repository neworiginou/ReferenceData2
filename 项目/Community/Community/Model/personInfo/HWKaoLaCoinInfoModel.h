//
//  HWKaoLaCoinInfoModel.h
//  Community
//
//  Created by gusheng on 14-12-12.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWKaoLaCoinInfoModel : NSObject
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
 bussinessType = 4 ——推广佣金
 */
@property(nonatomic,strong)NSString *accountFlowId;
@property(nonatomic,strong)NSString *flowMoney;
@property(nonatomic,strong)NSString *bussinessType;
@property(nonatomic,strong)NSString *paymentTime;
@property(nonatomic,strong)NSString *orderStatus;
@property(nonatomic,strong)NSString *orderUser;
@property(nonatomic,strong)NSString *orderUserName;
@property(nonatomic,strong)NSString *tradeProject;
@property(nonatomic,strong)NSString *tradeAccountName;
@property(nonatomic,strong)NSString *flowDirection;
@property(nonatomic,strong)NSString *balance;
@property(nonatomic,strong)NSString *redPackageNum;

-(id)initWithDic:(NSDictionary *)dic;
@end
