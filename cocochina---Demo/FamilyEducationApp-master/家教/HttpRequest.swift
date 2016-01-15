//
//  HttpRequest.swift
//  家教
//
//  Created by goofygao on 15/11/12.
//  Copyright © 2015年 goofyy. All rights reserved.
//

import Foundation
//import Alamofire


protocol HttpProtocol{
    func didReceiveResults(result:NSMutableArray)
}

class HttpRequest:NSObject{
    var studentStatus:NSMutableArray?
    var delegate:HttpProtocol?
    
    func loadNewData(pageNumber:Int) {
        
        let manager = AFHTTPRequestOperationManager()
        manager.responseSerializer.acceptableContentTypes = NSSet(object: "text/html") as Set<NSObject>
        let params:NSDictionary = ["num":"\(pageNumber)"]
        manager.POST("http://115.29.54.119:888/Post/requryInfo", parameters: params, success: { (operation, response) -> Void in
            let responseDic = response as? NSDictionary
            let dictArr:NSArray = (responseDic!["stu"] as? NSArray)!
            let array = [Student]()
            self.studentStatus = NSMutableArray(array: array)
            for var dict in dictArr {
                let studentBody = Student(dict: dict as! [NSObject : AnyObject])
                self.studentStatus?.addObject(studentBody)
                
                
            }
            self.delegate?.didReceiveResults(self.studentStatus!)
            
            }) { (operation, error) -> Void in
                
        }
        
    }
}

