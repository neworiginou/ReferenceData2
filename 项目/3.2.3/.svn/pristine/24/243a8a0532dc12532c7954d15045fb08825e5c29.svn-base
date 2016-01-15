//
//  HWDisCountModel.swift
//  Partner-Swift
//
//  Created by hw500029 on 15/5/25.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import Foundation
//可抢优惠劵
class HWDisCountListModel :NSObject{
    /*
    imageId -图片id
    couponTitle -优惠券标题
    couponMoney -优惠券金额
    activityTime -优惠券有效期
    residueNum -优惠券剩余数
    */
    var brokerId:String = ""
    var couponId = ""
    var imageId:String = ""
    var couponTitle:String = ""
    var couponMoney:String = ""
    var validityTime:String = ""
    var residueNum:String = ""
    var webUrl:String = ""
    var couponAttriNum:NSMutableAttributedString!
    
    func fetchData(dic:NSDictionary)
    {
        couponId = dic.stringObjectForKey("id")
        imageId = dic.stringObjectForKey("imagePath")
        couponTitle = dic.stringObjectForKey("couponTitle")
        couponMoney = dic.stringObjectForKey("couponMoney")
        brokerId = dic.stringObjectForKey("brokerId")
        if couponMoney == ""
        {
            couponMoney = "0元"
        }
        else
        {
            couponMoney = couponMoney + "元"
        }

        validityTime = "有效期：" + dic.stringObjectForKey("validityTime")
        residueNum = dic.stringObjectForKey("residueNum")
        webUrl = dic.stringObjectForKey("detailPath")
        if residueNum.toInt() >= 100
        {
            residueNum = ""
        }
        else if residueNum == ""
        {
            residueNum = ""
        }
        else
        {
            residueNum = "剩余" + residueNum + "张"
        }
        
        couponAttriNum = NSMutableAttributedString(string:("优惠：" + couponMoney + "团购费"))
        couponAttriNum.addAttributes([NSForegroundColorAttributeName: CD_MainColor], range: NSMakeRange(3, countElements(couponMoney)))
    }
}

//我的优惠劵
class HWMyDisCountModel: NSObject {
    
    //显示相关
    var disCountID:String = ""
    var picKey:String = ""
    var couponNum:String = ""
    var title:String = ""
    var couponMoney:String = ""
    var status:String = ""
    var validityTime:String = ""
    var couponAttriNum:NSMutableAttributedString!
    
    //分享相关
    var couponBrokerId:String = ""
    var content:String = ""
    var couponShareUrl:String = ""
    
    var couponDetailUrl = ""
    /*
    "id": 74916845,
    "pic": "7558944", 图片ID
    "couponNum": 1432012579643, 编号
    "title": "优惠券测试123", 标题
    "couponMoney": 12000, 金额
    "status": "可使用", 状态
    "validityTime": "2015/5/6-2015/5/31" 有效期
    */
    
    func fetchData(dic:NSDictionary)
    {
        disCountID = dic.stringObjectForKey("id")
        couponNum = dic.stringObjectForKey("couponNum")
        title = dic.stringObjectForKey("title")
        couponMoney = dic.stringObjectForKey("couponMoney")
        if couponMoney == ""
        {
            couponMoney = "0元"
        }
        else
        {
            couponMoney = couponMoney + "元"
        }
        
        status = dic.stringObjectForKey("status")
        validityTime = "有效期：" + dic.stringObjectForKey("validityTime")
        
        picKey = dic.stringObjectForKey("pic")
        content = dic.stringObjectForKey("content")
        couponShareUrl = dic.stringObjectForKey("couponShareUrl")
        couponDetailUrl = dic.stringObjectForKey("couponDetailUrl")
        couponAttriNum = NSMutableAttributedString(string:("优惠：" + couponMoney + "团购费"))
        couponAttriNum.addAttributes([NSForegroundColorAttributeName: CD_MainColor], range: NSMakeRange(3, countElements(couponMoney)))
    }
}

class HWDisCountShareModel: NSObject {
    
    /*
    data =     {
    content = "Z24,\U9884\U7ea6\U5c31\U90012000.0000\U5143\Uff01\U6570\U91cf\U6709\U9650\Uff0c\U5148\U5230\U5148\U5f97\Uff01";
    couponEndtime = 1433606400000;
    couponId = 11471145689;
    couponMoney = 2000;
    couponNum = 1432548725659;
    couponShareUrl = "http://127.0.0.1:8080?couponBrokerId=11473212775";
    couponShortTitle = Z24;
    couponStarttime = 1432483200000;
    couponTitle = Z024;
    isLimit = 0;
    isRobed = 0;
    picUrl = "http://172.16.10.108:8080/hoss-web//hoss-web/hoss/sys/fileDownload/download.do?id=1157428196";
    };
    detail = "\U8bf7\U6c42\U6570\U636e\U6210\U529f!";
    status = 1;
    */
    
    var isRobed:String = ""//是否抢完
    var isLimit:String = ""//是否达到抢券上限
    var picUrl:String = ""
    
    var couponId:String = ""
    var couponShortTitle:String = ""//优惠券短标题
    var couponTitle:String = ""//优惠券标题
    var couponNum:String = ""
    var couponMoney:String = ""

    var couponShareUrl:String = ""//分享URL
    var content:String = ""
    
    var time:String = ""//期限
    
    func fetchData(dic:NSDictionary)
    {
        isRobed = dic.stringObjectForKey("isRobed")
        isLimit = dic.stringObjectForKey("isLimit")
        picUrl = dic.stringObjectForKey("picUrl")
        
        couponId = dic.stringObjectForKey("couponId")
        couponShortTitle = dic.stringObjectForKey("couponShortTitle")
        couponTitle = dic.stringObjectForKey("couponTitle")
        couponNum = dic.stringObjectForKey("couponNum")
        couponMoney = dic.stringObjectForKey("couponMoney")
        
        couponShareUrl = dic.stringObjectForKey("couponShareUrl")
        content = dic.stringObjectForKey("content")
        
        //var startTime:String = dic.stringObjectForKey("couponStarttime")
        //var endTime:String = dic.stringObjectForKey("couponEndtime")
        var startTime = Utility.getTimeWithTimestamp(dic.stringObjectForKey("couponStarttime"), dateFormatStr: "yyyy-MM-dd") as String
        var endTime = Utility.getTimeWithTimestamp(dic.stringObjectForKey("couponEndtime"), dateFormatStr: "yyyy-MM-dd") as String
        time = "有效期：" + startTime + "至" + endTime
    }
}