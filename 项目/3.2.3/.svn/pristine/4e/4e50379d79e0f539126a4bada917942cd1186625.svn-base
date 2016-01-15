//
//  HWScdHouseDetailModel.swift
//  Partner-Swift
//
//  Created by niedi on 15/2/27.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：二手房 房源详情、发布房源、房源编辑 共用 model
//
//  修改记录：
//      姓名         日期               修改内容
//      聂迪      2015-02-27           创建model
//

import UIKit

//图片数据 dict
/*createTime = 1426148033000;
creater = 1000002002724;
creator = 1000002002724;
disabled = 0;
id = 15;
isMain = no;
modifier = "<null>";
modifyTime = "<null>";
picKey = "/read/55014a3ce4b0c3a204357ec7";
picType = "house_img";
scdhandHousesId = 50;
version = "<null>";*/

class HWScdHouseDetailModel: NSObject {
    
   //MARK: 字段重复且字段名相同字段 共用 && 字段重复但字段名不同字段 不共用
    
    //房源发布或编辑
    var villageId: String! = ""  //小区id
    var villageName: String! = ""   //小区名称
    var title: String! = ""   //标题
    var buildingNo: String! = ""   //楼号
    var houseNo: String! = ""   //门牌号
    var price: String! = ""   //价格
    var area: String! = ""   //面积
    var propertyRights: String! = ""   //产权
    var years: String! = ""   //年代
    var type: String! = ""   //类型 residence:住宅 villa:别墅 commercial:商住
    var roomCount: String! = ""   //室
    var hallCount: String! = ""   //厅
    var toiletCount: String! = ""   //卫生间
    var floor: String! = ""   //楼层
    var toward: String! = ""   //朝向 south:朝南 north:朝北 east:朝东 west:朝西 east_west:东西向 south_north: 南北通透
    var decorate: String! = ""   //装修 workblank:毛坯 simple:简装修 refined:精装修 luxury:豪华装修
    var sign: NSArray = [] //标签
    var comm: NSArray = [] //小区图数组 [{picKey:*** --图片key,isMain:*** --是否主图 yes:是;no:否}],  -小区图数组
    var house: NSArray = [] //户型图数组
    var effect: NSArray = [] //效果图数组
    var aset: NSArray = [] //配套图数组
    var temp: NSArray = [] //样板图数组
    var inner: NSArray = [] //室内图数组
    var name: String! = ""   //业主姓名
    var phone: String! = ""   //业主电话
    var sex: String! = ""   //业主 性别 0女，1男
    
    //房源详情 特有的 成员变量
    var brokerId: String! = ""   //经纪人id
    var brokerName: String! = ""   //经纪人姓名
    var phoneNo: String! = ""   //经纪人电话
    var longitude: String! = ""   //经度
    var latitude: String! = ""   //纬度
    var myAppoint: String! = ""   //申请的预约是否已同意（yes no）
    var lock: String! = ""   //是否加锁（yes no）
    var scdHandHousesId: String! = ""   //二手房id
    var housesOwnerId: String! = ""   //业主id
    var housesOwnerName: String! = ""   //业主名字
    var housesOwnerPhone: String! = ""   //业主电话
    var proportion: String! = ""   //面积
    var status: String! = ""   //状态 putup:上架;putdown:下架 审核中：audit
    var floorSum: String! = ""   //共几层
    var address: String! = ""   //地址
    var complaint: String! = ""   //是否已投诉：0 未投诉 1已投诉
    var scdHouseCount: String! = ""   //二手房预约客户个数
    var whichOne: String! = ""   //是否是自己房源：我的：Mine，收藏：myFavorite，合作：collaborate
    var integral: String! = ""   //应扣多少积分
    var isRental:String! = "" //二手房来源
    var permission:String! = "C" //数据权限
    var housesDescription:String!
    //跳转到php
    var phpImUrl:String! = ""
    var messageId:String! = ""
    var messageSource:String! = ""
    var sourceWay:String! = ""

   

   
    
    
    
    func initWithDict(dict: NSDictionary)
    {
        self.villageId = dict.stringObjectForKey("villageId")
        self.villageName = dict.stringObjectForKey("villageName")
        self.title = dict.stringObjectForKey("title")
        self.buildingNo = dict.stringObjectForKey("buildingNo")
        self.houseNo = dict.stringObjectForKey("houseNo")
        self.price = dict.stringObjectForKey("price")
        self.proportion = dict.stringObjectForKey("proportion")
        self.area = dict.stringObjectForKey("proportion")
        self.propertyRights = dict.stringObjectForKey("propertyRights")
        self.years = dict.stringObjectForKey("years")
        self.type = dict.stringObjectForKey("type")
        self.roomCount = dict.stringObjectForKey("roomCount")
        self.hallCount = dict.stringObjectForKey("hallCount")
        self.toiletCount = dict.stringObjectForKey("toiletCount")
        self.floor = dict.stringObjectForKey("floor")
        self.toward = dict.stringObjectForKey("toward")
        self.decorate = dict.stringObjectForKey("decorate")
        var signStr = dict.stringObjectForKey("sign")
        self.sign = signStr.componentsSeparatedByString(",")
        self.sex = dict.stringObjectForKey("sex")
        self.brokerId = dict.stringObjectForKey("brokerId")
        self.brokerName = dict.stringObjectForKey("brokerName")
        self.phoneNo = dict.stringObjectForKey("phoneNo")
        self.longitude = dict.stringObjectForKey("longitude")
        self.latitude = dict.stringObjectForKey("latitude")
        self.myAppoint = dict.stringObjectForKey("myAppoint")
        self.lock = dict.stringObjectForKey("lock")
        self.scdHandHousesId = dict.stringObjectForKey("scdHandHousesId")
        self.housesOwnerId = dict.stringObjectForKey("housesOwnerId")
        self.housesOwnerName = dict.stringObjectForKey("housesOwnerName")
        self.name = dict.stringObjectForKey("housesOwnerName")
        self.housesOwnerPhone = dict.stringObjectForKey("housesOwnerPhone")
        self.phone = dict.stringObjectForKey("housesOwnerPhone")
        self.status = dict.stringObjectForKey("status")
        self.floorSum = dict.stringObjectForKey("floorSum")
        self.address = dict.stringObjectForKey("address")
        self.complaint = dict.stringObjectForKey("complaint")
        self.scdHouseCount = dict.stringObjectForKey("scdHouseCount")
        self.whichOne = dict.stringObjectForKey("whichOne")
        self.integral = dict.stringObjectForKey("integral")
        self.comm = dict.arrayObjectForKey("comm")
        self.house = dict.arrayObjectForKey("house")
        self.effect = dict.arrayObjectForKey("effect")
        self.aset = dict.arrayObjectForKey("aset")
        self.temp = dict.arrayObjectForKey("temp")
        self.inner = dict.arrayObjectForKey("inner")
        self.isRental = dict .stringObjectForKey("isRental")
        self.permission = dict .stringObjectForKey("permission")
        self.phpImUrl  = dict .stringObjectForKey("phpImUrl")
        self.messageId = dict .stringObjectForKey("messageId")
        self.messageSource = dict .stringObjectForKey("messageSource")
        self.housesDescription = dict .stringObjectForKey("housesDescription")
        self.sourceWay = dict.stringObjectForKey("sourceWay");
        
        
        
    }
    
}
/* key: ***   --用户key
villageId:*** --小区id
villageName:*** --小区名称
title:*** --标题
buildingNo:*** --楼号
houseNo:*** --门牌号
price:*** --价格
area:*** --面积
propertyRights:*** --产权
years:*** --年代
type:*** --类型 residence:住宅 villa:别墅 commercial:商住
roomCount:*** --室
hallCount:*** --厅
toiletCount:*** --卫生间
floor:*** --楼层
toward:*** --朝向 south:朝南 north:朝北 east:朝东 west:朝西 east_west:东西向 south_north:南北通透
decorate:*** --装修 workblank:毛坯 simple:简装修 refined:精装修 luxury:豪华装修
sign:*** --标签
"comm":[{picKey:*** --图片key,isMain:*** --是否主图 yes:是;no:否}],  -小区图数组
"house":[{picKey:*** --图片key,isMain:*** --是否主图 yes:是;no:否}],  -户型图数组
"effect":[{picKey:*** --图片key,isMain:*** --是否主图 yes:是;no:否}],  -效果图数组
"aset":[{picKey:*** --图片key,isMain:*** --是否主图 yes:是;no:否}]":"",  -配套图数组
"temp":[{picKey:*** --图片key,isMain:*** --是否主图 yes:是;no:否}]":"",  -样板图数组
"inner":[{picKey:*** --图片key,isMain:*** --是否主图 yes:是;no:否}]":"",  -室内图数组
name:*** --业主姓名
phone:*** --电话
sex:*** --性别 0女，1男


{
"detail": "请求数据成功! = ""  ",
"status": "1",
"data": {
"brokerName":"",  -经纪人姓名
"phoneNo":"",  -经纪人电话
"longitude":"",  -经度
"latitude":"",  -纬度
"myAppoint":"",  -申请的预约是否已同意（yes no）
"isLock":"",  -是否加锁（yes no）
"scdHandHousesId":"",  -二手房id
"brokerId":"",  -经纪人id
"villageId":"",  -小区id
"housesOwnerId":"",  -业主id
"housesOwnerName":"",  -业主名字
"housesOwnerPhone":"",  -业主电话
"sex":"",  -业主性别
"villageName":"",  -小区名称
"buildingNo":"",  -楼号
"houseNo":"",  -门牌
"propertyRights":"",  -产权
"years":"",  -年代
"toward":"",  -朝向
"type":"",  -类型
"decorate":"",  -装修
"sign":"",  -标签
"title":"",  -标题
"price":"",  -价格
"proportion":"",  -面积
"roomCount":"",  -几室
"hallCount":"",  -几厅
"roomType":"",  -户型
"toiletCount":"",  -卫生间
"status":"",  -状态 putup:上架;putdown:下架
"floor":"",  -楼层
"floorSum":"",  -共几层
"address":"",  -地址
"complaint":"" --是否已投诉：0 未投诉 1已投诉
"scdHouseCount":"",  -二手房预约客户个数
"whichOne":"",  -是否是自己房源：我的：Mine，收藏：myFavorite，合作：collaborate
"comm":[{图片id:id，图片key:picKey}],  -小区图数组
"house":[{图片id:id，图片key:picKey}],  -户型图数组
"effect":[{图片id:id，图片key:picKey}],  -效果图数组
"aset":[{图片id:id，图片key:picKey}]":"",  -配套图数组
"temp":[{图片id:id，图片key:picKey}]":"",  -样板图数组
"inner":[{图片id:id，图片key:picKey}]":"",  -室内图数组
}
}

*/