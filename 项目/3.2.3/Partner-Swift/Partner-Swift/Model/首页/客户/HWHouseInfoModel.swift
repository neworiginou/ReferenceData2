//
//  HWHouseInfoModel.swift
//  Partner-Swift
//
//  Created by wuxiaohong on 15/2/27.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWHouseInfoModel: NSObject
{
    var dicItemValue:NSString?
    /***-----***/
    var followId:NSString?//房源交易流程ID
    var houseId:NSString?//房源ID
    var houseName:NSString?//房源名称
    var houseType:NSString?//房源类型（newHouse 新房,secondHouse 二手房）
    var houseState:NSString?//客户报备/预约房源状态【中文】针对新房
    var lastStateChangeTime:NSString?//客户报备/预约房源状态最后状态变化时间(yyyy-MM-dd HH:mm:ss)
    var houseAddress:NSString?//房源地址(区域-板块)
    var visitedProtectDays:NSString!//到访保护期剩余天数(默认为-1,-1为无保护期，0为过保护期，大于0为剩余保护期)
    var houseTotalPrice:NSString!//总价
    var houseArea:NSString!//面积
    var houseFamilyType:NSString?//户型
    var brokerName:NSString?//经纪人姓名
    var brokerPhone:NSString?//经纪人电话
    var appointStatus:NSString?//0未发起，1预约中，2预约成功，3预约失败，针对二手房
//    var nodeList:nsar?//["报备","到访","下定","成交","结佣"]
    var nodeList:NSArray?//["报备","到访","下定","成交","结佣"]
    var currNode:NSString?//当前节点(0报备，1到访，2下定，3成交，4结佣)
    var showLook:NSString?//是否显示带看(0不显示，1显示)
    var scheduleList:NSArray?
    var followRecordArry:NSMutableArray!
    var seletedStr: NSString = "0"
    var priviledgeSelectedStr:NSString = "0";
    var brokerId:NSString!
    
    override init() {
        super.init()
        followRecordArry = NSMutableArray()
        scheduleList = NSArray()
    }
    init(dic:NSDictionary)
    {
        super.init();
        self.followRecordArry = NSMutableArray()
        self.followId = dic .stringObjectForKey("followId")
        self.houseId = dic .stringObjectForKey("houseId")
        self.houseName = dic .stringObjectForKey("houseName")
        self.houseType =  dic.stringObjectForKey("houseType")
       
    
        self.houseState = dic .stringObjectForKey("houseState")
        self.lastStateChangeTime = dic .stringObjectForKey("lastStateChangeTime")
        self.houseAddress = dic .stringObjectForKey("houseAddress")
        self.visitedProtectDays = dic .stringObjectForKey("visitedProtectDays")
        self.houseTotalPrice = dic .stringObjectForKey("houseTotalPrice")
        self.houseArea = dic .stringObjectForKey("houseArea")
        self.houseFamilyType = dic .stringObjectForKey("houseFamilyType")
        self.brokerName = dic .stringObjectForKey("brokerName")
        self.brokerPhone = dic .stringObjectForKey("brokerPhone")
        self.appointStatus = dic .stringObjectForKey("appointStatus")
        self.nodeList = dic.arrayObjectForKey("nodeList")
        self.currNode = dic .stringObjectForKey("currNode")
        self.showLook = dic .stringObjectForKey("showLook")
        self.brokerId = dic .stringObjectForKey("brokerId")
       // self.scheduleList = dic .arrayObjectForKey("scheduleList")
        self.pinjieFollowRecord(dic.arrayObjectForKey("scheduleList"))
    }
    
    func pinjieFollowRecord(followRecordArrys:NSArray)
    {
        var dic = NSDictionary()
        for  dic in  followRecordArrys
        {
            var listModel = HWHouseListModel()
            var str =   dic .stringObjectForKey("time")
            listModel.time = Utility .getTimeWithTimestamp(str, dateFormatStr: "yyyy-MM-dd HH:mm:ss")
            listModel.content = dic .stringObjectForKey("content")
            followRecordArry?.addObject(listModel)
            
        }
    }
    
}
