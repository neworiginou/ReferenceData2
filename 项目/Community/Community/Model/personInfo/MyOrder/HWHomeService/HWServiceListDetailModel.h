//
//  HWServiceListDetailModel.h
//  Community
//
//  Created by hw500027 on 15/6/23.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWServiceListDetailModel : NSObject
@property (nonatomic , strong) NSString *orderId;       // 服务单id
@property (nonatomic , strong) NSString *founder;       // 发起人
@property (nonatomic , strong) NSString *receiver;      // 接单人
@property (nonatomic , strong) NSString *serviceName;   // 服务名称
@property (nonatomic , strong) NSString *serviceIcon;   // 服务icon
@property (nonatomic , strong) NSString *status;        //状态 (0未处理、1已拒单、2等待接单、3已接单、4等待支付 5处理完毕、已取消）
@property (nonatomic , strong) NSString *serviceTime;   //服务时间 （状态 != 5 显示）
@property (nonatomic , strong) NSString *serviceTimeSection;// 服务时间段//(0全天,1,上午,2下午,3晚上)
@property (nonatomic , strong) NSString *payTime;       // 支付时间 （状态 == 5 显示）
@property (nonatomic , strong) NSString *charge;        // 费用
@property (nonatomic , strong) NSString *token;         // 百川支付token
@property (nonatomic , strong) NSString *bcOrderId;     // 百川订单ID
@property (nonatomic , strong) NSString *serviceAddress; // 服务地址
@property (nonatomic , strong) NSString *mobileNumber;
@property (nonatomic , strong) NSString *payNum;

@property (nonatomic , strong) NSDictionary *ownerVo;       // 业主信息（name 业主姓名、phone 手机号、address 地址）
@property (nonatomic , strong) NSDictionary *servePersonVo; // 服务人员信息（name 服务人员姓名、phone 手机号、icon 服务人员头像）
@property (nonatomic , strong) NSArray *statusList;    // 订单状态列表（operation 状态信息、status 状态：0未处理、1已拒单、2等待接单、3已接单、4等待支付 5处理完毕、已取消）

- (id)initWithDic:(NSDictionary *)dic;




@end
