//
//  HWCoreDataManager.swift
//  Partner-Swift
//
//  Created by caijingpeng.haowu on 15/2/11.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：数据库管理类  提供表的增删改查
//
//  修改记录：
//      姓名         日期               修改内容
//     蔡景鹏     2015-02-11           创建文件
//

import Foundation
import CoreData

class HWCoreDataManager: NSObject
{
    
/**
 *	@brief	保存coredata 操作
 *
 *	@param
 *
 *	@return	是否成功
 */
    class func saveContext(context: NSManagedObjectContext) -> Bool
    {
        let delegate = shareAppDelegate
        
//        let context = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.PrivateQueueConcurrencyType)
//        
//        context.parentContext = delegate.managedObjectContext
        
        context.performBlock { () -> Void in
            
            var error1: NSError?
            
            
            if context.save(&error1) == false
            {
//                println(error1)
            }
            
            delegate.managedObjectContext?.performBlock({ () -> Void in
            var error: NSError?
                if ((delegate.managedObjectContext?.save(&error)) == false)
                {
//                    println("error is \(error)")
                }
            })
        }
        
//        delegate.saveContext()
        
        return true
    }
    
    
/**
 *	@brief	删除entityName对应表内容
 *
 *	@param 	 	coreDataEntityName:操作的entityName
 *
 *	@return	N/A
 */
class func deleteOneEntityAllData(coreDataEntityName:String)

    {
        var error:NSError? = nil
        let coredataDelegate = shareAppDelegate
        
        let context = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.PrivateQueueConcurrencyType)
        
        context.parentContext = coredataDelegate.managedObjectContext
        
        var fReq: NSFetchRequest = NSFetchRequest(entityName: coreDataEntityName)
        var result: NSArray? = context.executeFetchRequest(fReq, error: &error)
        
        if (result == nil || error != nil)
        {
            return
        }
        
        for resultItem in result!
        {
            context.deleteObject(resultItem as NSManagedObject)
        }
        
        self.saveContext(context)
    }
    
    // MARK: User Table
    
/**
 *	@brief	保存用户信息
 *
 *	@param
 *
 *	@return
 */
    
    class func saveUserInfo() -> Bool
    {
        self.clearUserInfo()
        let delegate = shareAppDelegate
        
        let context = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.PrivateQueueConcurrencyType)
        
        context.parentContext = delegate.managedObjectContext
        
        var userLogin = HWUserLogin.currentUserLogin()
        let user: HWUser = NSEntityDescription.insertNewObjectForEntityForName("HWUser", inManagedObjectContext: context) as HWUser
        user.key = userLogin.key
        user.cityId = userLogin.cityId
        user.adminId = userLogin.adminId
        user.adminName = userLogin.adminName
        user.adminTel = userLogin.adminTel
        user.brokerGender = userLogin.brokerGender
        user.brokerId = userLogin.brokerId
        user.brokerName = userLogin.brokerName
        user.brokerPicKey = userLogin.brokerPicKey
        user.brokerStoreId = userLogin.brokerStoreId
        user.brokerStoreName = userLogin.brokerStoreName
        user.brokerTel = userLogin.brokerTel
        user.cityName = userLogin.cityName
        user.code = userLogin.code
        user.token = userLogin.token
        user.identity = userLogin.identity
        user.orgId = userLogin.orgId
        user.orgName = userLogin.orgName
        user.brokerType = userLogin.brokerType
        user.identitys = userLogin.identitys
        user.orgCityName = userLogin.orgCityName
        let finish: Bool = self.saveContext(context)
        return finish
    }
    
/**
 *	@brief	从数据库 加载用户信息 到 userlogin
 *
 *	@param
 *
 *	@return
 */
    
    class func loadUserInfo() -> Void
    {
        let delegate = shareAppDelegate
        let request = NSFetchRequest()
        let entity = NSEntityDescription.entityForName("HWUser", inManagedObjectContext: delegate.managedObjectContext!)
        request.entity = entity
        
        let users: NSArray? = delegate.managedObjectContext?.executeFetchRequest(request, error: nil)
        
        if (users == nil)
        {
            println("load user error")
        }
        if (users?.count == 0)
        {
            return
        }
        
        let user = users?.lastObject as HWUser
        let userLogin = HWUserLogin.currentUserLogin()
        userLogin.key = user.key
        userLogin.cityId = user.cityId
        userLogin.adminId = user.adminId
        userLogin.adminName = user.adminName
        userLogin.adminTel = user.adminTel
        userLogin.brokerGender = user.brokerGender
        userLogin.brokerId = user.brokerId
        userLogin.brokerName = user.brokerName
        userLogin.brokerPicKey = user.brokerPicKey
        userLogin.brokerStoreId = user.brokerStoreId
        userLogin.brokerStoreName = user.brokerStoreName
        userLogin.brokerTel = user.brokerTel
        userLogin.cityName = user.cityName
        userLogin.code = user.code
        userLogin.token = user.token
        userLogin.identity = user.identity
        userLogin.orgId = user.orgId
        userLogin.orgName = user.orgName
        userLogin.brokerType = user.brokerType
        userLogin.identitys = user.identitys
        if (user.orgCityName != nil)
        {
            userLogin.orgCityName = user.orgCityName
        }
        else
        {
            userLogin.orgCityName = ""
        }
        
    }
    
/**
 *	@brief	清除数据库用户信息
 *
 *	@param
 *
 *	@return
 */
    class func clearUserInfo() -> Bool
    {
        self.deleteOneEntityAllData("HWUser")
        return true
//        let delegate = shareAppDelegate
//        
//        let context = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.PrivateQueueConcurrencyType)
//        
//        context.parentContext = delegate.managedObjectContext
//        
//        let request = NSFetchRequest()
//        let entity = NSEntityDescription.entityForName("HWUser", inManagedObjectContext: context)
//        request.entity = entity
//        
//        var users: NSArray? = context.executeFetchRequest(request, error: nil)
//        
//        if (users == nil)
//        {
//            return false
//        }
//        
//        for item in users!
//        {
//            let obj = item as HWUser
//            context.deleteObject(obj)
//        }
//        
//        let success = self.saveContext(context)
//        return success
    }
    
    class func lastLoginInfo() ->(HWUserLogin)
    {
        let delegate = shareAppDelegate
        let entity = NSEntityDescription.entityForName("HWUser", inManagedObjectContext: delegate.managedObjectContext!)
        let request = NSFetchRequest()
            request.entity = entity
        let users = delegate.managedObjectContext!.executeFetchRequest(request, error: nil)
        if users == nil
        {
            println("user load error")
        
        }
        if users?.count == 0
        {
            return HWUserLogin()
        }
        let user = users?.last as HWUser
        var lastUsr = HWUserLogin()
        lastUsr.brokerTel = user.brokerTel
        lastUsr.brokerPicKey = user.brokerPicKey
        lastUsr.adminTel = user.adminTel
        return lastUsr
    }
    
    // MARK: 服务模块
    /**
    *	@brief	保存服务-客户列表
    *
    *	@param
    *
    *	@return
    */
    
    class func saveServiceCustomerList(serviceCustomerArray: NSArray) -> Bool
    {
        self.deleteOneEntityAllData("HWServiceCustomerList")
        var delegate = shareAppDelegate
        let context = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.PrivateQueueConcurrencyType)
        
        context.parentContext = delegate.managedObjectContext
        
        for (var i = 0 ;i < serviceCustomerArray.count ;i++)
        {
            
            var dic:NSDictionary = serviceCustomerArray.pObjectAtIndex(i) as NSDictionary
            var model = HWServiceCustomerModel(dic: dic)
            var item: HWServiceCustomerList = NSEntityDescription.insertNewObjectForEntityForName("HWServiceCustomerList", inManagedObjectContext: context) as HWServiceCustomerList
            item.brokerId = model.brokerId
            item.chanceId = model.chanceId
            item.chanceStatus = model.chanceStatus
            item.chanceType = model.chanceType
            item.chanceTypeId = model.chanceTypeId
            item.clientId = model.clientId
            item.loan = model.loan
            item.modifyTime = model.modifyTime
            item.name = model.name
            item.productName = model.productName
        }
        var success = self.saveContext(context)
        return success
    }
    
    //读取服务-客户列表
    class func loadServiceCustomerList() -> NSMutableArray
    {
        var error: NSError?
        let delegate = shareAppDelegate
        var request:NSFetchRequest = NSFetchRequest(entityName: "HWServiceCustomerList")
        var entity:NSEntityDescription = NSEntityDescription.entityForName("HWServiceCustomerList", inManagedObjectContext: delegate.managedObjectContext!)!
        var sort = NSSortDescriptor(key: "modifyTime", ascending: false)
        request.sortDescriptors = [sort]
        request.entity = entity
        let array:NSArray? = delegate.managedObjectContext?.executeFetchRequest(request ,error: &error)
        
        var listArray:NSMutableArray = NSMutableArray()
        
        for (var i = 0 ;i < array?.count ;i++)
        {
            let Array = array?.pObjectAtIndex(i) as HWServiceCustomerList
            
            var model = HWServiceCustomerModel()
            model.brokerId = Array.brokerId
            model.chanceId = Array.chanceId
            model.chanceStatus = Array.chanceStatus
            model.chanceType = Array.chanceType
            model.chanceTypeId = Array.chanceTypeId
            model.clientId = Array.clientId
            model.loan = Array.loan
            model.modifyTime = Array.modifyTime
            model.name = Array.name
            model.productName = Array.productName
            listArray.addObject(model)
        }
        return listArray
    }
    

    
    //MARK: 二手房首页缓存
    class func clearScdHouHomepageList() -> Bool
    {
        self.deleteOneEntityAllData("HWScdHouList")
        return true
//        var error: NSError?
//        let coredataDelegate = shareAppDelegate
//        
//        let context = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.PrivateQueueConcurrencyType)
//        context.parentContext = coredataDelegate.managedObjectContext
//        
//        let fetchRequest = NSFetchRequest()
//        var entity: NSEntityDescription = NSEntityDescription.entityForName("HWScdHouList", inManagedObjectContext: context)!
//        fetchRequest.entity = entity
//        
//        var arr: NSArray? = coredataDelegate.managedObjectContext?.executeFetchRequest(fetchRequest, error: &error)
//        
//        if (arr == nil)
//        {
//            return false
//        }
//        
//        for obj in arr!
//        {
//            var item = obj as HWScdHouList
//            coredataDelegate.managedObjectContext?.deleteObject(item)
//        }
//        var success = self.saveContext(context)
//        
//        return success
    }
    
    class func saveScdHouHomepageList(list: NSArray) -> Bool
    {
        if(self.clearScdHouHomepageList() == false)
        {
//            println("清理二手房列表失败")
        }
        
        var delegate = shareAppDelegate
        
        let context = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.PrivateQueueConcurrencyType)
        context.parentContext = delegate.managedObjectContext
        
        for var i = 0; i < list.count; i++
        {
            var model: HWScdHouseModel = list.pObjectAtIndex(i) as HWScdHouseModel
            
            var scdHou: HWScdHouList = NSEntityDescription.insertNewObjectForEntityForName("HWScdHouList", inManagedObjectContext: context) as HWScdHouList
            scdHou.areaId = model.areaId
            scdHou.areaName = model.areaName
            scdHou.brokerId = model.brokerId
            scdHou.cityId = model.cityId
            scdHou.cityName = model.cityName
            scdHou.hallCount = model.hallCount
            scdHou.orderType = model.orderType
            scdHou.picKey = model.picKey
            scdHou.plateId = model.plateId
            scdHou.plateName = model.plateName
            scdHou.price = model.price
            scdHou.proportion = model.proportion
            scdHou.roomCount = model.roomCount
            scdHou.roomType = model.roomType
            scdHou.scdHandHousesId = model.scdHandHousesId
            scdHou.title = model.title
            scdHou.toiletCount = model.toiletCount
            scdHou.villageId = model.villageId
            scdHou.villageName = model.villageName
            scdHou.isAppoint = model.isAppoint
            scdHou.appointNum = model.appointNum
            scdHou.sortSign = NSNumber(int: Int32(i))
        }
        var success = self.saveContext(context)
        return success
    }
    
    class func readScdHouHomepageList() -> NSArray
    {
        var error: NSError?
        let delegate = shareAppDelegate
        
        var request: NSFetchRequest = NSFetchRequest(entityName: "HWScdHouList")
        var entity: NSEntityDescription = NSEntityDescription.entityForName("HWScdHouList", inManagedObjectContext: delegate.managedObjectContext!)!
        var sortAsc = NSSortDescriptor(key: "sortSign", ascending: true)
        request.sortDescriptors = [sortAsc]
        request.entity = entity
        
        var array: NSArray? = delegate.managedObjectContext?.executeFetchRequest(request ,error: &error)
        var tmpArr = NSMutableArray()
        
        if (array == nil)
        {
            return NSArray()
        }
        
        for obj in array!
        {
            let item = obj as HWScdHouList
            
            var model = HWScdHouseModel()
            model.areaId = item.areaId
            model.areaName = item.areaName
            model.brokerId = item.brokerId
            model.cityId = item.cityId
            model.cityName = item.cityName
            model.hallCount = item.hallCount
            model.orderType = item.orderType
            model.picKey = item.picKey
            model.plateId = item.plateId
            model.plateName = item.plateName
            model.price = item.price
            model.proportion = item.proportion
            model.roomCount = item.roomCount
            model.roomType = item.roomType
            model.scdHandHousesId = item.scdHandHousesId
            model.title = item.title
            model.toiletCount = item.toiletCount
            model.villageId = item.villageId
            model.villageName = item.villageName
            model.isAppoint = item.isAppoint
            model.appointNum = item.appointNum
            
            tmpArr.addObject(model)
        }
        return tmpArr
    }
    
    //MARK: 新房首页缓存
    class func saveNewList(array : NSArray ) -> Bool{
        HWCoreDataManager.cleanNewList()
        var delegate : AppDelegate = shareAppDelegate
        
        let context = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.PrivateQueueConcurrencyType)
        context.parentContext = delegate.managedObjectContext
        
        for var i = 0; i < array.count; i++
        {
            var newModel = array[i] as HWNewHouseListModel
            var houseList : HWNewHouseList = NSEntityDescription.insertNewObjectForEntityForName("HWNewHouseList", inManagedObjectContext: context) as HWNewHouseList
            houseList.houseId = newModel.houseId!
            houseList.houseName = newModel.houseName!
            houseList.houseAddress = newModel.houseAddress!
            houseList.brokerNum = newModel.brokerNum
            houseList.clientNum = newModel.clientNum
            houseList.houseAvgPrice = newModel.houseAvgPrice
            houseList.commission = newModel.commission
            houseList.shareUrl = newModel.shareUrl!
            houseList.housePic = newModel.housePic!
            houseList.sortSign = NSNumber(int: Int32(i))
        }
        var successful = self.saveContext(context)
        return successful
    }

    class func loadNewList() -> NSMutableArray{
        var delegate : AppDelegate = shareAppDelegate
        var request = NSFetchRequest()
        var entity = NSEntityDescription.entityForName("HWNewHouseList", inManagedObjectContext: delegate.managedObjectContext!)
        var sortAsc = NSSortDescriptor(key: "sortSign", ascending: true)
        request.sortDescriptors = [sortAsc]
        request.entity = entity
        var error : NSError? = nil
        var fetchedObjects : NSArray = delegate.managedObjectContext!.executeFetchRequest(request, error: &error)!
        var muArr = NSMutableArray()
        if fetchedObjects.count > 0
        {
            for obj in fetchedObjects
            {
                let item =  obj as HWNewHouseList
                var newModel : HWNewHouseListModel = HWNewHouseListModel()
                newModel.houseId = item.houseId
                newModel.houseName = item.houseName
                newModel.houseAddress = item.houseAddress
                newModel.brokerNum = item.brokerNum
                newModel.clientNum = item.clientNum
                newModel.houseAvgPrice = item.houseAvgPrice
                newModel.commission = item.commission
                newModel.shareUrl = item.shareUrl
                newModel.housePic = item.housePic
                muArr.addObject(newModel)
            }
        }
        return muArr
    }
    class func cleanNewList() ->Bool{
        self.deleteOneEntityAllData("HWNewHouseList")
        return true
//        var error : NSError? = nil
//        var delegate : AppDelegate = shareAppDelegate
//        
//        let context = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.PrivateQueueConcurrencyType)
//        context.parentContext = delegate.managedObjectContext
//        
//        var request = NSFetchRequest()
//        var entity = NSEntityDescription.entityForName("HWNewHouseList", inManagedObjectContext: delegate.managedObjectContext!)
//        request.entity = entity
//        var houseList : NSArray = delegate.managedObjectContext!.executeFetchRequest(request, error: &error)!
//        for neighbour in houseList
//        {
//            let item = neighbour as HWNewHouseList
//            delegate.managedObjectContext?.deleteObject(item)
//        }
//        
//        var success = self.saveContext(context)
//        return success
    }
}
