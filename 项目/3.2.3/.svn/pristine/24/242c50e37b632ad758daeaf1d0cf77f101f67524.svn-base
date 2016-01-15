//
//  HWScheduleModel.swift
//  Partner-Swift
//
//  Created by caijingpeng.haowu on 15/2/23.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWScheduleModel: NSObject {
   /*
    
    "id":"", - 日程
    "clientInfoId":"" -客户ID
    "houseId":""      -房源ID
    "houseType":""    -房源类型(newHouse,secondHouse)
    "clientName":"", - 客户姓名
    "clientPhone":"", - 客户电话，
    "houseName":"", - 房源名称，
    "houseBrokerName":"", -房源经纪人姓名
    "houseBrokerPhone":"", -房源经纪人电话
    "finishTime":"", - 计划完成时间[yyyy-MM-dd HH:mm:ss]，
    "lastFinishTime":"", -上一次计划完成时间
    "content" : "", -内容,
    "picKeys" : "", -图片key（多长逗号分开），
    "1ongitude":"",-经度
    "latitude":"", -纬度
    "address":"",  -位置
    "state":"" --0未完成，1已完成*/
    
    /*
    日历
    address = "<null>";
    clientInfoId = 1100000012079;
    clientName = dddddd;
    clientPhone = "<null>";
    content = "\U4eca\U592910\U70b9\U6709\U4e2a\U4f1a\U8bae";
    finishTime = 1426198440000;
    hasPic = 1;
    houseBrokerName = "\U9ad8\U6c381";
    houseBrokerPhone = 18913199718;
    houseName = "\U4e1c\U6d77\U4e8c\U6751";
    lastFinishTime = 1426198440000;
    latitude = "<null>";
    longitude = "<null>";
    partnerScheduleId = 36;
    picKey = "";
    scheduleStatus = undo;
    state = 0;
    
    列表
    address = "";
    clientInfoId = 1100000012079;
    clientName = dddddd;
    clientPhone = "<null>";
    content = "\U4eca\U592910\U70b9\U6709\U4e2a\U4f1a\U8bae";
    finishTime = 1426198440000;
    hasPic = "<null>";
    houseBrokerName = "\U9ad8\U6c381";
    houseBrokerPhone = 18913199718;
    houseName = "\U4e1c\U6d77\U4e8c\U6751";
    lastFinishTime = 1426198440000;
    latitude = "<null>";
    longitude = "<null>";
    partnerScheduleId = 36;
    picKey = "<null>";
    scheduleStatus = undo;
    state = 0;
    
    
    address = "<null>";
    appointmentState = "<null>";
    appointmentStateName = "<null>";
    clientInfoId = 11026266;
    clientName = "\U6d4b\U8bd5";
    clientPhone = 15921456985;
    content = "";
    finishTime = 1426824900000;
    hasPic = 0;
    houseBrokerName = "\U7941\U677e\U6ce2";
    houseBrokerPhone = 18114511797;
    houseId = 100;
    houseName = "\U745e\U5b89\U9633\U5149\U5fa1\U666f";
    houseType = secondhand;
    isRead = readed;
    lastFinishTime = "<null>";
    latitude = "<null>";
    longitude = "<null>";
    partnerScheduleId = 445;
    picKey = "<null>";
    scheduleStatus = undo;
    sourceId = "<null>";
    sourceType = new;
    state = 0;
    
    */
    
    var clientInfoId: NSString!
    var houseId: NSString!
    var houseType: NSString!
    var clientName: NSString!
    var clientPhone: NSString!
    var houseName: NSString!
    var houseBrokerName: NSString!
    var houseBrokerPhone: NSString!
    var finishTime: NSString!
    var lastFinishTime: NSString!
    var content: NSString!
    var picKey: NSString!
    var longitude: NSString!
    var latitude: NSString!
    var address: NSString!
    var state: NSString!
    
    var sourceType: NSString!
    var sourceId: NSString!
    var isRead: NSString!
    var appointmentState: NSString!
    var appointmentStateName: NSString!
    var hasPic: NSString!
    var partnerScheduleId: NSString!
    var scheduleStatus: NSString!
    var sourceWay:NSString!
    
    override init() {
        super.init()
    }
    
    init(scheduleInfo info: NSDictionary)
    {
        super.init()
        
        self.partnerScheduleId = info.stringObjectForKey("partnerScheduleId")
        self.clientInfoId = info.stringObjectForKey("clientInfoId")
        self.houseId = info.stringObjectForKey("houseId")
        self.houseType = info.stringObjectForKey("houseType")
        self.clientName = info.stringObjectForKey("clientName")
        self.clientPhone = info.stringObjectForKey("clientPhone")
        self.houseName = info.stringObjectForKey("houseName")
        self.houseBrokerName = info.stringObjectForKey("houseBrokerName")
        self.houseBrokerPhone = info.stringObjectForKey("houseBrokerPhone")
        self.finishTime = info.stringObjectForKey("finishTime")
        self.lastFinishTime = info.stringObjectForKey("lastFinishTime")
        self.content = info.stringObjectForKey("content")
        self.picKey = info.stringObjectForKey("picKey")
        self.longitude = info.stringObjectForKey("longitude") 
        self.latitude = info.stringObjectForKey("latitude")
        self.address = info.stringObjectForKey("address")
        self.state = info.stringObjectForKey("state")
        
        self.sourceType = info.stringObjectForKey("sourceType")
        self.sourceId = info.stringObjectForKey("sourceId")
        self.isRead = info.stringObjectForKey("isRead")
        self.appointmentState = info.stringObjectForKey("appointmentState")
        self.appointmentStateName = info.stringObjectForKey("appointmentStateName")
        self.hasPic = info.stringObjectForKey("hasPic")
        self.scheduleStatus = info.stringObjectForKey("scheduleStatus")
        self.sourceWay = info.stringObjectForKey("sourceWay")
    }
    
}
