//
//  HWCityClass.swift
//  Partner-Swift
//
//  Created by wuxiaohong on 15/2/27.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWCityClass: NSObject
{
    var cityId:NSString?
    var cityName:NSString?
    var cityPinyin:NSString?
    var proviceId:NSString?
    var hotStr:NSString?
    var type:NSString?
    var arr:NSArray?
    var areas:NSMutableArray?
    
    init(dic:NSDictionary)
    {
       cityId = dic .stringObjectForKey("id")
       cityName = dic .stringObjectForKey("city_name")
       cityPinyin = dic .stringObjectForKey("city_quanpin")
        proviceId = dic .stringObjectForKey("province_id")
        hotStr = dic .stringObjectForKey("hot")
        type = dic .stringObjectForKey("type")
        arr = dic .arrayObjectForKey("areas")
        areas = []
        for var i = 0; i<arr?.count;i++
        {
           var dic  = arr?.objectAtIndex(i) as NSDictionary
            var model = HWSearchAreaModel(area:dic)
            areas?.addObject(model)
        }
        
    }
    
    
   
}
