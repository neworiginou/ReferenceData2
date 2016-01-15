//
//  HWScdHouVillageChoiceModel.swift
//  Partner-Swift
//
//  Created by niedi on 15/3/4.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：二手房 房源发布 选择小区 小区数据模型
//
//  修改记录：
//      姓名         日期               修改内容
//      聂迪      2015-02-26           数据模型实现
//

import UIKit

class HWScdHouVillageChoiceModel: NSObject
{
    var villageId: String?
    var villageName: String?
    var villageAddress: String?
    var distance: String?
    var longitude: String?
    var latitude: String?
    var cityId: String?
    var pinyin: String?
    
    init(dict: NSDictionary)
    {
        self.villageId = dict.stringObjectForKey("villageId")
        self.villageName = dict.stringObjectForKey("villageName")
        self.villageAddress = dict.stringObjectForKey("villageAddress")
        self.distance = dict.stringObjectForKey("distance")
        self.longitude = dict.stringObjectForKey("longitude")
        self.latitude = dict.stringObjectForKey("latitude")
        self.cityId = dict.stringObjectForKey("cityId")
        self.pinyin = dict.stringObjectForKey("pinyin")
    }
    
}

/*
"content": [
{
"id":"",          -小区ID
"villageName":"", - 小区名称
"address":"",     - 小区地址
"distance":"",    - 距离(米)
"longitude":"",   - 位置经度
"latitude":""     - 位置纬度
"areaId":""       - 区域ID
"plateId":""      - 板块ID
},
{ },
{ }
],
{
cityId = "<null>";
distance = 10627;
latitude = "31.248593";
longitude = "121.442189";
pinyin = "<null>";
villageAddress = "\U5e38\U5fb7\U8def1298\U5f04";
villageId = 430969;
villageName = "\U957f\U5bff\U65b0\U6751";
},
*/