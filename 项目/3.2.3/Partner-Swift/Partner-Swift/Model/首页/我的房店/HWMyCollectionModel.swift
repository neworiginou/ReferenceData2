//
//  HWMyCollectionModel.swift
//  Partner-Swift
//
//  Created by hw500027 on 15/3/3.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：我的房店-我的收藏列表model
//
//  修改记录：
//      姓名         日期              修改内容
//    陆晓波      2015-03-03           文件创建

import UIKit

class HWMyCollectionModel: HWSelectCustomerModel
{
    let areaId : NSString?//MYP add v3.2.1新接口中没有的出参
    let areaName : NSString?
    let plateId : NSString?//MYP add v3.2.1新接口中没有的出参
    let plateName : NSString?
    let price : NSString?
    let proportion : NSString?
    let roomCount : NSString?
    let scdhandHousesId : NSString?
    let brokerId : NSString?
    let villageId : NSString?
    let villageName : NSString?
    let title : NSString?
    let cityId : NSString?
    let hallCount : NSString?
    let roomType : NSString?
    let toiletCount : NSString?
    let picKey : NSString?
    let collectNum : NSString?
    
    //MYP add v3.2.1新增参数
    let myCollectionId:String = ""
    let addressName:String = ""
    let projectId:String = ""
    let housePic:String = ""
    let houseName:String = ""
    let houseAddress:String = ""
    let brokerNum:String = ""
    let clientNum:String = ""
    let houseAvgPrice:String = ""
    let commission:String = ""
    let shareUrl:String = ""
    let isNewHouse:String = ""
    
    init(dict:NSDictionary)
    {
        self.areaId = dict.stringObjectForKey("areaId")
        self.areaName = dict.stringObjectForKey("areaName")
        self.plateId = dict.stringObjectForKey("plateId")
        self.plateName = dict.stringObjectForKey("plateName")
        self.price = dict.stringObjectForKey("price")
        self.proportion = dict.stringObjectForKey("proportion")
        self.roomCount = dict.stringObjectForKey("roomCount")
        self.scdhandHousesId = dict.stringObjectForKey("scdhandHousesId")
        self.brokerId = dict.stringObjectForKey("brokerId")
        self.villageId = dict.stringObjectForKey("villageId")
        self.villageName = dict.stringObjectForKey("villageName")
        self.title = dict.stringObjectForKey("title")
        self.cityId = dict.stringObjectForKey("cityId")
        self.hallCount = dict.stringObjectForKey("hallCount")
        self.roomType = dict.stringObjectForKey("roomType")
        self.toiletCount = dict.stringObjectForKey("toiletCount")
        self.picKey = dict.stringObjectForKey("picKey")
        self.collectNum = dict.stringObjectForKey("collectNum")
        
        /*
        let myCollectionId:String = ""
        let addressName:String = ""
        let projectId:String = ""
        let housePic:String = ""
        let houseName:String = ""
        let houseAddress:String = ""
        let brokerNum:String = ""
        let clientNum:String = ""
        let houseAvgPrice:String = ""
        let commission:String = ""
        let shareUrl:String = ""
        let isNewHouse:String = ""
        */
        myCollectionId = dict.stringObjectForKey("myCollectionId")
        addressName = dict.stringObjectForKey("addressName")
        projectId = dict.stringObjectForKey("projectId")
        housePic = dict.stringObjectForKey("housePic")
        houseName = dict.stringObjectForKey("houseName")
        houseAddress = dict.stringObjectForKey("houseAddress")
        brokerNum = dict.stringObjectForKey("brokerNum")
        clientNum = dict.stringObjectForKey("clientNum")
        houseAvgPrice = dict.stringObjectForKey("houseAvgPrice")
        commission = dict.stringObjectForKey("commission")
        shareUrl = dict.stringObjectForKey("shareUrl")
        isNewHouse = dict.stringObjectForKey("isNewHouse")
    }
}

/*
"areaId":"" -区域ID
"areaName":"" -区域名字
"plateId":"" -板块ID
"plateName":"" -板块名
"price":"" -价格
"proportion":"" -面积
"roomCount":"" -几室
"scdHandHousesId ":"" -二手房id
"brokerId":"" -经纪人id
"villageId":"" -小区id
"villageName":"" -小区名称
"title":"" -标题
"cityId":"" -城市ID
"hallCount":"" -几厅
"roomType":"" -户型
"toiletCount":"" -卫生间
"picKey":"" -图片key
"collectNum":"" -关注人数
*/