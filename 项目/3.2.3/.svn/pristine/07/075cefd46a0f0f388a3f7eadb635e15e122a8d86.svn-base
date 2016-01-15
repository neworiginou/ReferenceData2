//
//  HWHomeModel.swift
//  Partner-Swift
//
//  Created by gusheng on 15/3/5.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWHomeModel: NSObject
{
   /*
    {
    "detail": "请求数据成功!",
    "status":"" ,
    "data":{
    hasHiMsg:"" --是否有HI消息（0无，1有，默认0）
    adMsgInfo:"" --广告消息（文本）
    newClientNum:"", --释放新客户数（默认0）
    remindClientNum:"", --提醒客户数（默认0）
    remindScheduleNum:"", --日程数（默认0）
    remindHouseStoreNum:"", --我的房店数（默认0）
     :"",  --是否有新房提醒(0无，1有，默认0)
    hasSecondHouse:"", --是否有二手房提醒(0无，1有，默认0)
    }
    }
    */
    var hasHiMsg:NSString = "";
    var adMsgInfo:NSString = "";
    var newClientNum:NSString = "";
    var remindClientNum:NSString = "";
    var remindScheduleNum:NSString = "";
    var remindHouseStoreNum:NSString = "";
    var hasNewHouse:NSString = "";
    var hasSecondHouse:NSString = "";
    var role:NSString = "";
    var scdHousesNum:NSString = ""
    
    init(dic:NSDictionary)
    {
        self.hasHiMsg = dic.stringObjectForKey("hasHiMsg");
        self.adMsgInfo = dic.stringObjectForKey("adMsgInfo");
        self.newClientNum = dic.stringObjectForKey("newClientNum");
        self.remindClientNum = dic.stringObjectForKey("remindClientNum");
        self.remindScheduleNum = dic.stringObjectForKey("remindScheduleNum");
        self.remindHouseStoreNum  = dic.stringObjectForKey("remindHouseStoreNum");
        self.hasNewHouse = dic.stringObjectForKey("hasNewHouse");
        self.hasSecondHouse = dic.stringObjectForKey("hasSecondHouse");
        self.role = dic.stringObjectForKey("role");
        self.scdHousesNum = dic .stringObjectForKey("scdHousesNum")
    }
    override init()
    {
        
    }
}
