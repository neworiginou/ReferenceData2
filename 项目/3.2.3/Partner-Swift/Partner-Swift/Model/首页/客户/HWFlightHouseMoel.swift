//
//  HWFlightHouseMoel.swift
//  Partner-Swift
//
//  Created by gusheng on 15/3/6.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWFlightHouseMoel: HWSelectCustomerModel
{
    /*
    {
    "detail": "",
    "status": "",
    "data": {
    "content": [
    {
    "houseId":"",       --房源ID
    "houseName":"",     --房源名称
    "houseAddress":"",  --房源位置([区域-板块])
    "housesStatus":""   --状态（0未报备，1已报备）
    },
    { },
    { }
    ],
    "firstPage": "",
    "lastPage": "",
    "totalPages": "",
    "numberOfElements": "",
    "totalElements": "",
    "sort": "",
    "size": "",
    "number": ""
    }
    }
    */
    var houseId:NSString! = "";
    var houseName:NSString! = "";
    var houseAddress:NSString! = "";
    var housesStatus:NSString!  = "";
    var isSelected:NSString!  = "0";
    init(dic:NSDictionary)
    {
        self.houseId = dic.stringObjectForKey("houseId");
        self.houseName = dic.stringObjectForKey("houseName");
        self.houseAddress = dic.stringObjectForKey("houseAddress");
        self.housesStatus = dic.stringObjectForKey("housesStatus");
    }
    override init()
    {
        
    }
   
}
