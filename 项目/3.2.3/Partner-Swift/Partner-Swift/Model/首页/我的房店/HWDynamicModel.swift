//
//  HWDynamicModel.swift
//  Partner-Swift
//
//  Created by hw500027 on 15/3/3.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：我的房店-状态列表model
//
//  修改记录：
//      姓名         日期              修改内容
//    陆晓波      2015-03-03           文件创建

import UIKit

class HWDynamicModel: NSObject
{
    let id : NSString?
    let villageName :NSString?
    let doorNum : NSString?
    let secHouseId : NSString?
    let operationType : NSString?
    let pendingState : NSString?
    let appointmentTime : NSString?
    let brokerName : NSString?
    let brokerPhone : NSString?
    let message : NSString?
    let createTime : NSString?
    let integral : NSString?
    let isLock : NSString?
    let isRead : NSString?
    
    init(dict:NSDictionary)
    {
        self.id = dict.stringObjectForKey("id")
        self.villageName = dict.stringObjectForKey("villageName")
        self.doorNum = dict.stringObjectForKey("doorNum")
        self.secHouseId = dict.stringObjectForKey("secHouseId")
        self.operationType = dict.stringObjectForKey("operationType")
        self.pendingState = dict.stringObjectForKey("pendingState")
        self.appointmentTime = dict.stringObjectForKey("appointmentTime")
        self.brokerName = dict.stringObjectForKey("brokerName")
        self.brokerPhone = dict.stringObjectForKey("brokerPhone")
        self.message = dict.stringObjectForKey("message")
        self.createTime = dict.stringObjectForKey("createTime")
        self.integral = dict.stringObjectForKey("integral")
        self.isLock = dict.stringObjectForKey("isLock")
        self.isRead = dict.stringObjectForKey("isRead")
    }
}
/*
"id":"" -动态id
"villageName":"" -小区名称
"doorNum":"" -门牌
"secHouseId":"" -二手房id
"operationType":"" -动态类型 (edit:房源信息编辑;appoint:预约看房;putdown:房源下架)
"pendingState":"" -代办状态 (pending:未处理;pended:已处理)
"appointmentTime":"" -预约时间（yyyy-MM-dd hh:mm:ss）
"brokerName":"" -客源经纪人姓名
"brokerPhone":"" -客源经纪人电话
"message":"" -留言
"createTime":"" -动态产生时间（yyyy-MM-dd hh:mm:ss）
"integral":"" -房源方应扣积分
"isLock":"" -是否加锁(yes no)
*/