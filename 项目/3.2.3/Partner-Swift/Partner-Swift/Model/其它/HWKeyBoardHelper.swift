//
//  HWKeyBoardHelper.swift
//  Partner-Swift
//
//  Created by caijingpeng.haowu on 15/3/5.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：动态跟踪键盘位置
//
//  修改记录：
//      姓名         日期               修改内容
//     蔡景鹏     2015-03-05           创建文件
//

import UIKit

class HWKeyBoardHelper: NSObject {
    
    var observerArray: NSMutableArray? // 保存 指定view  初始坐标 及 y轴偏移量
   
    class func shareInstance() -> HWKeyBoardHelper
    {
        struct KBSingleton
        {
            static var predicate: dispatch_once_t = 0
            static var instance: HWKeyBoardHelper? = nil
        }
        dispatch_once(&KBSingleton.predicate, {
            
            KBSingleton.instance = HWKeyBoardHelper()
            KBSingleton.instance?.addKeyBoardObserver()
            KBSingleton.instance?.observerArray = NSMutableArray()
            }
        )
        return KBSingleton.instance!
    }
    
    func addKeyBoardObserver() -> Void
    {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWasShown:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWasHidden:", name: UIKeyboardWillHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillChangeFrame:", name: UIKeyboardWillChangeFrameNotification, object: nil)
    }
    
    func removeKeyBoardObserver() -> Void
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillChangeFrameNotification, object: nil)
    }
    
/**
 *	@brief	添加绑定view
 *
 *	@param 	view	绑定的view
 *	@param 	y       指定 view 与键盘的距离 如果 y<0 则紧贴键盘高度  y>0 则只会保持在键盘上部
 *
 *	@return
 */
    func addObserver(view: UIView?, keyBoardOffsetY y: CGFloat)
    {
//        println(self.observerArray)
        if (view != nil)
        {
            let dic = NSDictionary(objectsAndKeys:
                view!, "target" as NSString,
                Utility_OC.valueWithPoint(view!.center), "center" as NSString,
                Utility_OC.numberWithFloat(y), "offset" as NSString)
            self.observerArray?.addObject(dic)
        }
    }
    
    func removeObserver() -> Void
    {
        self.observerArray?.removeAllObjects()
    }
    
    func keyboardWasShown(notification: NSNotification) -> Void
    {
        let info: NSDictionary = notification.userInfo! as NSDictionary
        let value: NSValue = info.objectForKey(UIKeyboardFrameEndUserInfoKey) as NSValue
        let keyboardSize: CGSize = value.CGRectValue().size
        self.reloadFrame(value.CGRectValue())
    }
    
    func keyboardWasHidden(notification: NSNotification) -> Void
    {
        let info: NSDictionary = notification.userInfo! as NSDictionary
        let value: NSValue = info.objectForKey(UIKeyboardFrameEndUserInfoKey) as NSValue
        let keyboardSize: CGSize = value.CGRectValue().size
        self.reloadFrame(value.CGRectValue())
    }
    
    func keyboardWillChangeFrame(notification: NSNotification) -> Void
    {
        let info: NSDictionary = notification.userInfo! as NSDictionary
        let value: NSValue = info.objectForKey(UIKeyboardFrameEndUserInfoKey) as NSValue
        let keyboardSize: CGSize = value.CGRectValue().size
        self.reloadFrame(value.CGRectValue())
    }
    
    func reloadFrame(keyboardSize: CGRect) -> Void
    {
        // 遍历 是否有第一响应者  如果有 再去 操作
//        println(self.observerArray)
        for (var i = 0; i < self.observerArray!.count; i++)
        {
            let dict = self.observerArray?.objectAtIndex(i) as NSDictionary
            
            var view: UIView? = dict.objectForKey("target") as? UIView
            var offsetY: Float = (dict.objectForKey("offset") as NSNumber).floatValue
            var originCenter: CGPoint = (dict.objectForKey("center") as NSValue).CGPointValue()
            var superView = view?.superview?
            
            if (view != nil && superView != nil)
            {
                var hasFirstResp: Bool = false
                
                if (view!.isFirstResponder() == false)
                {
                    for (var j = 0; j < view?.subviews.count; j++)
                    {
                        //遍历
                        
                        let subview: UIView = (view!.subviews as NSArray).objectAtIndex(j) as UIView
                        if subview.isFirstResponder() == true
                        {
                            hasFirstResp = true
                            break
                        }
                    }
                }
                else
                {
                    hasFirstResp = true
                }
                
                if (hasFirstResp == true)
                {
                    // 如果包含第一响应者
                    var expectWindowPosY: CGFloat = keyboardSize.origin.y - view!.frame.size.height / 2.0 - max(0, CGFloat(offsetY))
                    var viewPos: CGPoint? = shareAppDelegate.window?.convertPoint(CGPointMake(0, expectWindowPosY), toView: superView!)
                    
//                    println("\(keyboardSize) \n \(UIScreen.mainScreen().bounds)")
                    
                    if (offsetY < 0 || view?.center.y > viewPos?.y)
                    {
                        view!.center = CGPointMake(view!.center.x, viewPos!.y)
                    }
                    else if (CGRectGetMinY(keyboardSize) >= UIScreen.mainScreen().bounds.size.height)
                    {
                        view!.center = originCenter
                    }
                }
                else
                {
                    view?.center = originCenter
                }
                
            }
        }
    }
    
    deinit
    {
        self.removeKeyBoardObserver()
    }
    
}
