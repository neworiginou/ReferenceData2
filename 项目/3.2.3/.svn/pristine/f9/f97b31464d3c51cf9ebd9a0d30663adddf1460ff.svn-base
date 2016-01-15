//
//  NSDictionaryExtension.swift
//  Partner-Swift
//
//  Created by caijingpeng.haowu on 15/2/11.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：字典 扩展类
//
//  修改记录：
//      姓名         日期               修改内容
//     蔡景鹏     2015-02-11           创建文件
//

import Foundation

extension NSDictionary {
    
/**
 *	@brief	字典取值 防止崩溃 及 返回类型错误
 *
 *	@param  aKey: NSCopying
 *
 *	@return	字符串
 */
    func stringObjectForKey(aKey: NSCopying) -> NSString
    {
        var obj: AnyObject? = self.objectForKey(aKey)
        
        if (obj == nil || obj?.isKindOfClass(NSNull) == true)
        {
            return ""
        }
        else
        {
            return NSString(string: "\(obj!)")
        }
    }
    
    /**
    *	@brief	字典取值 防止崩溃 及 返回类型错误
    *
    *	@param  aKey: NSCopying
    *
    *	@return	字典
    */
    
    func dictionaryObjectForKey(aKey: NSCopying) -> NSDictionary
    {
        var obj: AnyObject? = self.objectForKey(aKey)
        
        if (obj == nil || obj?.isKindOfClass(NSNull) == true || obj?.isKindOfClass(NSDictionary) == false)
        {
            return NSDictionary()
        }
        else
        {
            return obj as NSDictionary
        }
    }
    
    /**
    *	@brief	数组取值 防止崩溃 及 返回类型错误
    *
    *	@param  aKey: NSCopying
    *
    *	@return	数组
    */
    
    func arrayObjectForKey(aKey: NSCopying) -> NSArray
    {
        var obj: AnyObject? = self.objectForKey(aKey)
        
        if (obj == nil || obj?.isKindOfClass(NSNull) == true || obj?.isKindOfClass(NSArray) == false)
        {
            return NSArray()
        }
        else
        {
            var resultArr: NSMutableArray = NSMutableArray()
            var resourceArr: NSArray = obj as NSArray
            
            for (var i = 0; i < resourceArr.count; i++)
            {
                var arrObj: AnyObject? = resourceArr.pObjectAtIndex(i)
                if (arrObj != nil)
                {
                    resultArr.addObject(arrObj!)
                }
            }
            return resultArr
        }
        
    }
}

extension NSMutableDictionary {
    
    /**
    *	@brief	字典赋值 防止空类型崩溃
    *
    *	@param  anObject: AnyObject
    *	@param  aKey: NSCopying
    *
    *	@return
    */
    
    func setPObject(anObject: AnyObject?, forKey key: NSCopying) -> Void
    {
        if (anObject == nil)
        {
            self.setObject("", forKey: key)
        }
        else
        {
            self.setObject(anObject!, forKey: key)
        }
    }
    
}
