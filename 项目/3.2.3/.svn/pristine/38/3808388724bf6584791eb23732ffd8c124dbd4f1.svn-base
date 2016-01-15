//
//  HWLocationManager.swift
//  Partner-Swift
//
//  Created by caijingpeng.haowu on 15/2/11.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：定位管理类， 此类为单例，提供定位方法 定位成功后可从变量中获取 定位坐标及城市信息
//
//  修改记录：
//      姓名         日期               修改内容
//     蔡景鹏     2015-02-11           创建文件
//

import Foundation
import CoreLocation
struct locationStruct {
    
     var log:String?
     var lat:String?
    init(loca:CLLocationCoordinate2D){
       log = "\(loca.longitude)"
       lat = "\(loca.latitude)"
    }
}


class HWLocationManager: NSObject, CLLocationManagerDelegate {
    
    var manager: CLLocationManager? = nil
    
    // 定位坐标
    var coordinate: CLLocationCoordinate2D? = nil
    
    // 定位城市
    var cityName: NSString = NSString()
    
    // 定位地址
    var locationAddress: NSString? = nil
    var isLocationSuccess = false
    var locationSuccess:((loc:locationStruct,cityName:NSString) -> ())?
   
    var locationFailure:(() -> ())?
    /**
    *	@brief	单例 初始化方法
    *
    *	@param 	 nil
    *
    *	@return
    */
    class func shareManager() -> HWLocationManager
    {
        struct YRSingleton
        {
            static var predicate: dispatch_once_t = 0
            static var instance: HWLocationManager? = nil
        }
        dispatch_once(&YRSingleton.predicate, {
            YRSingleton.instance = HWLocationManager()
        }
        )
        return YRSingleton.instance!
    }
    
    /**
    *	@brief	定位
    *
    *	@param 	 nil
    *
    *	@return
    */
    func startLoacting() -> Bool
    {
        if (CLLocationManager.locationServicesEnabled())
        {
            self.manager = CLLocationManager()
            self.manager?.desiredAccuracy = kCLLocationAccuracyBest
            self.manager?.delegate = self;
            self.manager?.distanceFilter = kCLLocationAccuracyKilometer
            
            if (iOS8)
            {
//                self.manager?.requestAlwaysAuthorization()
                self.manager?.requestWhenInUseAuthorization()
            }
            
            self.manager?.startUpdatingLocation()
            return true
        }
        return false
    }
    
    /**
    *	@brief	定位回调 成功后返回 城市信息 及 当前坐标
    *
    *	@param
    *
    *	@return
    */
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        let location = locations.last as CLLocation
        self.coordinate = location.coordinate
        var geocoder = CLGeocoder()
        var p:CLPlacemark?
        isLocationSuccess = true
//        println(location)
        
        NSNotificationCenter.defaultCenter().postNotificationName(kLocationSuccessNotification, object: nil)
        
        geocoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            if error != nil
            {
                println("reverse geodcode fail: \(error.localizedDescription)")
                return
            }
            let pm = placemarks as [CLPlacemark]
            if (pm.count > 0)
            {
                p = placemarks[0] as? CLPlacemark
//                self.cityName = p?.addressDictionary["State"] as NSString
                if (p != nil)
                {
                    self.cityName = "\(p!.locality)"
                    
                    if (self.cityName.hasSuffix("市辖区"))
                    {
                        var range: NSRange = self.cityName.rangeOfString("市辖区")
                        self.cityName = self.cityName.substringToIndex(range.location)
                    }
                    
                }
                
                println("\(p?.addressDictionary) ***** \(p?.locality)")
                let address: NSArray! = p?.addressDictionary["FormattedAddressLines"] as NSArray
                self.locationAddress = address.pObjectAtIndex(0) as? NSString
                println("定位城市 \(self.cityName) \(self.locationAddress)")
                
            }
            else
            {
                println("No Placemarks!")
            }
            
        })
        
//        println("coordinate = \(coordinate?.latitude)")
        locationStruct(loca: coordinate!)
        locationSuccess?(loc: locationStruct(loca: coordinate!),cityName:self.cityName)
        self.manager?.stopUpdatingLocation()

    }
    
    /**
    *  定位失败方法
    *
    *  @param CLLocationManager!
    *  @param NSError!
    *
    *  @return
    */
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        
        self.coordinate = nil
        
        isLocationSuccess = false
        locationFailure?()
    }
    
    
  class  func saveLocation(loc:CLLocationCoordinate2D?)
    {
        
        if loc != nil
        {
            if HWUserLogin.currentUserLogin().key.isEmpty == false
            {
                var params = NSMutableDictionary()
                params.setPObject("\(loc!.latitude)", forKey: "latitude")
                params.setPObject("\(loc!.longitude)", forKey: "longitude")
                params .setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
                var manager = HWHttpRequestOperationManager.baseManager()
                manager.postHttpRequest(kSaveLaLongitude, parameters: params, queue: nil, success: { (responseObject) -> Void in
                    
                    println("定位成功")
                    
                    }, failure: { (code, error) -> Void in
                   
                        println("定位失败")
                })
                
            }
        }

        }

    
}

