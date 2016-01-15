//
//  HWHTTPRequestOperationManager.swift
//  SwiftTest
//
//  Created by caijingpeng.haowu on 15/2/2.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：网络请求类 包含 接口加密，及返回数据的基本处理功能
//
//  修改记录：
//      姓名         日期               修改内容
//     蔡景鹏     2015-02-11           创建文件
//


import Foundation

// 请求链接

//let kBaseUrl = "http://service.haowu.com:210"
//let kConsultUrl = "http://service.haowu.com:210"         //广告URL
//let cityUrl = "http://service.haowu.com:210"

////let kBaseUrl = "http://172.16.10.97:8080"
let kBaseUrl = "http://172.16.10.105:8080"
////let kBaseUrl = "http://ios10.haowu.com:210"
//let kConsultUrl = "http://ios10.haowu.com:210"         //广告URL
//let cityUrl = "http://ios10.haowu.com:210"
//let kBaseImageUrl = "http://172.16.10.29:8080"
////let kBaseUrl = "http://172.16.24.35:8080"
//let kBaseUrl = "http://172.16.14.202:8080"

//let kBaseImageUrl = "http://172.16.10.29:8080"
//测试
//let kBaseImageUrl = "http://101.251.108.107:94"


//审核环境
//let kBaseImageUrl = "http://image.haowu.com"
//let kBaseUrl = "http://ios10.haowu.com:210"
//let kConsultUrl = "http://ios10.haowu.com:210"         //广告URL
//let cityUrl = "http://ios10.haowu.com:210"


//审核环境--内测
//let kBaseImageUrl = "http://image.haowu.com"
//let kBaseUrl = "http://ios14.haowu.com:210"
//let kConsultUrl = "http://ios14.haowu.com:210"         //广告URL
//let cityUrl = "http://ios14.haowu.com:210"

//13
//let kBaseUrl = "http://172.16.10.13"
let kConsultUrl = "http://172.16.10.13"         //广告URL
let cityUrl = "http://172.16.10.13"
let kBaseImageUrl = "http://172.16.10.13"

//测试
//let kBaseImageUrl = "http://101.251.108.107:94"
//let kBaseUrl = "http://ios14.haowu.com:210"
//let kConsultUrl = "http://ios14.haowu.com:210"         //广告URL
//let cityUrl = "http://ios14.haowu.com:210"
//let kBaseImageUrl = "http://101.251.108.107:94"
//let kBaseUrl = "http://ios14.haowu.com:210"
//let kConsultUrl = "http://ios14.haowu.com:210"         //广告URL
//let cityUrl = "http://ios14.haowu.com:210"

//
//let kBaseUrl = "http://service.haowu.com:210"
//let kConsultUrl = "http://service.haowu.com:210"         //广告URL
//let cityUrl = "http://service.haowu.com:210"
//let kBaseImageUrl = "http://101.251.108.107:94"

// 超时时间
let kTimeOut = 15.0


// 请求成功 状态码
let kStatusSuccess: Int = 1

//请求成功 状态吗（客户录入相同手机号请求成功状态码）
let kLogginStatusSucess:Int = 2
// 未登录 状态吗
let kStatusLogout: Int = -99
// 请求失败
let kStatusFailure: Int = 404

// 请求失败 文案
let kFailureDetail: String = "网络未连接"


class HWHttpRequestOperationManager : AFHTTPRequestOperationManager {
    
    // MARK: -    初始化方法
    
/**
 *	@brief	初始化方法
 *
 *	@param
 *
 *	@return
 */
    class func baseManager() -> HWHttpRequestOperationManager!
    {
        return HWHttpRequestOperationManager(baseURL: NSURL(string: kBaseUrl))
    }
/**
*	@brief	获取城市列表初始化方法
*
*	@param
*
*	@return
*/
    class func cityManager() -> HWHttpRequestOperationManager!
    {
        return HWHttpRequestOperationManager(baseURL: NSURL(string: cityUrl))
    }
    
    
    
    // MARK: -    接口加密
    
/**
 *	@brief	接口加密 根据参数返回 加密字符串
 *
 *	@param
 *
 *	@return
 */
    func encrypt(parameters: NSDictionary) -> NSString!
    {
        var sign: NSMutableString = NSMutableString()
        
        var paramArr: NSArray = parameters.allKeys;
        
        paramArr.sortedArrayUsingComparator { (obj1: AnyObject!, obj2: AnyObject!) -> NSComparisonResult in
            let str1: NSString = obj1 as NSString
            let str2: NSString = obj2 as NSString
            let result: NSComparisonResult = str1.compare(str2)
            return result
        }
        
        for var i = 0; i < paramArr.count; i++
        {
            let key: NSString = paramArr.objectAtIndex(i) as NSString
            sign.appendFormat("%@%@", key, parameters.objectForKey(key) as NSString)
        }
        
        sign.appendString("F2B4E48EA7BA64578152D5EF3AB0F70FEB0E978F")
        
        let md5Str = (sign as String).md5
        
        let data = md5Str.uppercaseString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        
        let codeStr = NSString(data: Base64.encodeData(data!), encoding: NSUTF8StringEncoding)
        
        return codeStr
    }
    
    // MARK: -    post 请求
    
/**
 *	@brief	post 请求
 *
 *	@param
 *
 *	@return
 */
    func postHttpRequest(urlString: NSString, parameters: NSDictionary?, queue: NSOperationQueue?, success: ((NSDictionary!) -> Void)!, failure: ((NSString!, NSString!) -> Void)!) ->AFHTTPRequestOperation!
    {
        var paramDic: NSMutableDictionary
        if parameters == nil
        {
            paramDic = NSMutableDictionary()
        }
        else
        {
            paramDic = NSMutableDictionary(dictionary: parameters!);
        }

        //paramDic.setObject(Utility_OC.encryptParameter(paramDic), forKey: "digest")
        
        var maybeError: NSError?
        
//        self.requestSerializer.HTTPShouldHandleCookies = true;
        self.requestSerializer.HTTPShouldHandleCookies = false
        
        let request: NSMutableURLRequest = self.requestSerializer.requestWithMethod("POST", URLString: NSURL(string: urlString, relativeToURL: self.baseURL)?.absoluteString, parameters: paramDic, error: &maybeError)
        request.timeoutInterval = kTimeOut
       // request.HTTPShouldHandleCookies = true;
        request.HTTPShouldHandleCookies = false;
        println("request: \(request) 参数: \(paramDic) error: \(maybeError)")
        
        var operation: AFHTTPRequestOperation? = self.HTTPRequestOperationWithRequest(request, success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
            
//            let parser: SBJsonParser? = SBJsonParser()
//            let dict: NSDictionary? = parser!.objectWithData(responseObject as NSData) as NSDictionary
            let dict: NSDictionary? = responseObject as? NSDictionary
            
            if dict == nil
            {
                success(dict)
                
            }
            else
            {
                let status = dict!.objectForKey("status")?.integerValue
                
                let statusStr = dict!.objectForKey("status") as NSString
                
                
                //println("返回数据: \(dict)")
                
                if (status == kStatusSuccess)
                {
                    // 请求成功
                    if (success != nil)
                    {
                        success(dict)
                    }
                }
                else
                {
                    // 请求失败
                    if (failure != nil)
                    {
                        if (status == kStatusLogout)
                        {
                            // 未登录
                            //MYP add v3.2.1
                            shareAppDelegate.loginCtrl = HWLoginViewController()
                            shareAppDelegate.loginNav = HWBaseNavigationController(rootViewController:shareAppDelegate.loginCtrl!)
                            var loginNav = HWBaseNavigationController(rootViewController:shareAppDelegate.loginCtrl!)
                            Utility.transController(currentNav, newCtrl: loginNav)

                        }
                        else
                        {
                            let detail = dict!.stringObjectForKey("detail") as NSString
                            failure(statusStr, detail)
                        }
                    }
                }
            }
            
            
            
            }, failure: {(operation: AFHTTPRequestOperation!, error: NSError!) in
            println("请求出错: " + error.localizedDescription)
            failure(NSString(format: "%d", kStatusFailure), kFailureDetail)
        })
        
        if (queue == nil)
        {
            self.operationQueue.addOperation(operation!)
        }
        else
        {
            queue!.addOperation(operation!);
        }
        
        return operation
    }
    
    
    /**
    *	@brief	post 请求
    *
    *	@param
    *
    *	@return
    */
    func postLogginHttpRequest(urlString: NSString, parameters: NSDictionary?, queue: NSOperationQueue?, success: ((NSDictionary!) -> Void)!, failure: ((NSString!, NSString!) -> Void)!) ->AFHTTPRequestOperation!
    {
        var paramDic: NSMutableDictionary
        if parameters == nil
        {
            paramDic = NSMutableDictionary()
        }
        else
        {
            paramDic = NSMutableDictionary(dictionary: parameters!);
        }
        
        paramDic.setObject(Utility_OC.encryptParameter(paramDic), forKey: "digest")
        var maybeError: NSError?
        let request: NSMutableURLRequest = self.requestSerializer.requestWithMethod("POST", URLString: NSURL(string: urlString, relativeToURL: self.baseURL)?.absoluteString, parameters: paramDic, error: &maybeError)
        request.timeoutInterval = kTimeOut
        request.HTTPShouldHandleCookies = false;

//        println("request: \(request) 参数: \(paramDic) error: \(maybeError)")
        
        var operation: AFHTTPRequestOperation? = self.HTTPRequestOperationWithRequest(request, success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
            
            //            let parser: SBJsonParser? = SBJsonParser()
            //            let dict: NSDictionary? = parser!.objectWithData(responseObject as NSData) as NSDictionary
            let dict: NSDictionary? = responseObject as? NSDictionary
            
            if dict == nil
            {
                success(dict)
                
            }
            else
            {
                let status = dict!.objectForKey("status")?.integerValue
                
                let statusStr = dict!.objectForKey("status") as NSString
                
                
//                println("返回数据: \(dict)")
                
                if (status == kStatusSuccess)
                {
                    // 请求成功
                    if (success != nil)
                    {
                        success(dict)
                    }
                }
                else if(status == kLogginStatusSucess)
                {
                    // 请求成功
                    if (success != nil)
                    {
                        success(dict)
                    }
                    
                }
                else
                {
                    // 请求失败
                    if (failure != nil)
                    {
                        if (status == kStatusLogout)
                        {
                            // 未登录
                            //MYP add v3.2.1
                            shareAppDelegate.loginCtrl = HWLoginViewController()
                            shareAppDelegate.loginNav = HWBaseNavigationController(rootViewController:shareAppDelegate.loginCtrl!)
                            var loginNav = HWBaseNavigationController(rootViewController:shareAppDelegate.loginCtrl!)
                            Utility.transController(currentNav, newCtrl: loginNav)

                        }
                        else
                        {
                            let detail = dict!.objectForKey("detail") as NSString
                            failure(statusStr, detail)
                        }
                    }
                }
            }
            
            
            
            }, failure: {(operation: AFHTTPRequestOperation!, error: NSError!) in
//                println("请求出错: " + error.localizedDescription)
                failure(NSString(format: "%d", kStatusFailure), kFailureDetail)
        })
        
        if (queue == nil)
        {
            self.operationQueue.addOperation(operation!)
        }
        else
        {
            queue!.addOperation(operation!);
        }
        
        return operation
    }
    // MARK: -    get 请求
/**
 *	@brief	get 请求
 *
 *	@param
 *
 *	@return
 */
    func getHttpRequest(urlString: NSString, parameters: NSDictionary, success: ((AnyObject!) -> Void)!, failure: ((NSString!, NSString!) -> Void)!) ->AFHTTPRequestOperation!
    {
        let paramDic: NSMutableDictionary = NSMutableDictionary(dictionary: parameters);
        paramDic.setObject("1", forKey: "appUrlVersion");
        
        let request: NSMutableURLRequest = self.requestSerializer.requestWithMethod("GET", URLString: urlString, parameters: paramDic, error: nil)
        request.timeoutInterval = kTimeOut
        
        let operation: AFHTTPRequestOperation = self.HTTPRequestOperationWithRequest(request, success: { (operation, responseObject) -> Void in
            
            let parser = SBJsonParser()
            
            let dict: NSDictionary? = parser.objectWithData(responseObject as NSData) as? NSDictionary
            
            let status = dict!.objectForKey("status")?.integerValue
            
            let statusStr = dict!.objectForKey("status") as NSString
            let detail = dict!.objectForKey("detail") as NSString
            
            if (status == kStatusSuccess)
            {
                // 请求成功
                if (success != nil)
                {
                    success(dict)
                }
            }
            else
            {
                // 请求失败
                if (failure != nil)
                {
                    if (status == kStatusLogout)
                    {
                        // 未登录
                        //MYP add v3.2.1
                        shareAppDelegate.loginCtrl = HWLoginViewController()
                        shareAppDelegate.loginNav = HWBaseNavigationController(rootViewController:shareAppDelegate.loginCtrl!)
                        var loginNav = HWBaseNavigationController(rootViewController:shareAppDelegate.loginCtrl!)
                        Utility.transController(currentNav, newCtrl: loginNav)

                    }
                    else
                    {
                        failure(statusStr, detail)
                    }
                }
            }
            
            }) { (operation, error) -> Void in
                
                failure(NSString(format: "%d", kStatusFailure), kFailureDetail)
        }
        
        return operation
    }
    
/**
 *	@brief	上传图片请求
 *
 *	@param
 *
 *	@return	
 */
    func postImageHttpRequest(urlString: NSString, parameters: NSDictionary, queue: NSOperationQueue?, success: ((AnyObject!) -> Void)!, failure: ((NSString!, NSString!) -> Void)!) ->AFHTTPRequestOperation!
    {
        let paramDic: NSMutableDictionary = NSMutableDictionary(dictionary: parameters);
//        paramDic.setObject("1", forKey: "appUrlVersion");
//        paramDic.setObject(encrypt(paramDic), forKey: "digest")
        
        var maybeError: NSError?
//        let request: NSMutableURLRequest = self.requestSerializer.requestWithMethod("POST", URLString: NSURL(string: urlString, relativeToURL: self.baseURL)?.absoluteString, parameters: paramDic, error: &maybeError)
//        request.timeoutInterval = kTimeOut
//        self.requestSerializer.multipartFormRequestWithMethod(<#method: String!#>, URLString: <#String!#>, parameters: <#[NSObject : AnyObject]!#>, constructingBodyWithBlock: <#((AFMultipartFormData!) -> Void)!##(AFMultipartFormData!) -> Void#>, error: <#NSErrorPointer#>)
        
        self.requestSerializer.HTTPShouldHandleCookies = false
        
        let request: NSMutableURLRequest = self.requestSerializer.multipartFormRequestWithMethod("POST", URLString: NSURL(string: urlString, relativeToURL: self.baseURL)?.absoluteString, parameters: paramDic, constructingBodyWithBlock: { (formData) -> Void in
            
            for dictKey in (paramDic.allKeys as NSArray)
            {
                let string: NSString! = dictKey as NSString
                if (string.isEqualToString("pubFile") == true || string.isEqualToString("file") == true)
                {
                    let paths: NSArray! = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
                    let documentsDirectory: NSString! = paths.objectAtIndex(0) as NSString
                    let savedImagePath = documentsDirectory .stringByAppendingPathComponent("\(string).jpg")
                    let imageData: NSData = paramDic.objectForKey(string) as NSData
                    
                    imageData.writeToFile(savedImagePath, atomically: true)
                    formData.appendPartWithFileData(imageData, name: string, fileName: savedImagePath, mimeType: "image/jpeg")
                }
            }
            
        }, error: &maybeError)
        
        request.HTTPShouldHandleCookies = false
        
//        println("post image request: \(request) 参数: \(paramDic) error: \(maybeError)")
        
        var operation: AFHTTPRequestOperation? = self.HTTPRequestOperationWithRequest(request, success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
            
            //            let parser: SBJsonParser? = SBJsonParser()
            //            let dict: NSDictionary? = parser!.objectWithData(responseObject as NSData) as NSDictionary
            let dict: NSDictionary? = responseObject as? NSDictionary
            
            let status = dict!.objectForKey("status")?.integerValue
            
            let statusStr = dict!.objectForKey("status") as NSString
            let detail = dict!.objectForKey("detail") as NSString
            
            println("返回数据: \(dict)")
            
            if (status == kStatusSuccess)
            {
                // 请求成功
                if (success != nil)
                {
                    success(dict)
                }
            }
            else
            {
                // 请求失败
                if (failure != nil)
                {
                    if (status == kStatusLogout)
                    {
                        // 未登录
                        //MYP add v3.2.1
                        shareAppDelegate.loginCtrl = HWLoginViewController()
                        shareAppDelegate.loginNav = HWBaseNavigationController(rootViewController:shareAppDelegate.loginCtrl!)
                        var loginNav = HWBaseNavigationController(rootViewController:shareAppDelegate.loginCtrl!)
                        Utility.transController(currentNav, newCtrl: loginNav)

                    }
                    else
                    {
                        failure(statusStr, detail)
                    }
                }
            }
            
            }, failure: {(operation: AFHTTPRequestOperation!, error: NSError!) in
//                println("请求出错: " + error.localizedDescription)
                failure(NSString(format: "%d", kStatusFailure), kFailureDetail)
        })
        
        if (queue == nil)
        {
            self.operationQueue.addOperation(operation!)
        }
        else
        {
            queue!.addOperation(operation!);
        }
        
        return operation
    }
    
}
