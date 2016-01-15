//
//  HWScdHouMakeAppointModel.swift
//  Partner-Swift
//
//  Created by niedi on 15/3/10.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：二手房 预约看房 预约历史model
//
//  修改记录：
//      姓名         日期               修改内容
//      聂迪      2015-02-26           数据模型实现
//

import UIKit

/*
{
"message":"" -留言；
"appointmentTime":"" -预约时间；
"clientName":"" -客户姓名；
"clientPhone":"" -客户电话
"appointmentState":"" -预约状态：confirm_w:等待对方确认;confirmed:对方同意;rejected:对方拒绝
},
*/

class HWScdHouMakeAppointModel: NSObject
{
    //MARK: 成员变量
    var message: String! = ""
    var appointmentTime: String! = ""
    var clientName: String! = ""
    var clientPhone: String! = ""
    var appointmentState: String! = ""
    
    func initWithDict(dict: NSDictionary)
    {
        message = dict.stringObjectForKey("message")
        appointmentTime = dict.stringObjectForKey("appointmentTime")
        clientName = dict.stringObjectForKey("clientName")
        clientPhone = dict.stringObjectForKey("clientPhone")
        appointmentState = dict.stringObjectForKey("appointmentState")
        
    }
    
    
}
