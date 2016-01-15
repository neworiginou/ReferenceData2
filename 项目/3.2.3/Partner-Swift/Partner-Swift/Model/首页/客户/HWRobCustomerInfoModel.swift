//
//  HWRobCustomerInfoModel.swift
//  Partner-Swift
//
//  Created by gusheng on 15/3/5.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWRobCustomerInfoModel: NSObject
{
    /*
    {
    "detail": "请求数据成功!",
    "status": "1",
    "data": {
    "hisRobNum":"" -历史被抢数
    "myRobNum":"" -我抢到数
    "releaseNum":"" -今日释放数（根据经纪人城市id筛选）
    "remainingNum":"" -剩余数
    }];
    }
    }
    */
    var hisRobNum:String! = "";
    var myRobNum:String! = "";
    var releaseNum:String! = "";
    var remainingNum:String! = "";
    init(dic:NSDictionary)
    {
        self.hisRobNum = dic.stringObjectForKey("hisRobNum");
        self.myRobNum = dic.stringObjectForKey("myRobNum");
        self.releaseNum = dic.stringObjectForKey("releaseNum");
        self.remainingNum = dic.stringObjectForKey("remainingNum");
    }
    override init()
    {
        
    }
   
}
