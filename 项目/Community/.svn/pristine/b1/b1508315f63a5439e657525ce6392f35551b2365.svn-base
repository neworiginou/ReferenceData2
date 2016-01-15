//
//  HWServiceEvaluateVC.h
//  Community
//
//  Created by niedi on 15/6/24.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseViewController.h"

typedef NS_ENUM(NSInteger, pushEvaluateType) {
    pushEvaluateTypeList = 0,           //从列表直接点评价进人 pop时回到列表
    pushEvaluateTypeDetail,             //从详情直接点评价进人 pop时回到详情
    pushEvaluateTypeWYPayEvlaute,       //从物业或首页或更多提交订单，到详情页支付后评价，pop时到详情
    pushEvaluateTypeWYPayCheckEvlaute,  //从物业或首页或更多提交订单，并支付后评价，返回详情后查看评价，pop时到详情
    pushEvaluateTypeListPayEvlaute,     //从订单列表支付后评价，pop时到列表
    pushEvaluateTypeDetailPayEvlaute,   //从订单详情支付后评价，pop时到详情
};


@interface HWServiceEvaluateVC : HWBaseViewController

@property (nonatomic, strong) NSString *currentOrderId;
@property (nonatomic, assign) BOOL hasComment;

@property (nonatomic, assign) pushEvaluateType pushType;

@end







