//
//  HWCheckForceUpdateWidget.swift
//  Partner-Swift
//
//  Created by caijingpeng.haowu on 15/2/11.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：强制更新
//
//  修改记录：
//      姓名         日期               修改内容
//     蔡景鹏     2015-02-11           创建文件
//

import Foundation

let forceAlertTag = 1001
let updateAlertTag = 1002

class HWCheckForceUpdateWidget: NSObject, UIAlertViewDelegate {
    
    var dependView: UIView?
    var isForceUpdate: NSString?
    var reachability: Reachability?
    var forceUpdateMsg: NSString?
    var updateUrl: NSString?
    
    //  MARK: 公共方法
    
/**
 *	@brief	初始化方法
 *
 *	@param 	view: UIView  toast提醒显示的view
 *
 *	@return
 */
    class func initWithDepentView(view: UIView) -> HWCheckForceUpdateWidget
    {
        let checkUpdate = HWCheckForceUpdateWidget()
        
        checkUpdate.dependView = view
        checkUpdate.isForceUpdate = "N"
        checkUpdate.checkNetworkConnection()
        
        return checkUpdate
    }
    
/**
 *	@brief	检查app 是否有更新
 *
 *	@param
 *
 *	@return
 */
    func checkAppVersion() -> Void
    {
        self.synCheckAppVersion(showAlert: true)
    }
    
/**
 *	@brief	检查是否有强制更新
 *
 *	@param
 *
 *	@return
 */
    func checkForceUpdate() -> Void
    {
        if (self.isForceUpdate?.isEqualToString("Y") == true)
        {
            let alert: UIAlertView! = UIAlertView(title: "提示", message: self.forceUpdateMsg!, delegate: self, cancelButtonTitle: nil, otherButtonTitles: "更新")
            alert.tag = forceAlertTag
            alert.show()
        }
    }
    
    // MARK:
    
/**
 *	@brief	检查网络连接
 *
 *	@param
 *
 *	@return
 */
    func checkNetworkConnection() -> Void
    {
        self.reachability = Reachability(hostName: "www.haowu.com")
        self.reachability?.startNotifier()
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"networkChanged:", name: kReachabilityChangedNotification, object: nil)
    }
    
/**
 *	@brief	网络监听
 *
 *	@param
 *
 *	@return
 */
    func networkChanged(notify: NSNotification) -> Void
    {
        let curReach = notify.object as Reachability
        var networkStatus: NetworkStatus = curReach.currentReachabilityStatus()
        
        if (networkStatus.value == NotReachable.value)
        {
            if (self.dependView != nil)
            {
                Utility.showToastWithMessage(kFailureDetail, _view: self.dependView!)
            }
        }
        else if (networkStatus.value == ReachableViaWiFi.value)
        {
            self.checkForceUpdateVersion()
        }
        else if (networkStatus.value == ReachableViaWWAN.value)
        {
            self.checkForceUpdateVersion()
        }
        else
        {
            
        }
    }
    
/**
 *	@brief	检查强制更新
 *
 *	@param
 *
 *	@return
 */
    func checkForceUpdateVersion() -> Void
    {
        let httpManager = HWHttpRequestOperationManager.baseManager()
        var param: NSMutableDictionary = NSMutableDictionary()
        param.setPObject("os", forKey: "ios")
        param.setPObject("12", forKey: "versionCode")
        httpManager.postHttpRequest(kForceUpdate, parameters: param, queue: nil, success: { (responseObject) -> Void in
            
            let dic = (responseObject as NSDictionary).dictionaryObjectForKey("data")
            var isForce: NSString? = dic.stringObjectForKey("isforce")
            var isNeed: NSString? = dic.stringObjectForKey("isNeed")
            let updateMsg = dic.stringObjectForKey("updateMessage")
            self.updateUrl = dic.stringObjectForKey("uri")
            if ((isForce?.isEqualToString("Y")) == true)
            {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    let alert: UIAlertView! = UIAlertView(title: "提示", message: updateMsg, delegate: self, cancelButtonTitle: nil, otherButtonTitles: "更新")
                    alert.tag = forceAlertTag
                    alert.show()
                    return
                })
                self.isForceUpdate = "Y"
                self.forceUpdateMsg = updateMsg
            }
            else if (isNeed?.isEqualToString("Y") == true)
            {
                let onlineVersionCode: NSString = dic.stringObjectForKey("versionCode")
                let currentVersionCode: NSString = Utility.getLocalAppVersion()
                if !onlineVersionCode .isEqualToString(currentVersionCode)
                {
                    let alert: UIAlertView = UIAlertView(title: "提示", message: updateMsg, delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "更新")
                    alert.tag = updateAlertTag
                    alert.show()
                }
                
//                只通过后台接口
//                let http_queue = dispatch_queue_create("com.bkd.org", DISPATCH_QUEUE_CONCURRENT);
//                
//                dispatch_async(http_queue, { () -> Void in
//                    self.synCheckAppVersion(showAlert: false)
//                })
            }
            
            
        }) { (code, error) -> Void in
            
//            let http_queue = dispatch_queue_create("com.bkd.org", DISPATCH_QUEUE_CONCURRENT);
//            
//            dispatch_async(http_queue, { () -> Void in
//                self.synCheckAppVersion(showAlert: false)
//            })
            
        }
    }
    
    
/**
 *	@brief	同步请求 itunes 是否新版本
 *
 *	@param
 *
 *	@return
 */
    func synCheckAppVersion(showAlert isShow: Bool) -> Void
    {
        let urlStr = NSString(format: "http://itunes.apple.com/lookup?id=%@", appID)
        let data = NSData(contentsOfURL: NSURL(string: urlStr)!)
        let parser = SBJsonParser()

        let dict: NSDictionary? = parser.objectWithData(data) as? NSDictionary
        
        if (dict == nil)
        {
            return
        }
        
        let resultsDic: NSDictionary? = dict?.arrayObjectForKey("results").pObjectAtIndex(0) as? NSDictionary
        
        let version: NSString? = resultsDic?.stringObjectForKey("version")
        
        if (version?.isEqualToString(Utility.getLocalAppVersion()) == false)
        {
            let msg: NSString? = (dict?.arrayObjectForKey("results").lastObject as NSDictionary).stringObjectForKey("releaseNotes")
            if (msg?.length > 0)
            {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    let alert: UIAlertView! = UIAlertView(title: "新版本更新", message: msg!, delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "更新")
                    alert.tag = updateAlertTag
                    alert.show()
                    return
                })
            }
            else
            {
                if (self.dependView != nil && isShow == true)
                {
                    Utility.showToastWithMessage("已是最新版本", _view: self.dependView!)
                }
            }
        }
        else
        {
            if (self.dependView != nil && isShow == true)
            {
                Utility.showToastWithMessage("已是最新版本", _view: self.dependView!)
            }
        }
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        
        if (alertView.tag == forceAlertTag)
        {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                UIApplication.sharedApplication().openURL(NSURL(string: ITUNSE_DOWNLOAD_URL)!)
                UIApplication.sharedApplication().openURL(NSURL(string: self.updateUrl!)!)
                return
            })
        }
        else if (alertView.tag == updateAlertTag)
        {
            if (buttonIndex == 1)
            {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                    UIApplication.sharedApplication().openURL(NSURL(string: ITUNSE_DOWNLOAD_URL)!)
                    UIApplication.sharedApplication().openURL(NSURL(string: self.updateUrl!)!)
                    return
                })
            }
        }
        
    }
    
    
}

