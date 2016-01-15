//
//  HWFilterClasses.swift
//  Partner-Swift
//
//  Created by zhangxun on 15/3/3.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWSearchAreaModel: NSObject {
    var area_id : NSString?
    var city_id : NSString?
    var area_name : NSString?
    var area_order : NSString?
    var plates : NSMutableArray?
    init(area : NSDictionary) {
        super.init()
        self.area_id = area.stringObjectForKey("id")
        self.city_id = area.stringObjectForKey("city_id")
        self.area_name = area.stringObjectForKey("area_name")
        self.area_order = area.stringObjectForKey("area_order")
        self.plates = NSMutableArray()
        var arr = area.arrayObjectForKey("plates")
        for (var i = 0; i < arr.count; i++)
        {
            var model = HWSearchPlateModel(plate: arr[i] as NSDictionary)
            self.plates?.addObject(model)
        }
    }
}

class HWAreaClass: NSObject {
    var villageIdStr : NSString?
    var villageNameStr : NSString?
    var villageAddressStr : NSString?
    var distanceStr : NSString?
    var flag : Bool?
    init(dic : NSDictionary) {
        super.init()
        self.villageIdStr = dic.stringObjectForKey("villageId")
        self.villageNameStr = dic.stringObjectForKey("villageName")
        self.villageAddressStr = dic.stringObjectForKey("villageAddress")
        self.distanceStr = dic.stringObjectForKey("distance")
        flag = false
    }
}

//class HWCityClass : NSObject {
//    
//    var cityId : NSString?
//    var cityName : NSString?
//    var cityPinyin : NSString?
//    var hotStr : NSString?
//    var proviceId : NSString?
//    var type : NSString?
//    var areas : NSMutableArray?
//    init(dic : NSDictionary) {
//        super.init()
//        
//        self.cityId = dic.stringObjectForKey("id")
//        self.cityName = dic.stringObjectForKey("city_name")
//        self.cityPinyin = dic.stringObjectForKey("city_quanpin")
//        self.proviceId = dic.stringObjectForKey("province_id")
//        self.hotStr = dic.stringObjectForKey("hot")
//        self.type = dic.stringObjectForKey("type")
//        var arr = dic.arrayObjectForKey("areas")
//        for (var i = 0; i < arr.count; i++)
//        {
//            var model = HWSearchAreaModel(area: arr[i] as NSDictionary)
//            self.areas?.addObject(model)
//        }
//    }
//}

class HWSearchPlateModel : NSObject {
    
    
    var plate_id : NSString?
    var area_id : NSString?
    var plate_order : NSString?
    var name : NSString?
    init(plate : NSDictionary)
    {
        super.init()
        self.plate_id = plate.stringObjectForKey("id")
        self.area_id = plate.stringObjectForKey("area_id")
        self.name = plate.stringObjectForKey("name")
        self.plate_order = plate.stringObjectForKey("plate_order")
    }
    
    
    
}
