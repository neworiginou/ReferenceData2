//
//  HWMyHouseModel.swift
//  Partner-Swift
//
//  Created by hw500027 on 15/3/3.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：我的房店-我的房源列表model
//
//  修改记录：
//      姓名         日期              修改内容
//    陆晓波      2015-03-03           文件创建

import UIKit

class HWMyHouseModel: NSObject
{
    let scdhandHousesId : NSString?
    let houseName : NSString?
    let addressName : NSString?
    let collectNum : NSString?
    let sign : NSString?
    let puttopTime : NSString?
    let status : NSString?
    
    init(dict:NSDictionary)
    {
        self.scdhandHousesId = dict.stringObjectForKey("scdhandHousesId")
        self.houseName = dict.stringObjectForKey("houseName")
        self.addressName = dict.stringObjectForKey("addressName")
        self.collectNum = dict.stringObjectForKey("collectNum")
        self.sign = dict.stringObjectForKey("sign")
        self.puttopTime = dict.stringObjectForKey("puttopTime")
        self.status = dict.stringObjectForKey("status")

    }
}
/*
"id":"" -二手房源id
"houseName":"" -小区名+几栋几室
"addressName":"" -区域加板块
"collectNum":"" -关注经纪人数
"sign":"" -标签：满五年,学区房
"puttopTime":"" -置顶时间
"status":"" -状态 putup:上架;putdown:下架',
*/