//
//  HWScdHouseModel.swift
//  Partner-Swift
//
//  Created by niedi on 15/2/26.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：二手房首页列表 数据模型
//
//  修改记录：
//      姓名         日期               修改内容
//      聂迪      2015-02-26           数据模型实现
//

import UIKit

class HWScdHouseModel: HWSelectCustomerModel
{
    //MARK: 成员变量
    var picKey: String! //图片key
    var title: String!  //标题
    var villageId: String!//小区名
    var villageName: String!//小区Id
    var areaId: String!//区域Id
    var areaName: String!//区域名
    var plateId: String!//板块Id
    var plateName: String!//板块名
    var roomCount: String!//几室
    var hallCount: String!//几厅
    var toiletCount: String!//几卫
    var proportion: String!//面积
    var price: String!//价格
    var isAppoint: String!//是否已预约
    var appointNum: String!//预约人数
    var scdHandHousesId: String!//二手房Id
    var brokerId: String!//经纪人Id
    var orderType: String!//排序
    var roomType: String!//户型
    var cityId: String!//城市ID
    var cityName: String!//城市名称
    var sortSign: String = ""   //排序标志
    
    //客户详情的
    var houseId :String!
    var pic:String!
    var houseArea:String!
    
    
    //MARK: 初始化方法
    init(dict: NSDictionary)
    {
        super.init();
        //客户的
        self.houseId = dict.stringObjectForKey("scdHandHousesId")
        if(self.houseId == "")
        {
            self.houseId = dict.stringObjectForKey("scdhandHousesId")
        }
        
        self.houseArea = dict.stringObjectForKey("houseArea")
        
        self.picKey = dict.stringObjectForKey("picKey")
        self.title = dict.stringObjectForKey("title")
        self.villageId = dict.stringObjectForKey("villageId")
        self.villageName = dict.stringObjectForKey("villageName")
        self.areaId = dict.stringObjectForKey("areaId")
        self.areaName = dict.stringObjectForKey("areaName")
        self.plateId = dict.stringObjectForKey("plateId")
        self.plateName = dict.stringObjectForKey("plateName")
        self.roomCount = dict.stringObjectForKey("roomCount")
        self.hallCount = dict.stringObjectForKey("hallCount")
        self.toiletCount = dict.stringObjectForKey("toiletCount")
        self.proportion = dict.stringObjectForKey("proportion")
        self.price = dict.stringObjectForKey("price")
        self.isAppoint = dict.stringObjectForKey("isAppoint")
        self.appointNum = dict.stringObjectForKey("appointNum")
        self.scdHandHousesId = dict.stringObjectForKey("scdHandHousesId")
        self.brokerId = dict.stringObjectForKey("brokerId")
        self.orderType = dict.stringObjectForKey("orderType")
        self.roomType = dict.stringObjectForKey("roomType")
        self.cityId = dict.stringObjectForKey("cityId")
        self.cityName = dict.stringObjectForKey("cityName")
    }
    
    override init() {
        
    }
}

/*{
"areaId":"", -区域ID
"areaName":"", -区域名字
"plateId":"", -板块ID
"plateName":"",  -板块名
"price":"", -价格
"proportion":"", -面积
"roomCount":"", -几室
"isAppoint":"", -是否已预约 0未预约 1已预约
"scdHandHousesId":"", -二手房id
"brokerId":"", -经纪人id
"villageId":"", -小区id
"villageName":"", -小区名称
"title":"", -标题
"appointNum":"" -预约人数
"cityId":"", -城市ID
"hallCount":"", -几厅
"roomType":"", -户型
"toiletCount":"", -卫生间
"picKey":"", -图片key
"orderType":"", -排序
},

areaId = "<null>";
areaName = "<null>";
avgPirce = "1e-05";
brokerId = "<null>";
cityId = 1;
cityName = "\U82cf\U5dde\U5e02";
createTime = 1425969816000;
disabled = 0;
hallCount = 0;
orderType = "<null>";
picKey = "<null>";
plateId = 4467;
plateName = "<null>";
price = 200000;
proportion = 2;
roomCount = 0;
roomType = 0;
scdHandHousesId = "<null>";
status = putup;
title = "\U6768\U7389\U73af";
toiletCount = 0;
villageId = "<null>";
villageName = "\U4e1c\U6d77\U4e8c\U6751";
*/
