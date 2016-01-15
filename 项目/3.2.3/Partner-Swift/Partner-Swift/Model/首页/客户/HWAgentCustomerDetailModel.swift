//
//  HWAgentCustomerDetailModel.swift
//  Partner-Swift
//
//  Created by wuxiaohong on 15/2/26.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWAgentCustomerDetailModel: NSObject
{
    var hasIntention: NSString? //0无，1有
    var clientInfoId: NSString? //经纪人客户ID
    var clientName: NSString?//客户姓名
    var clientPhone: NSString?// 客户电话
    var clientSex:NSString?//客户性别
    var clientSourceWay: NSString?//客户来源
    var clientRange: NSString?//客户等级
    var clientIntention: NSString?//客户意向（文本）
    var intentionPurpose: NSString?//意向目的（标签）（文本,多个以单竖线分隔
    var intentionType:NSString! = "" //类型
    var intentionHouseType:NSString! = ""//户型
    var intentionArea:NSString! = ""//区域
    var intentionHousePrice:NSString! = ""//价格
    var intentionHouseSize:NSString! = ""//面积
    var hasRecommendHouse: NSString?//0无，1有
    var robedProtectDays: NSString! //被抢到的剩余保护天数(默认为-1,-1为无保护期，0为过保护期，大于0为剩余保护期)
    var houseList: NSArray? //新房，二手房的内容
    var houseTypeList:NSMutableArray = NSMutableArray()
    var buyHousepurpose: HWHousePurposeModel!
    var scheduleList: NSArray?//新房，二手房列表
    var priviledgeArry:NSArray!//优惠劵列表
    var protectStatus:NSString?
    var isRental:NSString!
    var phpImUrl:NSString!
    var messageId:String! = ""
    var messageSource:String! = ""
    var selectedStr:String! = "0"
    var guestSourceWay:NSString!
    var clientSources:NSString!
    var remarkStr:String = ""
    
    override init()
    {
        super.init()
      
        houseList = NSArray();
        houseTypeList = NSMutableArray();
        priviledgeArry = NSArray();
        
    }
    init(dic:NSDictionary)
    {
        self.buyHousepurpose = HWHousePurposeModel();
        self.hasIntention = dic .stringObjectForKey("hasIntention")
        self.clientInfoId = dic .stringObjectForKey("clientInfoId")
        self.clientName = dic .stringObjectForKey("clientName")
        self.clientPhone = dic .stringObjectForKey("clientPhone")
        self.clientSourceWay = dic .stringObjectForKey("clientSourceWay")
        self.clientIntention = dic .stringObjectForKey("clientIntention")
        self.intentionArea = dic .stringObjectForKey("intentionArea")
        self.isRental = dic .stringObjectForKey("isRental")
        self.phpImUrl = dic .stringObjectForKey("phpImUrl")
        self.clientRange = dic.stringObjectForKey("clientLevel");
        self.remarkStr = dic.stringObjectForKey("remark");
        if dic .stringObjectForKey("intentionType") == "1"
        {
            self.intentionType = "住宅"
        }
        if dic .stringObjectForKey("intentionType") == "2"
        {
            self.intentionType = "商住"
        }
        if dic .stringObjectForKey("intentionType") == "3"
        {
            self.intentionType = "别墅"
        }
        else
        {
            self.intentionType = ""
        }
        self.clientSex = dic .stringObjectForKey("clientSex")
        if dic.stringObjectForKey("intentionHousePrice") == "100-2000"
        {
            self.intentionHousePrice = "100-不限"
        }
        else if dic.stringObjectForKey("intentionHousePrice") == "150-2000"
        {
            self.intentionHousePrice = "150-不限"

        }
        else if dic.stringObjectForKey("intentionHousePrice") == "200-2000"
        {
            self.intentionHousePrice = "200-不限"
            
        }
        else if dic.stringObjectForKey("intentionHousePrice") == "300-2000"
        {
            self.intentionHousePrice = "300-不限"
            
        }
        else if dic.stringObjectForKey("intentionHousePrice") == "500-2000"
        {
            self.intentionHousePrice = "500-不限"
            
        }
        else if dic.stringObjectForKey("intentionHousePrice") == "1000-2000"
        {
            self.intentionHousePrice = "1000-不限"
            
        }
       else if dic.stringObjectForKey("intentionHousePrice") == "0-2000"
        {
            self.intentionHousePrice = "0-不限"
        }
        else if dic.stringObjectForKey("intentionHousePrice").length == 0
        {
            self.intentionHousePrice = "0-不限"
        }

         else
        {
            self.intentionHousePrice = dic .stringObjectForKey("intentionHousePrice")
        }
       // self.intentionHousePrice.stringByReplacingOccurrencesOfString("-", withString: "万-");
        self.intentionHousePrice = self.intentionHousePrice .stringByReplacingOccurrencesOfString("-", withString: "万-")
       // self.intentionHousePrice = dic .stringObjectForKey("intentionHousePrice")
        self.intentionType = dic .stringObjectForKey("intentionType")
        if dic .stringObjectForKey("intentionHouseSize") == "50-600"
        {
            self.intentionHouseSize = "50-不限"
        }
        else if dic .stringObjectForKey("intentionHouseSize") == "70-600"
        {
            self.intentionHouseSize = "70-不限"
        }
        else if dic .stringObjectForKey("intentionHouseSize") == "90-600"
        {
            self.intentionHouseSize = "90-不限"
        }
        else if dic .stringObjectForKey("intentionHouseSize") == "110-600"
        {
            self.intentionHouseSize = "110-不限"
        }
       else if dic .stringObjectForKey("intentionHouseSize") == "130-600"
        {
            self.intentionHouseSize = "130-不限"
        }
       else if dic .stringObjectForKey("intentionHouseSize") == "150-600"
        {
            self.intentionHouseSize = "150-不限"
        }
       else if dic .stringObjectForKey("intentionHouseSize") == "200-600"
        {
            self.intentionHouseSize = "200-不限"
        }
        else if dic .stringObjectForKey("intentionHouseSize") == "300-600"
        {
            self.intentionHouseSize = "300-不限"
        }
        else if dic .stringObjectForKey("intentionHouseSize") == "0-600"
        {
            self.intentionHouseSize = "0-不限"
        }
        else if dic .stringObjectForKey("intentionHouseSize").length == 0
        {
            self.intentionHouseSize = "0-不限"
        }
        else
        {
           self.intentionHouseSize = dic .stringObjectForKey("intentionHouseSize")

        }
      self.intentionHouseSize =  self.intentionHouseSize.stringByReplacingOccurrencesOfString("-", withString: "㎡-");
     // self.intentionHousePrice.stringByReplacingOccurrencesOfString("-", withString: "㎡-", options: nil, range:nil)
        if dic .stringObjectForKey("intentionHouseType") == "0"
        {
            self.intentionHouseType = "不限"
        }
        if dic .stringObjectForKey("intentionHouseType") == "1"
        {
            self.intentionHouseType = "一室"
        }
        if dic .stringObjectForKey("intentionHouseType") == "2"
        {
            self.intentionHouseType = "二室"
        }
        if dic .stringObjectForKey("intentionHouseType") == "3"
        {
            self.intentionHouseType = "三室"
        }
        if dic .stringObjectForKey("intentionHouseType") == "4"
        {
            self.intentionHouseType = "四室"
        }
        if dic .stringObjectForKey("intentionHouseType") == "5"
        {
            self.intentionHouseType = "五室以上"
        }

        self.intentionPurpose =  dic .stringObjectForKey("intentionPurpose");
        self.hasRecommendHouse = dic .stringObjectForKey("hasRecommendHouse")
        self.robedProtectDays = dic .stringObjectForKey("robedProtectDays")
        self.houseList = dic .arrayObjectForKey("houseList")
        self.priviledgeArry = dic.arrayObjectForKey("clientCoupons");
        //self.priviledgeArry = NSArray(objects: "1","2","3")
        self.scheduleList = dic .arrayObjectForKey("scheduleList")
        self.protectStatus = dic .stringObjectForKey("protectStatus")
        self.messageId = dic .stringObjectForKey("messageId")
        self.messageSource = dic .stringObjectForKey("messageSource")
        self.guestSourceWay = dic.stringObjectForKey("guestSourceWay")
        
        if dic .stringObjectForKey("clientSources") == "networkPort"
        {
            self.clientSources = "网络端口"
        }
        else if dic .stringObjectForKey("clientSources") == "callGuest"
        {
           self.clientSources = "CALL客"
        }
        else  if dic .stringObjectForKey("clientSources") == "tour"
        {
            self.clientSources = "巡展"
        }
        else if dic .stringObjectForKey("clientSources") == "distributeLeaflets"
        {
            self.clientSources = "派单"
        }
        else  if dic .stringObjectForKey("clientSources") == "comeToClient"
        {
            self.clientSources = "上门客户"
        }
        else if dic .stringObjectForKey("clientSources") == "exhibitions"
        {
            self.clientSources = "房展会"
        }
        else if dic .stringObjectForKey("clientSources") == "recommend"
        {
            self.clientSources = "推荐"
        }
        else if dic .stringObjectForKey("clientSources") == "others"
        {
            self.clientSources = "其他"
        }

        
    }
}






