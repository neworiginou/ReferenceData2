//
//  HWUserLogin.swift
//  Partner-Swift
//
//  Created by caijingpeng.haowu on 15/2/11.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：用户信息单例 用户保存用户信息
//
//  修改记录：
//      姓名         日期               修改内容
//     蔡景鹏     2015-02-11           创建文件


import Foundation

/*

brokerName = "<null>";
brokerPicKey = "<null>";
brokerTel = "<null>";
brokerType = "<null>";
cityId = "<null>";
cityName = "<null>";
identitys =  (
{
code = 1002;
identity = "\U673a\U6784\U7ba1\U7406\U5458";
token = "9-7";
            }
        );
        orgId = 9;
        orgName =
    };
    detail = "\U8bf7\U6c42\U6570\U636e\U6210\U529f!";
    key = F816FA938E1C1E318B69823D0C989D
*/
@objc class HWUserLogin: NSObject {
    
    var key = ""
    var cityId = ""
    var adminId = ""
    var adminName = ""
    var adminTel = ""
    var brokerGender = ""
    var brokerId = ""
    var brokerName = ""
    var brokerPicKey = ""
    var brokerStoreId = ""
    var brokerStoreName = ""
    var brokerTel = ""
    var cityName = ""
    var code = ""
    var identity = ""
    var token = ""
    var orgId = ""
    var orgName = ""
    var brokerType = ""
    var cities : NSMutableArray = []
    var areas:NSArray = []
    var signHouseInfoArr:NSMutableArray = [] //标签，满五年。。。。
    var identitys = ""               //身份标识
    
    //MYP add v3.2新增出参
    var orgCityName:String = ""
    /**
    *	@brief	单例 初始化方法
    *
    *	@param 	 nil
    *
    *	@return
    */
    
    class func currentUserLogin() -> HWUserLogin{
        struct YRSingleton{
            static var predicate: dispatch_once_t = 0
            static var instance: HWUserLogin? = nil
        }
        dispatch_once(&YRSingleton.predicate, {
            YRSingleton.instance = HWUserLogin()
            }
        )
        return YRSingleton.instance!
    }
        
    func initUserLogin(dic:NSDictionary)
    {
        self.cityId = dic.stringObjectForKey("cityId")
        self.key = dic.stringObjectForKey("key")
        self.adminId = dic.stringObjectForKey("adminId")
        self.adminName = dic.stringObjectForKey("adminName")
        self.adminTel = dic.stringObjectForKey("adminTel")
        self.brokerGender = dic.stringObjectForKey("brokerGender")
        self.brokerId = dic.stringObjectForKey("brokerId")
        self.brokerName = dic.stringObjectForKey("brokerName")
        self.brokerPicKey = dic.stringObjectForKey("brokerPicKey")
        self.brokerStoreId = dic.stringObjectForKey("brokerStoreId")
        self.brokerStoreName = dic.stringObjectForKey("brokerStoreName")
        self.brokerTel = dic.stringObjectForKey("brokerTel")
        self.cityName = dic.stringObjectForKey("cityName")
        self.brokerType = dic.stringObjectForKey("brokerType")
        let dictArr = dic.arrayObjectForKey("identitys") as NSArray
        if(dictArr.count == 1)
        {
            self.identitys = "1"
        }
        if (dictArr.count == 2)
        {
            self.identitys = "2"
        }
        var dataDic: NSDictionary? = dictArr.pObjectAtIndex(0) as? NSDictionary
        if (dataDic != nil)
        {
            self.token = dataDic!.stringObjectForKey("token")
            self.code = dataDic!.stringObjectForKey("code")
            self.identity = dataDic!.stringObjectForKey("identity")
        }
        self.orgName = dic.stringObjectForKey("orgName")
        self.orgId = dic.stringObjectForKey("orgId")
        self.orgCityName = dic.stringObjectForKey("orgCityName")
    }
    
    /**
    *	@brief	加载用户数据
    *
    *	@param  userInfo: NSDictionary      用户数据
    *
    *	@return
    */
    
//    func loadUserInfo(userInfo: NSDictionary) -> Void
//    {
////        self.nickName = userInfo.stringObjectForKey("nickName")
////        self.password = userInfo.stringObjectForKey("password")
////        self.key = userInfo.stringObjectForKey("key")
////        self.headPicKey = userInfo.stringObjectForKey("headPicKey")
//    }
    
    /**
    *	@brief	登出
    *
    *	@param  
    *
    *	@return
    */
    
    func logout() -> Void
    {
        APService.setTags(NSSet(object: ""), alias: "", callbackSelector: nil, object: nil)
        HWCoreDataManager.clearUserInfo()
        self.cityId = ""
        self.key = ""
        self.adminId = ""
        self.adminName = ""
        self.adminTel = ""
        self.brokerGender = ""
        self.brokerId = ""
        self.brokerName = ""
        self.brokerPicKey = ""
        self.brokerStoreId = ""
        self.brokerStoreName = ""
        self.brokerTel = ""
        self.cityName = ""
        self.brokerType = ""
        self.token = ""
        self.code = ""
        self.identity = ""
        self.orgName = ""
        self.orgId = ""
    }
}

