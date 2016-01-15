//
//  WYYCOrder.h
//  无忧云车司机
//
//  Created by luosai19910103@163.com on 15/6/23.
//  Copyright (c) 2015年 wuyouyunche. All rights reserved.
//

typedef enum
{
    orderCancelStatus =0,
    orderWaitingAcceptStatus,
    orderAlreadyAcceptedStatus,
    orderArriveStartPlaceStatus,
    orderStartDrivingStatus,
    orderDuringDrivingStatus,
    orderHalfwayWaitingStatus,
    orderContinuedDrivingStatus,
    orderFinishedNotPayStatus,
    orderFinishedPayStatus,
    orderFinishedCommentStatus
}WYYCOrderStatus;

#import <Foundation/Foundation.h>

@interface WYYCOrder : NSObject
/**
 *  订单号
 */
@property (nonatomic,strong) NSString *orderId;

@property (nonatomic,copy) NSString *title;
/**
 *  出发地
 */
@property (nonatomic,copy) NSString *startPlace;
/**
 *  目的地
 */
@property (nonatomic,copy) NSString *destination;
/**
 *  出发时间
 */
@property (nonatomic,copy) NSString *startTime;
/**
 *  客户id
 */
@property (nonatomic ,copy)NSString *customerId;
/**
 *  客户姓名
 */
@property (nonatomic,copy) NSString *customerName;

/**
 *  联系方式
 */
@property (nonatomic,copy) NSString *linkPhoneNumber;
/**
 *  订单状态
 1、待接单
 2、已接单
 3、已到达（现场）
 4、开始代驾
 5、代驾中
 6、中途等待（可重复）
 7、继续代驾（可重复）
 8、已结束（未付款）
 9、已完成（报单，加发票抬头、备注两项）
 0、已取消
 */
@property (nonatomic,assign) WYYCOrderStatus orderStatusCode;
/**
 *  估计费用
 */
@property (nonatomic,strong) NSNumber *estimatedCost;
/**
 *  实际费用
 */
@property (nonatomic,strong) NSNumber *cost;
/**
 *  支付方式
 */
@property (nonatomic,strong) NSNumber *payWay;
/**
 *  当前行驶距离
 */
@property (nonatomic,strong) NSNumber *currentDistance;
/**
 *  当前等待时长
 */
@property (nonatomic,strong) NSNumber *costTimeIntervel;
/**
 *  订单消费所在城市
 */
@property (nonatomic ,copy) NSString *orderCity;
/**
 *  纬度
 */
@property (nonatomic,strong) NSNumber *latitude;
/**
 *  经度
 */
@property (nonatomic,strong) NSNumber *longitude;

@end
