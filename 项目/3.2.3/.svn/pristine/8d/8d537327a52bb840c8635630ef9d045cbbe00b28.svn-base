//
//  HWMessageDialogModel.swift
//  Partner-Swift
//
//  Created by caijingpeng.haowu on 15/3/4.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWMessageDialogModel: NSObject {
    /*
    "messageId":"" --消息ID
    "brokerId":""  --经纪人ID
    "picKey":""    --头像
    "publisher":"" --发布人
    "publishTime":"" --时间[yyyy-MM-dd HH:mm:ss]
    "title":""   --标题[仅限集结号]
    "content":"" --消息内容
    "msgType":"" 消息类型[hi,admin,system]
    "reply":""  --0发布，1回复(默认0)
    // 问题
    "latitude": ""
    "longitude": ""
    var photoKey: NSString = ""
*/
    
    var messageId: NSString = ""
    var brokerId: NSString = ""
    var picKey: NSString = ""
    var publisher: NSString = ""
    var publishTime: NSString = ""
    var title: NSString = ""
    var content: NSString = ""
    var msgType: NSString = ""
    var reply: NSString = ""
    var photoKey: NSString = ""
    var latitude: NSString = ""
    var longitude: NSString = ""
    //新加
    var brokerPhone: NSString = ""
    var newPic: NSString = ""
    var read: NSString = ""
    var source: NSString = ""
    
    init(messageInfo: NSDictionary)
    {
        super.init()
        
        self.messageId = messageInfo.stringObjectForKey("messageId")
        self.brokerId = messageInfo.stringObjectForKey("brokerId")
        self.picKey = messageInfo.stringObjectForKey("picKey")
        self.publisher = messageInfo.stringObjectForKey("publisher")
        self.publishTime = messageInfo.stringObjectForKey("publishTime")
        self.title = messageInfo.stringObjectForKey("title")
        self.content = messageInfo.stringObjectForKey("content")
        self.msgType = messageInfo.stringObjectForKey("msgType")
        self.reply = messageInfo.stringObjectForKey("reply")
        self.latitude = messageInfo.stringObjectForKey("latitude")
        self.longitude = messageInfo.stringObjectForKey("longitude")
        self.photoKey = messageInfo.stringObjectForKey("photoKey")
        
        self.brokerPhone = messageInfo.stringObjectForKey("brokerPhone")
        self.newPic = messageInfo.stringObjectForKey("newPic")
        self.read = messageInfo.stringObjectForKey("read")
        self.source = messageInfo.stringObjectForKey("source")
    }
}
