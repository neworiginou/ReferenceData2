//
//  IndividualCenterModel.swift
//  Partner-Swift
//
//  Created by hw500029 on 15/2/25.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import Foundation
import CoreLocation
//排行榜 MYP add
class HWChartsModel: NSObject {
    var name:NSString?//个人名/机构名
    var picKey:NSString?
    var result:NSString?//个人业绩/机构业绩
    
    func fetchData(dic:NSDictionary)
    {
        name = dic.stringObjectForKey("name")
        picKey = dic.stringObjectForKey("picKey")
        
//        if dic.stringObjectForKey("result").isEqualToString("")
//        {
//            result = "0.00"
//        }
//        else
//        {
//            var str = dic.stringObjectForKey("result")
//            result = "\(str)"
//        }
        result = dic.stringObjectForKey("result")
//        println("result ==== \(result)")
    }
}

//我的下线 MYP add
class HWSubordinateModel: NSObject {
    var brokerId:NSString?
    var brokerName:NSString?
    var brokerPhone:NSString?
    var singleResult:NSString?//业绩
    var mongKey:NSString?
    var clientNum:NSString?//客户数
    
    func fetchData(dic:NSDictionary)
    {
        brokerId = dic.stringObjectForKey("brokerId")
        brokerName = dic.stringObjectForKey("brokerName")
        brokerPhone = dic.stringObjectForKey("brokerPhone")
        singleResult = dic.stringObjectForKey("singleResult")
        mongKey = dic.stringObjectForKey("mongKey")
        clientNum = dic.stringObjectForKey("clientNum")    }
}

//扫描结果(附近经纪人) MYP add
class HWScanBrokerModel: NSObject
{
    var brockerName: NSString?
    var brockerID: NSString?
    var picKey: NSString?
    var longitude: NSString = ""
    var latitude: NSString = ""
    
    var loginTime: NSString?
    
    var distance: NSString?
    var brokerAddressInfo: NSString?
    func fetchData(dic:NSDictionary)
    {
        brockerName = dic.stringObjectForKey("brokerName")
        brockerID = dic.stringObjectForKey("brokerId")
        picKey = dic.stringObjectForKey("picKey")
        longitude = dic.stringObjectForKey("longitude")
        latitude = dic.stringObjectForKey("latitude")
        loginTime = dic.stringObjectForKey("loginTime")
        //self.getAddressInfo(latitude!, log: loginTime!)
        //brokerAddressInfo = self.getAddressInfo("31.350376", log: "121.446871")
    }
    
    func getAddressInfo(lat:NSString, log:NSString)
    {
        var addressInfo:NSString?
        var location = CLLocation(latitude: lat.doubleValue, longitude: log.doubleValue)
        var geocoder = CLGeocoder()

        geocoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            if error != nil
            {
//                println("reverse geodcode fail: \(error.localizedDescription)")
                addressInfo = "地址信息无法解析"
            }
            
            var p:CLPlacemark?
            let pm = placemarks as [CLPlacemark]
            if (pm.count > 0)
            {
                p = placemarks[0] as? CLPlacemark
                //self.locationInfoLabel?.text = p?.addressDictionary["State"] as? NSString
                
//                println(p?.addressDictionary["FormattedAddressLines"])
                let address: NSArray! = p?.addressDictionary["FormattedAddressLines"] as NSArray
//                println("addressArray ====================== \(address)")
                //self.locationAddress = address.pObjectAtIndex(0) as? NSString
                addressInfo = address.pObjectAtIndex(0) as? NSString
                //println("定位城市 \(self.cityName!) \(self.locationAddress!)")
            }
            else
            {
                addressInfo = "地址信息无法解析"
                println("No Placemarks!")
            }})
    }
    
    func calculateDistance(point:CLLocation, log:NSString, lat:NSString ) ->NSString
    {
        var distance:NSString
        var toPoint = CLLocation(latitude: lat.doubleValue, longitude: log.doubleValue)
        //var metre = CLLocationDistance(distance(point, toPoint))
        distance = "\(toPoint.distanceFromLocation(point))"
        return distance
    }
}

//下线详情客户列表 MYP add
class HWBrokerCumModel: NSObject
{
    var clientInfoID:NSString?
    var clientName:NSString?
    var clientPhone:NSString?
    var clientIntention:NSString?
    var houseName:NSString?
    var lastChangeTime:NSString?
    var status:NSString?
    
    var clientType:NSString = ""
    
    var intentionArea:NSString?//不显示
    var intentionHousePrice:NSString?
    var intentionHouseSize:NSString?
    var intentionHouseType:NSString?
    var intentionType:NSString?
    
    //合作客户
    var price:NSString = ""
    var roomCount:NSString?
    var villageName:NSString?
    var area:NSString = ""
    
    func fetchData(dic:NSDictionary)
    {
        clientInfoID = dic.stringObjectForKey("clientInfoId")
        clientName = dic.stringObjectForKey("clientName")
        clientPhone = dic.stringObjectForKey("clientPhone")
        clientIntention = dic.stringObjectForKey("clientIntention")
        houseName = dic.stringObjectForKey("houseName")
        status = dic.stringObjectForKey("status")
        var str =  dic.stringObjectForKey("lastChangeTime")
        lastChangeTime = Utility .getTimeFormattWithTimeStamp(str)
        
        clientType = dic.stringObjectForKey("clientType")
        println("客户类型＝＝＝＝＝＝＝＝＝＝ \(clientType)")
        if clientType.isEqualToString("合作")
        {
            price = dic.stringObjectForKey("price")
            roomCount = dic.stringObjectForKey("roomCount")
            villageName = dic.stringObjectForKey("villageName")
            area = dic .stringObjectForKey("area")
            
            intentionArea = dic.stringObjectForKey("")
            intentionHousePrice = dic.stringObjectForKey("")
            intentionHouseSize = dic.stringObjectForKey("")
            intentionHouseType = dic.stringObjectForKey("")
            intentionType = dic.stringObjectForKey("")
            
            if roomCount == "0"
            {
                self.roomCount = " | 不限"
            }
            else if roomCount == "1"
            {
                self.roomCount = " | 一室"
            }
            else if roomCount == "2"
            {
                self.roomCount = " | 二室"
            }
            else if roomCount == "3"
            {
                self.roomCount = " | 三室"
            }
            else if roomCount == "4"
            {
                self.roomCount = " | 四室"
            }
            else if roomCount == "5"
            {
                self.roomCount = " | 五室以上"
            }

            if !price.isEqualToString("")
            {
                var str = Utility .stringFrom(price)
                price = " | \(str)"
            }
            
            if !area.isEqualToString("")
            {
                area = " | \(area)㎡"
            }
            
            clientIntention = "\(villageName!)\(roomCount!)\(area)\(price)"
        }
        else
        {
            intentionArea = dic.stringObjectForKey("intentionArea")
            intentionHousePrice = dic.stringObjectForKey("intentionHousePrice")
            intentionHouseSize = dic.stringObjectForKey("intentionHouseSize")
            intentionHouseType = dic.stringObjectForKey("intentionHouseType")
            intentionType = dic.stringObjectForKey("intentionType")
            
            price = dic.stringObjectForKey("")
            roomCount = dic.stringObjectForKey("")
            villageName = dic.stringObjectForKey("")
            area = dic .stringObjectForKey("")
            
            //不显示
            if intentionArea == ""
            {
                intentionArea = "不限"
            }
            
            if intentionType == "1"
            {
                self.intentionType = "住宅"
            }
            else if intentionType == "2"
            {
                self.intentionType = "商住"
            }
            else if intentionType == "3"
            {
                self.intentionType = "别墅"
            }
            else if intentionType == ""
            {
                self.intentionType = "住宅"
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

            
            if intentionHousePrice == ""
            {
                intentionHousePrice = " ｜ 0-不限"
            }
            else if intentionHousePrice == "0-2000"
            {
                intentionHousePrice = " ｜ 0-不限"
            }
            else
            {
                intentionHousePrice = " ｜ \(intentionHousePrice!)万"
            }
            
            
            if intentionHouseSize == ""
            {
                intentionHouseSize = " | 0-不限"
            }
            else if intentionHouseSize == "0-600"
            {
                intentionHouseSize = " | 0-不限"
            }
            else
            {
                intentionHouseSize = " | \(intentionHouseSize!)㎡"
            }

            clientIntention = "\(intentionType!)\(intentionHouseType!)\(intentionHousePrice!)\(intentionHouseSize!)"
        }
    }
}