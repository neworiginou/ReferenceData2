//
//  HWServiceListModel.h
//  Community
//
//  Created by hw500027 on 15/6/18.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWServiceListModel : NSObject
@property (nonatomic , strong) NSString *orderId;
@property (nonatomic , strong) NSString *serviceName;
@property (nonatomic , strong) NSString *serviceIcon;
@property (nonatomic , strong) NSString *status;
@property (nonatomic , strong) NSString *serviceTime;
@property (nonatomic , strong) NSString *serviceTimeSection;
@property (nonatomic , strong) NSString *payTime;
- (id)initWithDic:(NSDictionary *)dic;
@end
/*
 orderId 服务单id
 serviceName 服务名称
 serviceIcon 服务icon
 status 状态 (0未处理、1已拒单、2等待接单、3已接单、4等待支付、 5处理完毕、6已取消）
 serviceTime 服务时间 （状态 != 5 显示）
 serviceTimeSection 服务时间段//(0全天,1,上午,2下午,3晚上)
 payTime 支付时间 （状态 == 5 显示）
 */