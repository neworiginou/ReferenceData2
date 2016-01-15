//
//  UIButtonExtension.swift
//  Partner-Swift
//
//  Created by caijingpeng.haowu on 15/2/16.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：UIButton 的扩展  添加公共样式
//
//  修改记录：
//      姓名         日期               修改内容
//     蔡景鹏     2015-02-15           创建文件
//

import Foundation

extension UIButton
{
/**
 *	@brief	灰色边框样式
 *
 *	@param
 *
 *	@return
 */
    func setButtonGrayBorderStyle() -> Void
    {
        self.layer.borderColor = CD_LineColor.CGColor
        self.layer.borderWidth = lineHeight
    }
  
/**
 *	@brief	红橘色背景，圆角边框样式
 *
 *	@param
 *
 *	@return
 */
    func setButtonRedAndOrangeBorderStyle() -> Void
    {
        self.setTitleColor(CD_Txt_Color_ff, forState: UIControlState.Normal)
        self.layer.borderWidth = 0
        self.layer.cornerRadius = 3.5
        self.layer.masksToBounds = true
        self.titleLabel?.font = Define.font(20)
        self.setBackgroundImage(Utility.imageWithColor("#fa6721".UIColor, _size: self.frame.size), forState: UIControlState.Normal)
//        self.setImage(UIImage(named: "button_bg3"), forState: UIControlState.Normal)
    }
    
    
/**
 *	@brief	带阴影的按钮
 *
 *	@param
 *
 *	@return
 */
    func setButtonBackgroundShadowHighlight() -> Void
    {
//        self.setBackgroundImage(<#image: UIImage?#>, forState: <#UIControlState#>)
        self.layer.shadowColor = CD_MainColor.CGColor
        self.layer.shadowOffset = CGSizeMake(0, 2)
        self.layer.shadowRadius = 3;
        self.layer.shadowOpacity = 0.3
        self.backgroundColor = CD_MainColor
        
    }
    

/**
 *	@brief	灰色背景样式按钮
 *
 *	@param
 *
 *	@return	
 */
    func setButtonGrayStyle() -> Void
    {
        self.setBackgroundImage(Utility.imageWithColor(CD_Btn_GrayColor, _size: self.frame.size), forState: UIControlState.Normal)
        self.setBackgroundImage(Utility.imageWithColor(CD_Btn_GrayColor_Clicked, _size: self.frame.size), forState: UIControlState.Highlighted)
        self.setTitleColor(CD_Txt_Color_ff, forState: UIControlState.Normal)
        self.layer.cornerRadius = 3.0;
        self.layer.masksToBounds = true;
    }
    
}