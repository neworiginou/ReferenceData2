//
//  HWRedPaperModel.swift
//  Partner-Swift
//
//  Created by gusheng on 15/5/21.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWRedPaperModel: NSObject {
    var type:String!//是否过期
    var money:String!
    var time:String!
    var title:String!
    var redId:String!
    
    init(dic:NSDictionary)
    {
        type = dic.stringObjectForKey("status")
        money = dic.stringObjectForKey("rewardMoney")
        time = dic.stringObjectForKey("rewardTime")
        title = dic.stringObjectForKey("activityName")
        redId = dic.stringObjectForKey("redId");
    }

}
