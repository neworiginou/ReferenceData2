//
//  HWScoreHouseModel.swift
//  Partner-Swift
//
//  Created by WeiYuanlin on 15/3/3.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：我的业绩-房产model
// 
//  魏远林    2015-03-03    创建文件
//

import UIKit

class HWScoreHouseModel: NSObject
{
    var name:String?//楼盘名称
    var houseType:String?
    var clientName:String?//客户姓名
    var payValue:String?//佣金数
    var dateTime:String?//结佣时间[yyyy-MM-dd HH:mm:ss]
    var status:String?//结佣状态[中文]
    
    init(dic:NSDictionary)
    {
        super.init()
        
        name = dic.stringObjectForKey("name")
        houseType = dic.stringObjectForKey("houseType")
        clientName = dic.stringObjectForKey("clientName")
        payValue = dic.stringObjectForKey("payValue")
        dateTime = dic.stringObjectForKey("dateTime")
        status = dic.stringObjectForKey("status")
    }
}
