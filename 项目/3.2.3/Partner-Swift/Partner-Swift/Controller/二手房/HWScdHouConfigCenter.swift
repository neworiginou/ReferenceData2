//
//  HWScdHouConfigCenter.swift
//  Partner-Swift
//
//  Created by niedi on 15/3/16.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：二手房模块 后台配置的房屋：类型、标签、朝向、装修的可选类型的 存储单例
//
//  修改记录：
//      姓名         日期               修改内容
//      聂迪      2015-02-26           缓存及实现
//

import UIKit


//二手房调试标志 用于模拟数据或情况 聂迪添加 修改请告知本人
let DebugFlagForNieDi = false



class HWScdHouConfigCenter: NSObject
{
    
    //参数配置 
    /*类型 residence:住宅 villa:别墅 commercial:商住
    朝向 south:朝南 north:朝北 east:朝东 west:朝西 east_west:东西向 south_north:南北通透
    标签
    装修 workblank:毛坯 simple:简装修 refined:精装修 luxury:豪华装修*/
    var typeArr_E: NSArray! = ["residence", "villa", "commercial"]
    var typeArr_C: NSArray! = ["住宅", "别墅", "商住"]
    var towardArr_E: NSArray! = ["south", "north", "east", "west", "east_west", "south_north","southeast","northeast","southwest","northwest"]
    var towardArr_C: NSArray! = ["朝南", "朝北", "朝东", "朝西", "东西向", "南北通透","东南","东北","西南","西北"]
    var sign_E: NSArray! = ["five_year", "sole"]
    var sign_C: NSArray! = ["满5年", "唯一住房"]
    var decorateArr_E: NSArray! = ["workblank", "simple", "refined", "luxury"]
    var decorateArr_C: NSArray! = ["毛坯", "简装修", "精装修", "豪华装修"]
    
    /**
    *	@brief	单例 初始化方法
    *
    *	@param 	 nil
    *
    *	@return
    */
    
    class func defaultCenter() -> HWScdHouConfigCenter{
        struct YRSingleton{
            static var predicate: dispatch_once_t = 0
            static var instance: HWScdHouConfigCenter? = nil
        }
        dispatch_once(&YRSingleton.predicate, {
            YRSingleton.instance = HWScdHouConfigCenter()
            }
        )
        return YRSingleton.instance!
    }
    
    
    //MARK: 更新配置
    func updateConfig()
    {
        self.updateType()
        
        self.updateToward()
        
        self.updateSign()
        
        self.updatedecorate()
        
    }
    
    //MARK: 请求类型
    func updateType()
    {
        /*url:/sys/getParameters.do
        入参：parentId:父Id
        房屋类型：parentId=10001
        朝向：parentId=10005
        房屋标签：parentId=10012
        装修：parentId=10016
        */
        
        let manager = HWHttpRequestOperationManager.baseManager()
        var param = NSMutableDictionary()
        
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param.setPObject("10001", forKey: "parentId")
        
        manager.postHttpRequest(kScdHouConfig, parameters: param, queue: nil, success: { (responseObject) -> Void in
            
//            println("\(responseObject)")
            
            var dataArr: NSArray = responseObject.arrayObjectForKey("data")
            var tmpArr_E = NSMutableArray()
            var tmpArr_C = NSMutableArray()
            
            for var i = 0; i < dataArr.count; i++
            {
                var dict: NSDictionary = dataArr.pObjectAtIndex(i) as NSDictionary
                var E = dict.stringObjectForKey("code")
                var C = dict.stringObjectForKey("name")
                tmpArr_E.addObject(E)
                tmpArr_C.addObject(C)
            }
            
            self.typeArr_E = tmpArr_E
            self.typeArr_C = tmpArr_C
            
            NSUserDefaults.standardUserDefaults().setObject(self.typeArr_E, forKey: "typeArr_E")
            NSUserDefaults.standardUserDefaults().setObject(self.typeArr_C, forKey: "typeArr_C")
            NSUserDefaults.standardUserDefaults().synchronize()
            
            
            }) { (code, error) -> Void in
                
                if(NSUserDefaults.standardUserDefaults().objectForKey("typeArr_E") != nil)
                {
                    self.typeArr_E = NSUserDefaults.standardUserDefaults().objectForKey("typeArr_E") as NSArray
                }
                if(NSUserDefaults.standardUserDefaults().objectForKey("typeArr_C") != nil)
                {
                    self.typeArr_C = NSUserDefaults.standardUserDefaults().objectForKey("typeArr_C") as NSArray
                }
        }
    }
    
    //MARK: 请求朝向
    func updateToward()
    {
        /*url:/sys/getParameters.do
        入参：parentId:父Id
        房屋类型：parentId=10001
        朝向：parentId=10005
        房屋标签：parentId=10012
        装修：parentId=10016
        */
        
        let manager = HWHttpRequestOperationManager.baseManager()
        var param = NSMutableDictionary()
        
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param.setPObject("10005", forKey: "parentId")
        
        manager.postHttpRequest(kScdHouConfig, parameters: param, queue: nil, success: { (responseObject) -> Void in
            
//            println("\(responseObject)")
            
            var dataArr: NSArray = responseObject.arrayObjectForKey("data")
            var tmpArr_E = NSMutableArray()
            var tmpArr_C = NSMutableArray()
            
            for var i = 0; i < dataArr.count; i++
            {
                var dict: NSDictionary = dataArr.pObjectAtIndex(i) as NSDictionary
                var E = dict.stringObjectForKey("code")
                var C = dict.stringObjectForKey("name")
                tmpArr_E.addObject(E)
                tmpArr_C.addObject(C)
            }
            
            self.towardArr_E = tmpArr_E
            self.towardArr_C = tmpArr_C
            
            NSUserDefaults.standardUserDefaults().setObject(self.towardArr_E, forKey: "towardArr_E")
            NSUserDefaults.standardUserDefaults().setObject(self.towardArr_C, forKey: "towardArr_C")
            NSUserDefaults.standardUserDefaults().synchronize()
            
            }) { (code, error) -> Void in
                
                if(NSUserDefaults.standardUserDefaults().objectForKey("towardArr_E") != nil)
                {
                    self.towardArr_E = NSUserDefaults.standardUserDefaults().objectForKey("towardArr_E") as NSArray
                }
                if(NSUserDefaults.standardUserDefaults().objectForKey("towardArr_C") != nil)
                {
                    self.towardArr_C = NSUserDefaults.standardUserDefaults().objectForKey("towardArr_C") as NSArray
                }
        }
    }
    
    //MARK: 请求标签
    func updateSign()
    {
        /*url:/sys/getParameters.do
        入参：parentId:父Id
        房屋类型：parentId=10001
        朝向：parentId=10005
        房屋标签：parentId=10012
        装修：parentId=10016
        */
        
        let manager = HWHttpRequestOperationManager.baseManager()
        var param = NSMutableDictionary()
        
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param.setPObject("10012", forKey: "parentId")
        
        manager.postHttpRequest(kScdHouConfig, parameters: param, queue: nil, success: { (responseObject) -> Void in
            
//            println("\(responseObject)")
            
            var dataArr: NSArray = responseObject.arrayObjectForKey("data")
            var tmpArr_E = NSMutableArray()
            var tmpArr_C = NSMutableArray()
            
            for var i = 0; i < dataArr.count; i++
            {
                var dict: NSDictionary = dataArr.pObjectAtIndex(i) as NSDictionary
                var E = dict.stringObjectForKey("code")
                var C = dict.stringObjectForKey("name")
                tmpArr_E.addObject(E)
                tmpArr_C.addObject(C)
            }
            
            self.sign_E = tmpArr_E
            self.sign_C = tmpArr_C
            
            NSUserDefaults.standardUserDefaults().setObject(self.sign_E, forKey: "sign_E")
            NSUserDefaults.standardUserDefaults().setObject(self.sign_C, forKey: "sign_C")
            NSUserDefaults.standardUserDefaults().synchronize()
            
            }) { (code, error) -> Void in
                
                if(NSUserDefaults.standardUserDefaults().objectForKey("sign_E") != nil)
                {
                    self.sign_E = NSUserDefaults.standardUserDefaults().objectForKey("sign_E") as NSArray
                }
                if(NSUserDefaults.standardUserDefaults().objectForKey("sign_C") != nil)
                {
                    self.sign_C = NSUserDefaults.standardUserDefaults().objectForKey("sign_C") as NSArray
                }
        }
    }
    
    //MARK: 请求装修
    func updatedecorate()
    {
        /*url:/sys/getParameters.do
        入参：parentId:父Id
        房屋类型：parentId=10001
        朝向：parentId=10005
        房屋标签：parentId=10012
        装修：parentId=10016
        */
        
        let manager = HWHttpRequestOperationManager.baseManager()
        var param = NSMutableDictionary()
        
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param.setPObject("10016", forKey: "parentId")
        
        manager.postHttpRequest(kScdHouConfig, parameters: param, queue: nil, success: { (responseObject) -> Void in
            
//            println("\(responseObject)")
            
            var dataArr: NSArray = responseObject.arrayObjectForKey("data")
            var tmpArr_E = NSMutableArray()
            var tmpArr_C = NSMutableArray()
            
            for var i = 0; i < dataArr.count; i++
            {
                var dict: NSDictionary = dataArr.pObjectAtIndex(i) as NSDictionary
                var E = dict.stringObjectForKey("code")
                var C = dict.stringObjectForKey("name")
                tmpArr_E.addObject(E)
                tmpArr_C.addObject(C)
            }
            
            self.decorateArr_E = tmpArr_E
            self.decorateArr_C = tmpArr_C
            
            NSUserDefaults.standardUserDefaults().setObject(self.decorateArr_E, forKey: "decorateArr_E")
            NSUserDefaults.standardUserDefaults().setObject(self.decorateArr_C, forKey: "decorateArr_C")
            NSUserDefaults.standardUserDefaults().synchronize()
            
            }) { (code, error) -> Void in
                
                if(NSUserDefaults.standardUserDefaults().objectForKey("decorateArr_E") != nil)
                {
                    self.decorateArr_E = NSUserDefaults.standardUserDefaults().objectForKey("decorateArr_E") as NSArray
                }
                if(NSUserDefaults.standardUserDefaults().objectForKey("decorateArr_C") != nil)
                {
                    self.decorateArr_C = NSUserDefaults.standardUserDefaults().objectForKey("decorateArr_C") as NSArray
                }
        }
    }
    
}




