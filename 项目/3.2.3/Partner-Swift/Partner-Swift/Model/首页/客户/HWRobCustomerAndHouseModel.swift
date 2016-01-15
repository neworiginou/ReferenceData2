//
//  HWRobCustomerAndHouseModel.swift
//  Partner-Swift
//
//  Created by hw500029 on 15/4/14.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import Foundation

class HWRobCustomerModel: NSObject {
    var clientPoolId:NSString! = ""
    var intentionArea:NSString!  = ""      //意向区域
    var intentionHouseSize:NSString! = ""  //面积
    var intentionHousePrice:NSString! = "" //价格
    var intentionHouseType:NSString! = ""  //户型
    var clientRobRecordId:NSString! = ""  //抢房记录id
    var version:NSString! = ""            //版本号
    var clientName:NSString!  = ""        //抢客客户名
    
    var infoText:NSString! = ""
    
    var orderType:NSString! = ""//租售中心/其他 租售中心客户解锁成功后跳转聊天h5 其他客户解锁成功后跳转抢购成功页面
    
    init(dic:NSDictionary)
    {
        super.init()
        clientPoolId = dic.stringObjectForKey("clientPoolId")
        intentionArea = dic.stringObjectForKey("intentionArea")
        intentionHouseSize = dic.stringObjectForKey("intentionHouseSize")
        intentionHousePrice = dic.stringObjectForKey("intentionHousePrice")
        intentionHouseType = dic.stringObjectForKey("intentionHouseType")
        clientRobRecordId = dic.stringObjectForKey("clientRobRecordId")
        version = dic.stringObjectForKey("version")
        clientName = dic.stringObjectForKey("clientName")
        
        //不显示
        if intentionArea == ""
        {
            intentionArea = "不限"
        }
        
        if intentionHouseType == "0"
        {
            self.intentionHouseType = " | 不限"
        }
        else if intentionHouseType == "1"
        {
            self.intentionHouseType = " | 一室"
        }
        else if intentionHouseType == "2"
        {
            self.intentionHouseType = " | 二室"
        }
        else if intentionHouseType == "3"
        {
            self.intentionHouseType = " | 三室"
        }
        else if intentionHouseType == "4"
        {
            self.intentionHouseType = " | 四室"
        }
        else if intentionHouseType == "5"
        {
            self.intentionHouseType = " | 五室以上"
        }
        else if intentionHouseType == ""
        {
            self.intentionHouseType = " | 不限"
        }
        else
        {
            self.intentionHouseType = " | \(intentionHouseType!)"
        }
        
        
        if intentionHousePrice == ""
        {
            intentionHousePrice = " | 0-不限"
        }
        else if intentionHousePrice == "0-2000"
        {
            intentionHousePrice = " | 0-不限"
        }
        else
        {
            intentionHousePrice = " | \(intentionHousePrice!)万元"
        }
        
        
        if intentionHouseSize == ""
        {
            intentionHouseSize = " | 0-不限"
        }
        else if intentionHouseSize == "0-600"
        {
            intentionHouseSize = " | 0-不限"
        }
        else if intentionHouseSize == "0"
        {
            intentionHouseSize = " | 0-不限"
        }
        else
        {
            intentionHouseSize = " | \(intentionHouseSize!)㎡"
        }
        
        infoText = "意向：\(intentionArea)\(intentionHouseType)\(intentionHousePrice)\(intentionHouseSize)"
        
        orderType = dic.stringObjectForKey("orderType")
    }
    
//    func fetchData(dic:NSDictionary)
//    {
//        clientPoolId = dic.stringObjectForKey("clientPoolId")
//        intentionArea = dic.stringObjectForKey("intentionArea")
//        intentionHouseSize = dic.stringObjectForKey("intentionHouseSize")
//        intentionHousePrice = dic.stringObjectForKey("intentionHousePrice")
//        intentionHouseType = dic.stringObjectForKey("intentionHouseType")
//        clientRobRecordId = dic.stringObjectForKey("clientRobRecordId")
//        version = dic.stringObjectForKey("version")
//        clientName = dic.stringObjectForKey("clientName")
//    }

}

class HWRobHouseModel: NSObject {
    var housePoolId:NSString! = ""
    var villageName:NSString! = ""        //小区名
    var scdhandHousesSize:NSString! = ""  //面积
    var scdhandHousesPrice:NSString! = "" //价格
    var scdhandHousesType:NSString! = ""  //户型
    var housesRobRecordId:NSString! = ""  //抢房记录id
    var version:NSString! = ""         //版本号
    
    var infoText:NSString! = ""
    
    init(dic:NSDictionary)
    {
        super.init()
        housePoolId = dic.stringObjectForKey("housePoolId")
        villageName = dic.stringObjectForKey("villageName")
        scdhandHousesSize = dic.stringObjectForKey("scdhandHousesSize")
        scdhandHousesPrice = dic.stringObjectForKey("scdhandHousesPrice")
        scdhandHousesType = dic.stringObjectForKey("scdhandHousesType")
        housesRobRecordId = dic.stringObjectForKey("housesRobRecordId")
        version = dic.stringObjectForKey("version")
        
        if scdhandHousesType == "0"
        {
            self.scdhandHousesType = " 不限"
        }
        else if scdhandHousesType == "1"
        {
            self.scdhandHousesType = " 一室"
        }
        else if scdhandHousesType == "2"
        {
            self.scdhandHousesType = " 二室"
        }
        else if scdhandHousesType == "3"
        {
            self.scdhandHousesType = " 三室"
        }
        else if scdhandHousesType == "4"
        {
            self.scdhandHousesType = " 四室"
        }
        else if scdhandHousesType == "5"
        {
            self.scdhandHousesType = " 五室以上"
        }
        else if scdhandHousesType == ""
        {
            self.scdhandHousesType = " 不限"
        }
        else
        {
            self.scdhandHousesType = " \(scdhandHousesType!)"
        }
        
        
        if scdhandHousesPrice == ""
        {
            scdhandHousesPrice = " | 0-不限"
        }
        else if scdhandHousesPrice == "0-2000"
        {
            scdhandHousesPrice = " | 0-不限"
        }
       

        else
        {
            var subStr = "\(scdhandHousesPrice.doubleValue / 10000)"
            self.scdhandHousesPrice = " | \(subStr)万元"
        }
        
        
        if scdhandHousesSize == ""
        {
            scdhandHousesSize = " | 0-不限"
        }
        else if scdhandHousesSize == "0-600"
        {
            scdhandHousesSize = " | 0-不限"
        }
        else if scdhandHousesSize == "0"
        {
            scdhandHousesSize = " | 0-不限"
        }
        else
        {
            scdhandHousesSize = " | \(scdhandHousesSize!)㎡"
        }

        
        infoText = "房源参数：\(scdhandHousesType)\(scdhandHousesPrice)\(scdhandHousesSize)"
    }
    
//    func fetchData(dic:NSDictionary)
//    {
//        housePoolId = dic.stringObjectForKey("housePoolId")
//        villageName = dic.stringObjectForKey("villageName")
//        scdhandHousesSize = dic.stringObjectForKey("scdhandHousesSize")
//        scdhandHousesPrice = dic.stringObjectForKey("scdhandHousesPrice")
//        scdhandHousesType = dic.stringObjectForKey("scdhandHousesType")
//        housesRobRecordId = dic.stringObjectForKey("housesRobRecordId")
//        version = dic.stringObjectForKey("version")
//    }
}

class HWRobOneCustomerInfoModel:NSObject {
    var clientPoolId:NSString! = ""
    var integral:NSString! = ""        //花费积分
    var countdown:NSString! = ""       //倒计时时间
    var isLimit:NSString! = ""         //是否抢客上限
    var clientRobRecordId:NSString! = ""

    init(dic:NSDictionary)
    {
        super.init()
        clientPoolId = dic.stringObjectForKey("clientPoolId")
        integral = dic.stringObjectForKey("integral")
        countdown = dic.stringObjectForKey("countdown")
        isLimit = dic.stringObjectForKey("isLimit")
        clientRobRecordId = dic.stringObjectForKey("clientRobRecordId")
    }
}

class HWRobOneHouseInfoModel:NSObject {
    var housePoolId:NSString! = ""
    var integral:NSString! = ""        //花费积分
    var countdown:NSString! = ""       //倒计时时间
    var isLimit:NSString! = ""         //是否抢客上限
    var housesRobRecordId:NSString! = ""
    
    init(dic:NSDictionary)
    {
        super.init()
        housePoolId = dic.stringObjectForKey("housePoolId")
        integral = dic.stringObjectForKey("integral")
        countdown = dic.stringObjectForKey("countdown")
        isLimit = dic.stringObjectForKey("isLimit")
        housesRobRecordId = dic.stringObjectForKey("houseRobRecordId")
        println("model.housesRobRecordId ============ \(housesRobRecordId)")
    }
}
















