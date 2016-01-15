//
//  HWHouseListModel.swift
//  Partner-Swift
//
//  Created by wuxiaohong on 15/3/5.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWHouseListModel: NSObject {
    var time:NSString?//时间
    var content:NSString?//内容
    override init()
    {
        super.init()
    }
    init(dic:NSDictionary)
    {
        super.init()
        var str = dic .stringObjectForKey("wakeTime")
        self.time  =  Utility .getTimeWithTimestamp(str, dateFormatStr: "yyyy-MM-dd HH:mm:ss")
        self.content = dic .stringObjectForKey("content")
    }
    
}
