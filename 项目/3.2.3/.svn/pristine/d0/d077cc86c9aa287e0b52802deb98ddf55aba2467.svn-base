//
//  NSArrayExtension.swift
//  Partner-Swift
//
//  Created by caijingpeng.haowu on 15/2/11.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：数组 扩展类
//
//  修改记录：
//      姓名         日期               修改内容
//     蔡景鹏     2015-02-11           创建文件
//

import Foundation

extension NSArray {
    
/**
 *	@brief	防止数组越界导致崩溃
 *
 *	@param 	index
 *
 *	@return	AnyObject
 */
    func pObjectAtIndex(index: NSInteger) -> AnyObject?
    {
        if (index >= self.count || self.objectAtIndex(index).isKindOfClass(NSNull))
        {
            return nil
        }
        return self.objectAtIndex(index)
    }
    
}
