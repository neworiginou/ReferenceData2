//
//  HWMainMsgListModel.swift
//  Partner-Swift
//
//  Created by hw500029 on 15/8/15.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
// v3.2.3消息分类列表 系统、管理员、Hi、租售中心、优惠券

import UIKit

class HWMainMsgListModel: NSObject {
    
    var content = ""
    var source = ""
    var read = ""
    var type = ""
    var publishTime = ""
    
    init(msgInfoDic:NSDictionary)
    {
        content = msgInfoDic.stringObjectForKey("content")
        source = msgInfoDic.stringObjectForKey("source")
        read = msgInfoDic.stringObjectForKey("read")
        type = msgInfoDic.stringObjectForKey("type")
        publishTime = msgInfoDic.stringObjectForKey("publishTime")
    }
}
