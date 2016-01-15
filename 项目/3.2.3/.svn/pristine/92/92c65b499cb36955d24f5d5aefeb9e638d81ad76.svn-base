//
//  HWScdHouAppointListModel.swift
//  Partner-Swift
//
//  Created by niedi on 15/3/11.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：二手房 预约人次model
//
//  修改记录：
//      姓名         日期               修改内容
//      聂迪      2015-02-26           数据模型实现
//

import UIKit

/*
{
"brokerName":"" -客源经纪人姓名
"brokerPhone":"" -客源经纪人电话（未解锁为空值）
"isLock":"" -是否加锁(yes no)
"appointmentContent":"" -预约内容（时间+内容）
"createTime":"" -预约产生时间
"integral":"" -房源方应扣积分
"pendingState":"" -代办状态 (pending:未处理;pended:已处理)
},
{ "id": null, "brokerId": null, "villageName": null, "doorNum": null, "secHouseId": null, "operationType": null, "pendingState": null, "appointmentTime": null, "brokerName": "15851067818", "brokerPhone": "15851067818", "message": null, "appointmentContent": "2015年02月09日 17:24 hello", "createTime": null, "isLock": "no", "integral": 10 }
*/

class HWScdHouAppointListModel: NSObject
{
    //MARK: 成员变量
    var modelId: String! = ""
    var brokerId: String! = ""
    var brokerName: String! = ""
    var brokerPhone: String! = ""
    var isLock: String! = ""
    var appointmentContent: String! = ""
    var createTime: String! = ""
    var integral: String! = ""
    var pendingState: String! = ""
    
    func initWitDict(dict: NSDictionary)
    {
        modelId = dict.stringObjectForKey("id")
        brokerId = dict.stringObjectForKey("brokerId")
        brokerName = dict.stringObjectForKey("brokerName")
        brokerPhone = dict.stringObjectForKey("brokerPhone")
        isLock = dict.stringObjectForKey("isLock")
        appointmentContent = dict.stringObjectForKey("appointmentContent")
        createTime = dict.stringObjectForKey("createTime")
        integral = dict.stringObjectForKey("integral")
        pendingState = dict.stringObjectForKey("pendingState")
    }
    
}






