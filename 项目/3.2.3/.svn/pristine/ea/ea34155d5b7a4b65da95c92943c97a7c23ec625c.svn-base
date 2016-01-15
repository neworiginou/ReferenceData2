//
//  AppDelegate.swift
//  Partner-Swift
//
//  Created by caijingpeng.haowu on 15/2/10.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var locationManager: HWLocationManager?
    var checkForceUpdate: HWCheckForceUpdateWidget?
    var tabbarNav:HWBaseNavigationController?
    var loginNav:HWBaseNavigationController?
    var loginCtrl:HWLoginViewController? = nil
    var tabbarVC:HWTabbarViewController? = nil
    
    var myPurseVC:HWMoneyViewController!
    //MYP add v3.2.3 修改消息主页面改为各类消息的总分类
    //var messageListVC:HWMessageListViewController!
    var messageListVC:HWMainMsgViewController!
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        
        MobClick.startWithAppkey(UMENG_APP_KEY)     //友盟统计初始化
        //设置版本号
        /*
        NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        [MobClick setAppVersion:version];
*/
//        var versionDic:NSDictionary = NSBundle.mainBundle().infoDictionary as NSDictionary!
//        var version:String = versionDic.objectForKey("CFBundleShortVersionString") as String;
//        MobClick.setAppVersion(version);
        //end
        initialUMeng()
        var versionDic:NSDictionary = NSBundle.mainBundle().infoDictionary as NSDictionary!
        var version:String = versionDic.objectForKey("CFBundleShortVersionString") as String;
        MobClick.setAppVersion(version);
        HWCoreDataManager.loadUserInfo()
        self.getCityList()

        //添加打电话的
        HWCallDetectCenter.shareInstance()
        
//        Utility.getTimeFormattWithTimeStamp("1426728901000")
        application.applicationIconBadgeNumber = 0
        APService.setBadge(0);
        //JPush
        APService.registerForRemoteNotificationTypes((UIUserNotificationType.Badge.rawValue | UIUserNotificationType.Sound.rawValue | UIUserNotificationType.Alert.rawValue), categories: nil)
        APService.setupWithOption(launchOptions)
        var userDefault = NSUserDefaults.standardUserDefaults()
        let strUserDefault = userDefault.stringForKey(kNotificationSwitch)
        
        if strUserDefault == "0"
        {
            UIApplication.sharedApplication().unregisterForRemoteNotifications()
        }
        else if strUserDefault == nil || strUserDefault == "1"
        {
            userDefault.setObject("1", forKey: kNotificationSwitch)
            APService.registerForRemoteNotificationTypes((UIUserNotificationType.Badge.rawValue | UIUserNotificationType.Sound.rawValue | UIUserNotificationType.Alert.rawValue), categories: nil)
            APService.setupWithOption(launchOptions)
        }
    
        if !iOS7
        {
            
            if launchOptions?[UIApplicationLaunchOptionsRemoteNotificationKey] != nil
            {
                self.handlePushInfo(launchOptions?[UIApplicationLaunchOptionsRemoteNotificationKey] as NSDictionary)
            }
        }
        
        if iOS8
        {
            var action: UIMutableUserNotificationAction = UIMutableUserNotificationAction()
            action.identifier = "action"
            action.title = "Accept"
            action.activationMode = UIUserNotificationActivationMode.Foreground
            action.authenticationRequired = false
            action.destructive = false
            
            var action2: UIMutableUserNotificationAction = UIMutableUserNotificationAction()
            action2.identifier = "action2"
            action2.title = "Reject"
            action2.activationMode = UIUserNotificationActivationMode.Background
            action2.authenticationRequired = true
            action2.destructive = true
            
            var categorys: UIMutableUserNotificationCategory = UIMutableUserNotificationCategory()
            categorys.identifier = "alert"
            categorys.setActions([action,action2], forContext: UIUserNotificationActionContext.Default)
            
            var uns:UIUserNotificationSettings = UIUserNotificationSettings(forTypes: UIUserNotificationType.Alert | UIUserNotificationType.Badge | UIUserNotificationType.Sound, categories: NSSet(objects: categorys))
            UIApplication.sharedApplication().registerForRemoteNotifications()
            UIApplication.sharedApplication().registerUserNotificationSettings(uns)
        }
        UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: UIStatusBarAnimation.None)
        self.locationManager = HWLocationManager.shareManager()
        self.locationManager?.startLoacting()
        self.window?.rootViewController = ViewController()
        self.window?.makeKeyAndVisible()
//        tabbarVC = HWTabbarViewController()
//        tabbarVC!.navigationController?.navigationBarHidden = true;
//        tabbarNav = HWBaseNavigationController(rootViewController: tabbarVC!)
        
        loginCtrl = HWLoginViewController()
        loginNav = HWBaseNavigationController(rootViewController: loginCtrl!)

        if (Utility.isUsrLogin() == false)
        {
            self.window?.rootViewController?.addChildViewController(loginNav!)
            currentNav = loginNav!
            loginCtrl!.autoLogin = IsAutoLogin.notAuto
            self.window?.rootViewController?.view.addSubview(loginNav!.view)
        }
        else
        {
            let userDefault = NSUserDefaults.standardUserDefaults()
            let role: String = userDefault.objectForKey(kLastLoginRole) as String
            if (role == "broker")
            {
                tabbarVC = HWTabbarViewController()
                tabbarVC!.navigationController?.navigationBarHidden = true;
                tabbarNav = HWBaseNavigationController(rootViewController: tabbarVC!)
                
                self.window?.rootViewController?.addChildViewController(tabbarNav!)
                currentNav = tabbarNav!
                self.window?.rootViewController?.view.addSubview(tabbarNav!.view)
            }
            if (role == "admin")
            {
                self.window?.rootViewController?.addChildViewController(loginNav!)
                currentNav = loginNav!
                loginCtrl!.autoLogin = IsAutoLogin.isAuto
                self.window?.rootViewController?.view.addSubview(loginNav!.view)
            }
            
        }
        
        //二手房 系统配置 更新 niedi
        HWScdHouConfigCenter.defaultCenter().updateConfig()
        
        checkForceUpdate = HWCheckForceUpdateWidget.initWithDepentView(self.window!)
        
        Utility.getAearList()
        HWUserLogin.currentUserLogin().areas.count
        
        return true
    }
    
    //    获取城市列表
    func getCityList()
    {
        var documentsDirectory = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as NSString
        var filePath = documentsDirectory.stringByAppendingPathComponent("city.plist")
        if (NSFileManager.defaultManager() .fileExistsAtPath(filePath))
        {
            var fileDataArray : NSMutableArray! = NSMutableArray(contentsOfFile: filePath)
            self.handleData(fileDataArray)
        }
        else
        {
            var path = NSBundle.mainBundle().pathForResource("city", ofType: "plist")
            if NSFileManager.defaultManager().copyItemAtPath(path!, toPath: filePath, error: nil)
            {
//                println("succeed")
            }else
            {
//                println("failure")
            }
            
            var fileDataArr = NSMutableArray(contentsOfFile:path!)
            self.handleData(fileDataArr!)
        }
        var managerTemp = HWHttpRequestOperationManager.cityManager()
        var dict = NSMutableDictionary()
        var dataVersionStr : NSString = "0"
        if NSUserDefaults.standardUserDefaults().objectForKey("version")?.length > 0
        {
            dataVersionStr = NSUserDefaults.standardUserDefaults().objectForKey("version") as NSString
        }
        if dataVersionStr == Optional.None
        {
            dict.setObject("1", forKey: "version")
        } 
        else
        {
            dict.setObject(dataVersionStr, forKey: "version")
        }
        managerTemp.postHttpRequest(kGetCooperationCityList, parameters: dict, queue: nil, success: { (responseObject) -> Void in
            var finalCities : NSMutableArray = NSMutableArray()
            var dataDic : NSDictionary = responseObject.dictionaryObjectForKey("data")
            var allCitys : NSArray = dataDic.arrayObjectForKey("json")
            
            for (var i = 0; i < allCitys.count;i++)
            {
                var arr : NSArray = (allCitys.objectAtIndex(i) as NSDictionary).arrayObjectForKey("citys")
                for (var j = 0; j < arr.count;j++)
                {
                    finalCities.addObject(arr[j])
                }
            }
            var documentsDirectory = documentsDirectory
            var savedPath = filePath
            var cityArray = NSMutableArray()
            for (var i = 0; i < finalCities.count; i++)
            {
                var cityDict = NSMutableDictionary()
                var cityDic = finalCities[i] as NSDictionary
                cityDict.setObject(cityDic.stringObjectForKey("province_id"), forKey: "province_id")
                cityDict.setObject(cityDic.stringObjectForKey("city_code"), forKey: "city_code")
                cityDict.setObject(cityDic.stringObjectForKey("city_name"), forKey: "city_name")
                cityDict.setObject(cityDic.stringObjectForKey("city_quanpin"), forKey: "city_quanpin")
                cityDict.setObject(cityDic.stringObjectForKey("city_order"), forKey: "city_order")
                cityDict.setObject(cityDic.stringObjectForKey("id"), forKey: "id")
                var areaArr = cityDic.arrayObjectForKey("areas")
                var areaArray = NSMutableArray()
                for (var j = 0; j < areaArr.count; j++)
                {
                    var areaDic = NSMutableDictionary()
                    areaDic.setObject((areaArr[j] as NSDictionary).stringObjectForKey("id"), forKey: "id")
                    areaDic.setObject((areaArr[j] as NSDictionary).stringObjectForKey("city_id"), forKey: "city_id")
                    areaDic.setObject((areaArr[j] as NSDictionary).stringObjectForKey("area_name"), forKey: "area_name")
                    areaDic.setObject((areaArr[j] as NSDictionary).stringObjectForKey("area_order"), forKey: "area_order")
                    var plateArray = NSMutableArray()
                    var plateArr = areaArr[j].arrayObjectForKey("plates")
                    for (var k = 0; k < plateArr.count; k++)
                    {
                        var plateDic = NSMutableDictionary()
                        plateDic.setObject((plateArr[k] as NSDictionary).stringObjectForKey("id"), forKey: "id")
                        plateDic.setObject((plateArr[k] as NSDictionary).stringObjectForKey("area_id"), forKey: "area_id")
                        plateDic.setObject((plateArr[k] as NSDictionary).stringObjectForKey("plate_order"), forKey: "plate_order")
                        plateDic.setObject((plateArr[k] as NSDictionary).stringObjectForKey("name"), forKey: "name")
                        plateArray.addObject(plateDic)
                    }
                    areaDic.setObject(plateArray, forKey: "plates")
                    areaArray.addObject(areaDic)
                }
                cityDict.setObject(areaArray, forKey: "areas")
                cityArray.addObject(cityDict)
            }
            self.handleData(cityArray)
            if cityArray.writeToFile(savedPath, atomically: false)
            {
//                println("succeed")
            }
            else
            {
//                println("failed")
            }
            
            NSUserDefaults.standardUserDefaults().setObject(dataDic.stringObjectForKey("version"), forKey: "version")
        }) { (failure,error) -> Void in
            println("请求城市列表失败")
        }
    }
    
    func handleData(dataArray : NSMutableArray)
    {
        var allCity = NSMutableArray()
        for (var i = 0; i < dataArray.count; i++)
        {
            var cityDic : NSDictionary = dataArray.pObjectAtIndex(i) as NSDictionary
            var cityClass = HWCityClass(dic: cityDic)
            allCity.addObject(cityClass)
        }
        HWUserLogin.currentUserLogin().cities = allCity
    }
    
//MARK:推送
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
//        println(deviceToken)
        APService.registerDeviceToken(deviceToken)
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
//        println(userInfo)
        APService.handleRemoteNotification(userInfo)
    }
    
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject], fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        //ios7
        APService.handleRemoteNotification(userInfo)
        completionHandler(UIBackgroundFetchResult.NewData)
//        println(userInfo)

        self.handlePushInfo(userInfo)
    }
    
    func handlePushInfo(userInfo:NSDictionary) -> Void
    {
        //推送：1  点击进入客户详情
        //推送：2  点击进入客户详情
        //推送：3  点击进入客户详情
        //推送：4  点击进入客户详情
        //推送：5  点击进入我的下线
        //推送：6  点击进入消息详情
        //推送：7  点击进入消息详情
        //推送：8  点击进入消息详情
        //推送：9  点击进入预约详情
        //推送：10 点击进入房源详情
        //推送：11 点击进入积分详情
        //推送：12 点击进入钱包明细
        
        
        
        var baseNav:HWBaseNavigationController = HWBaseNavigationController()
        
//        println(self.window?.rootViewController?.childViewControllers)
        var vc: AnyObject? = self.window?.rootViewController?.childViewControllers.last
        if (vc?.isKindOfClass(HWBaseNavigationController) != nil)
        {
            baseNav = vc as HWBaseNavigationController
        }
        else
        {
            return
        }
        
//        let nav:HWBaseNavigationController = self.window!.rootViewController as HWBaseNavigationController
        let type:NSString = userInfo.stringObjectForKey("type") as NSString
        
        
        if type.isEqualToString("1") ||
            type.isEqualToString("2") ||
            type.isEqualToString("3") ||
            type.isEqualToString("4")
        {
            let customerDetailVC = HWCustomerDetailViewController()
            let clientInfoid = userInfo .stringObjectForKey("clientInfoId")
            customerDetailVC.clientInfoId = clientInfoid
            baseNav.pushViewController(customerDetailVC, animated: true)
        }
        else if type.isEqualToString("5")
        {
            let vc = HWSubordinateViewController()
            baseNav.pushViewController(vc, animated: true)
        }
        else if type.isEqualToString("6")
        {
            //HWMessageListModel
            var msgListModel:HWMessageListModel = HWMessageListModel(messageInfo: userInfo)
            let vc = HWMessageDialogViewController()
            vc.msgListModel = msgListModel
            vc.msgListModel?.msgType = "system"
            baseNav.pushViewController(vc, animated: true)
        }
        else if(type.isEqualToString("7"))
        {
            //HWMessageListModel
            var msgListModel:HWMessageListModel = HWMessageListModel(messageInfo: userInfo)
            let vc = HWMessageDialogViewController()
            vc.msgListModel = msgListModel
            vc.msgListModel?.msgType = "system"
            baseNav.pushViewController(vc, animated: true)
        }
        else if type.isEqualToString("8")
        {
            var msgListModel:HWMessageListModel = HWMessageListModel(messageInfo: userInfo)
//            let messageid = userInfo .stringObjectForKey("messageId")
//            msgListModel?.messageId = messageid
            let vc = HWHiDialogViewController()
            vc.msgListModel = msgListModel
            baseNav.pushViewController(vc, animated: true)
        }
        else if type.isEqualToString("9")
        {
            //预约详情
            let myHouseShopVC = HWDynamicDetailViewController()
            let dynamicId = userInfo .stringObjectForKey("dynamicId")
            myHouseShopVC._status = pendingState.pending;
            myHouseShopVC._id = dynamicId
            
            baseNav.pushViewController(myHouseShopVC, animated: true)
        }
        else if type.isEqualToString("10")
        {
            //房源详情（二手房）
            
            var detailVC = HWScdHouseDetailVC()
            let secHouseId = userInfo .stringObjectForKey("houseId")
            detailVC._houseId = secHouseId
            baseNav.pushViewController(detailVC, animated: true)
        }
        else if type.isEqualToString("11")
        {
            let vc = HWMyIntegrationViewController()
            baseNav.pushViewController(vc, animated: true)
        }
        else if type.isEqualToString("12")
        {
            
            let recordId = userInfo.stringObjectForKey("recordid")
            let vc = WalletDetailViewController(detailID: recordId)
            
            baseNav.pushViewController(vc, animated: true)
        }
        
    }
    
    func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
        return UMSocialSnsService.handleOpenURL(url)
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        return UMSocialSnsService.handleOpenURL(url)
    }

    func applicationWillResignActive(application: UIApplication)
    {
        NSNotificationCenter.defaultCenter().postNotificationName(kRefershChatListNotification, object: nil);
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        application.applicationIconBadgeNumber = 0
        APService.setBadge(0);
        application.cancelAllLocalNotifications()
        
        if (self.checkForceUpdate != nil)
        {
            self.checkForceUpdate?.checkForceUpdate()
        }
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

//    func application(application: UIApplication, supportedInterfaceOrientationsForWindow window: UIWindow?) -> Int {
//        return Portrait
//    }
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }
    
    // MARK: - UMeng initial
    
    func initialUMeng()
    {
        // ********   友盟   *********
        UMSocialData.setAppKey(UMENG_APP_KEY)
        UMSocialWechatHandler.setWXAppId(WECHAT_KEY, appSecret: WECHAT_SECRET, url: "http://www.umeng.com/social")
        //打开新浪微博的SSO开关
        UMSocialSinaHandler.openSSOWithRedirectURL("http://sns.whalecloud.com/sina2/callback")
        
//        UMSocialQQHandler.setQQWithAppId(QZONE_APPID, appKey: QZONE_APPKEY, url: "http://www.umeng.com/social")
//        UMSocialQQHandler.setSupportWebView(true)
    }

    // MARK: - Core Data stack

    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "Haowu.Partner_Swift" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1] as NSURL
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("Partner_Swift", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        
//        let oldUrl: NSURL = self.applicationDocumentsDirectory.URLByAppendingPathComponent("HaoWuCoreData.sqlite")
//        
//        println("\(oldUrl.absoluteString)")
//        
//        let fileManager = NSFileManager.defaultManager()
//        let exist = fileManager.fileExistsAtPath(oldUrl.absoluteString!)
//        if (exist)
//        {
//            fileManager.removeItemAtPath(oldUrl.absoluteString!, error: nil)
//        }
        
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("Partner_Swift.sqlite")
        var error: NSError? = nil
        var failureReason = "There was an error creating or loading the application's saved data."
        
//        NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
//            [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
//            [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
        
        var dic = NSDictionary(objectsAndKeys: NSNumber(bool: true), NSMigratePersistentStoresAutomaticallyOption, NSNumber(bool: true), NSInferMappingModelAutomaticallyOption);
        
        if coordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: dic, error: &error) == nil {
            coordinator = nil
            // Report any error we got.
            let dict = NSMutableDictionary()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            dict[NSUnderlyingErrorKey] = error
            error = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(error), \(error!.userInfo)")
            abort()
        }
        
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext? = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        if coordinator == nil
        {
            return nil
        }
        var managedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.PrivateQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if let moc = self.managedObjectContext {
            var error: NSError? = nil
            if moc.hasChanges && !moc.save(&error) {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                NSLog("Unresolved error \(error), \(error!.userInfo)")
                abort()
            }
        }
    }

}

