//
//  HWRelateHouseModel.swift
//  Partner-Swift
//
//  Created by caijingpeng.haowu on 15/2/15.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：关联房源 数据模型
//
//  修改记录：
//      姓名         日期               修改内容
//     蔡景鹏     2015-02-15           创建文件
//

import UIKit

class HWRelateHouseModel: NSObject {
    /*
    "houseId":33,     --房源ID
    "houseTitle"      --标题
    "houseName":"",   --房源名称
    "houseAddress":"[宝山-共康]", --房源地址[区域-板块]
    "brokerNum":13,              --合作经纪人数
    "clientNum":12,    --意向客户数
    "houseAvgPrice":"27000元/㎡",   --均价
    "commission":"最高38000元／套",    --佣金
    "houseType":"newHouse"      --房源类型（secondhouse,newHouse）
    "houseTotalPrice":"300万" -总价
    "houseFamilyType":"3室2厅" -户型
    "houseArea":"92㎡"       -面积
    */
    
    var houseId: NSString! = ""
    var houseTitle: NSString! = ""
    var houseName: NSString! = ""
    var houseAddress: NSString! = ""
    var brokerNum: NSString! = ""
    var clientNum: NSString! = ""
    var houseAvgPrice: NSString! = ""
    var commission: NSString! = ""
    var houseType: NSString! = ""
    var houseTotalPrice: NSString! = ""
    var houseFamilyType: NSString! = ""
    var houseArea: NSString! = ""
    var housePic: NSString! = ""
    var areaId: NSString! = ""
    
    var areaName: NSString! = ""
    var plateId: NSString! = ""
    var plateName: NSString! = ""
    var price: NSString! = ""
    var isAppoint: NSString! = ""
    var scdHandHousesId: NSString! = ""
    var villageName: NSString! = ""
    var appointNum: NSString! = ""
    var brokerId: NSString! = ""
    var villageId: NSString! = ""
    var title: NSString! = ""
    var cityId: NSString! = ""
    var hallCount: NSString! = ""
    var roomType: NSString! = ""
    
    var toiletCount: NSString! = ""
    var picKey: NSString! = ""
    var shareUrl: NSString! = ""
    var roomCount: NSString! = ""
    var proportion: NSString! = ""

    override init()
    {
        super.init()
    }
    
    init(relateHouse info: NSDictionary)
    {
        super.init()
        
        self.housePic = info.stringObjectForKey("housePic")
        self.houseTitle = info.stringObjectForKey("houseTitle")
        self.houseName = info.stringObjectForKey("houseName")
        self.houseAddress = info.stringObjectForKey("houseAddress")
        self.brokerNum = info.stringObjectForKey("brokerNum")
        self.clientNum = info.stringObjectForKey("clientNum")
        self.houseAvgPrice = info.stringObjectForKey("houseAvgPrice")
        self.commission = info.stringObjectForKey("commission")
        self.shareUrl = info.stringObjectForKey("shareUrl")
        self.houseType = info.stringObjectForKey("houseType")
        self.houseTotalPrice = info.stringObjectForKey("houseTotalPrice")
        self.houseFamilyType = info.stringObjectForKey("houseFamilyType")
        self.houseArea = info.stringObjectForKey("houseArea")
        
        self.areaId = info.stringObjectForKey("areaId")
        self.areaName = info.stringObjectForKey("areaName")
        self.plateId = info.stringObjectForKey("plateId")
        self.plateName = info.stringObjectForKey("plateName")
        self.price = info.stringObjectForKey("price")
        self.isAppoint = info.stringObjectForKey("isAppoint")
        self.scdHandHousesId = info.stringObjectForKey("scdHandHousesId")
        self.villageName = info.stringObjectForKey("villageName")
        
        self.appointNum = info.stringObjectForKey("appointNum")
        self.brokerId = info.stringObjectForKey("brokerId")
        self.villageId = info.stringObjectForKey("villageId")
        self.title = info.stringObjectForKey("title")
        self.cityId = info.stringObjectForKey("cityId")
        self.hallCount = info.stringObjectForKey("hallCount")
        self.roomType = info.stringObjectForKey("roomType")
        self.toiletCount = info.stringObjectForKey("toiletCount")
        self.picKey = info.stringObjectForKey("picKey")
        
        self.roomCount = info.stringObjectForKey("roomCount")
        self.proportion = info.stringObjectForKey("proportion")
        
        if (self.houseType.isEqualToString("new"))
        {
            self.houseId = info.stringObjectForKey("projectId")
        }
        else
        {
            self.houseId = info.stringObjectForKey("scdHandHousesId")
        }
        
    }
    
}
