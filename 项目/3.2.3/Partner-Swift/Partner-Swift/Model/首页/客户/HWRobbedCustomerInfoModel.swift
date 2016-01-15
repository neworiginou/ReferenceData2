//
//  HWRobbedCustomerInfoModel.swift
//  Partner-Swift
//
//  Created by gusheng on 15/3/5.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWRobbedCustomerInfoModel: NSObject
{
   /*
    {
    "detail": "请求数据成功!",
    "status": "1",
    "data": {
    "clientPoolId":"" -客户池id
    "intentionHouseSize":"" -意向面积,
    "intentionHousePrice":"" -意向价位,
    "intentionHouseType":"" -户型
    "integral":"" -应扣积分
    "countdown":"" -解锁倒计时
    }];
    }
    }
    */
    var clientPoolId:NSString! = "";
    var recordId:NSString! = "";
    var intentionHouseSize:NSString! = "";
    var intentionHousePrice:NSString! = "";
    var intentionHouseType:NSString! = "";
    var integral:NSString! = "";
    var countdown:NSString! = "";
    var isLimit:NSString! = "";
    init(dic:NSDictionary)
    {
        super.init();
        self.clientPoolId = dic.stringObjectForKey("clientPoolId");
        self.recordId = dic.stringObjectForKey("clientRobRecordId");
        self.intentionHouseSize = dic.stringObjectForKey("intentionHouseSize");
        self.intentionHousePrice = dic.stringObjectForKey("intentionHousePrice");
        self.intentionHouseType = dic.stringObjectForKey("intentionHouseType");
        self.integral = dic.stringObjectForKey("integral");
        self.countdown = dic.stringObjectForKey("countdown");
        self.isLimit = dic.stringObjectForKey("isLimit");
    }
    override init()
    {
        
    }
}
