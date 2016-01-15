//
//  HWServiceCustomerModel.swift
//  Partner-Swift
//
//  Created by hw500027 on 15/2/4.
//  Copyright (c) 2015年 luxiaobo. All rights reserved.
//

import UIKit

class HWServiceCustomerModel: NSObject
{
    var brokerId : NSString!
    var chanceId : NSString!
    var chanceStatus : NSString!
    var chanceType : NSString!
    var chanceTypeId : NSString!
    var clientId : NSString!
    var loan : NSString!
    var modifyTime : NSString!
    var name : NSString!
    var productName : NSString!
    
    override init() {
        
    }
    
    init(dic:NSDictionary)
    {
        self.brokerId = dic.stringObjectForKey("brokerId")
        self.chanceId = dic.stringObjectForKey("chanceId")
        self.chanceStatus = dic.stringObjectForKey("chanceStatus")
        self.chanceType = dic.stringObjectForKey("chanceType")
        self.chanceTypeId = dic.stringObjectForKey("chanceTypeId")
        self.clientId = dic.stringObjectForKey("clientId")
        self.loan = dic.stringObjectForKey("loan")
        self.modifyTime = dic.stringObjectForKey("modifyTime")
        self.name = dic.stringObjectForKey("name")
        self.productName = dic.stringObjectForKey("productName")
    }
}
