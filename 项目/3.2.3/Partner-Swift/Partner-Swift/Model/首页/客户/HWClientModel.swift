//
//  HWClientModel.swift
//  Partner-Swift
//
//  Created by caijingpeng.haowu on 15/2/15.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：客户信息 数据模型
//
//  修改记录：
//      姓名         日期               修改内容
//     蔡景鹏     2015-02-15           创建文件
//

import UIKit

class HWClientModel: NSObject
{
    /*  二手房 关联客户
    "clientInfoId":"",            - 经纪人客户ID
    "clientName":"",                - 客户姓名
    "clientPhone":"",               - 客户电话
    
    "clientSourceWay":"",           - 客户来源  //  客户录入  房源预约
    
    "clientIntention":"",           - 客户意向
    "houseName":"",                 - 房源名称
    
    "houseState":"",                - 房源状态
    
    "houseType":"",                 - 房源类型（new 新房,secondHouse 二手房）
    "lastChangeTime":"",            - 最后状态发生变化的时间(yyyy-MM-dd HH:mm:ss)
    "visitedProtectDaysRemind":"",  - 到访保护期剩余天数(默认为-1，为-1不提醒,等于0为过到访保护期，大于0为剩余保护期天数)
    "isUp":""                       - 是否置顶(0不置顶，1置顶)
    */
    
    var clientInfoId: NSString = ""
    var clientName: NSString = ""
    var clientPhone: NSString = ""
    var clientSourceWay: NSString = ""
    var clientIntention: NSString = ""
    var houseName: NSString = ""
    var cStatus: NSString = ""
    var houseState: NSString = ""
    var houseType: NSString = ""
    var lastChangeTime: NSString = ""
    var visitedProtectDaysRemind: NSString!
    var isUp: NSString = ""
    
    var isAppointHouseFlag: NSString = ""
    var seletedStr: NSString = "0"
    var selectedFlag:Bool = false;
    override init()
    {
        super.init()
    }
    
    init(clientInfo: NSDictionary)
    {
        super.init()
        self.clientInfoId = clientInfo.stringObjectForKey("clientInfoId")
        self.clientName = clientInfo.stringObjectForKey("clientName")
        self.clientPhone = clientInfo.stringObjectForKey("clientPhone")
        self.clientSourceWay = clientInfo.stringObjectForKey("clientSourceWay")
        self.clientIntention = clientInfo.stringObjectForKey("clientIntention")
        self.houseName = clientInfo.stringObjectForKey("houseName")
        self.cStatus = clientInfo.stringObjectForKey("cstatus");
        self.houseState = clientInfo.stringObjectForKey("houseState")
        self.houseType = clientInfo.stringObjectForKey("houseType")
        var str =  clientInfo.stringObjectForKey("lastChangeTime")
        self.lastChangeTime = Utility .getTimeFormattWithTimeStamp(str)
        self.visitedProtectDaysRemind = clientInfo.stringObjectForKey("visitedProtectDaysRemind")
        self.isUp = clientInfo.stringObjectForKey("isUp")
    }
    
}
