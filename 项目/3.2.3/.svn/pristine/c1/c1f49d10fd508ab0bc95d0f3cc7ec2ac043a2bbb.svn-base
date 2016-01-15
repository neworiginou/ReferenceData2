//
//  UILabelExtension.swift
//  Partner-Swift
//
//  Created by caijingpeng.haowu on 15/2/15.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：UILabel 的扩展  添加设置行间距 调用之前要先设置好text ，attributeText不适用,冲突
//
//  修改记录：
//      姓名         日期               修改内容
//     蔡景鹏     2015-02-15           创建文件
//

import Foundation

extension UILabel {

/**
 *	@brief	设置行间距
 *
 *	@param
 *
 *	@return
 */
    func setLineSpacing(space: CGFloat) -> Void
    {
        if (self.text == nil)
        {
            return
        }
        var attributedString = NSMutableAttributedString(string: self.text!)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = space
        attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, NSString(string: self.text!).length))
        attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, NSString(string: self.text!).length))
        self.attributedText = attributedString
    }
    
}
