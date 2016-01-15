//
//  HWMessageListModel.swift
//  Partner-Swift
//
//  Created by caijingpeng.haowu on 15/3/4.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWMessageListModel: NSObject {
   /*
    "messageId":"" --消息ID
    "readed":""      --是否已读【0未读，1已读】
    "picKey":""      --头像key
    "publisher":""   --发布人
    "publishTime":"" --发布时间
    "title":""       --标题
    "msgType":""     --消息类型[hi,admin,system]
    // 问题
    "latitude": ""
    "longitude": ""
    var photoKey: NSString = ""
    */
    
    var messageId: NSString = ""
    var readed: NSString = ""
    var picKey: NSString = ""
    var publisher: NSString = ""
    var publishTime: NSString = ""
    var title: NSString = ""
    var msgType: NSString = ""
    var photoKey: NSString = ""
    var latitude: NSString = ""
    var longitude: NSString = ""
    //新加
    var brokerId: NSString = ""
    var brokerPhone: NSString = ""
    var content: NSString = ""
    var newPic: NSString = ""
    var reply: NSString = ""
    var source: NSString = ""
    //MYP add
    var messageSource: NSString = ""
    var phpImUrl: NSString = ""
    //MYP add v3.2
    var webUrl: String = ""
    var couponId:String = ""
    
    init(messageInfo: NSDictionary)
    {
        super.init()
        
        self.messageId = messageInfo.stringObjectForKey("messageId")
        self.readed = messageInfo.stringObjectForKey("read")
        self.picKey = messageInfo.stringObjectForKey("picKey")
        self.publisher = messageInfo.stringObjectForKey("publisher")
        self.publishTime = messageInfo.stringObjectForKey("publishTime")
        self.title = messageInfo.stringObjectForKey("title")
        self.msgType = messageInfo.stringObjectForKey("msgType")
        self.latitude = messageInfo.stringObjectForKey("latitude")
        self.longitude = messageInfo.stringObjectForKey("longitude")
        self.photoKey = messageInfo.stringObjectForKey("photoKey")
        
        self.brokerId = messageInfo.stringObjectForKey("brokerId")
        self.brokerPhone = messageInfo.stringObjectForKey("brokerPhone")
        self.content = messageInfo.stringObjectForKey("content")
        self.newPic = messageInfo.stringObjectForKey("newPic")
        self.reply = messageInfo.stringObjectForKey("reply")
        self.source = messageInfo.stringObjectForKey("source")
        self.publisher = messageInfo .stringObjectForKey("publisher")
        //MYP add
        self.messageSource = messageInfo .stringObjectForKey("messageSource")
        self.phpImUrl = messageInfo.stringObjectForKey("phpImUrl")
        //MYP add 
        self.webUrl = messageInfo.stringObjectForKey("couponDetailUrl")
        self.couponId = messageId
    }
    
}
