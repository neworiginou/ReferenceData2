//
//  HWShopAdminModel.swift
//  Partner-Swift
//
//  Created by hw500028 on 15/3/2.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit
/*
brokerId:"",-经纪人id
brokerName："",-经纪人姓名
brokerPhone:"",-经纪人电话
role:"",-经纪人角色[0普通员工，1店长]
},
*/
class HWBrokerModel: NSObject {
    var brokerName = ""
    var phone = ""
    var role = ""
    var brokerId = ""
    var hwSection = 0
    init(dict:NSDictionary,hwSection:Int){
        self.brokerName = dict.stringObjectForKey("brokerName")
        self.phone = dict.stringObjectForKey("phone")
        self.brokerId = dict.stringObjectForKey("brokerId")
        self.role = dict.stringObjectForKey("role")
        self.hwSection = hwSection
    }
    
    
}
