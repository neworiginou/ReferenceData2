//
//  HWDynamicDetailModel.swift
//  Partner-Swift
//
//  Created by hw500027 on 15/3/5.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：我的房店-状态-详情model
//
//  修改记录：
//      姓名         日期              修改内容
//    陆晓波      2015-03-05           文件创建

import UIKit

class HWDynamicDetailModel: NSObject
{
    let villageName : NSString?
    let appointmentTime : NSString?
    let message : NSString?
    let brokerName : NSString?
    let brokerPhone : NSString?
    let integral : NSString?
    let isLock : NSString?
    let id : NSString?
    
    init(dict:NSDictionary)
    {
        self.villageName = dict.stringObjectForKey("villageName")
        self.appointmentTime = dict.stringObjectForKey("appointmentTime")
        self.message = dict.stringObjectForKey("message")
        self.brokerName = dict.stringObjectForKey("brokerName")
        self.brokerPhone = dict.stringObjectForKey("brokerPhone")
        self.integral = dict.stringObjectForKey("integral")
        self.isLock = dict.stringObjectForKey("isLock")
        self.id = dict.stringObjectForKey("id")
        
    }
}
