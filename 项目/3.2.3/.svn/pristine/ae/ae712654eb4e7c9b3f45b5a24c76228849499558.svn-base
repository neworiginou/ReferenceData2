//
//  UIViewExtension.swift
//  Partner-Swift
//
//  Created by caijingpeng.haowu on 15/2/15.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：UIView 的扩展
//
//  修改记录：
//      姓名         日期               修改内容
//     蔡景鹏     2015-02-15           创建文件
//

import Foundation

let topLineTag = 1000000
let bottomLineTag = 1000001

extension UIView {
    
/**
 *	@brief	画顶部线
 *
 *	@param
 *
 *	@return
 */
    func drawTopLine() -> Void
    {
        if (self.viewWithTag(topLineTag) != nil)
        {
            self.viewWithTag(topLineTag)?.removeFromSuperview()
        }
        
//        let width = self.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).width != 0 ? self.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).width : self.bounds.size.width
        var line: UIImageView! = UIImageView(forAutoLayout: ())
//        line.layer.masksToBounds = true
        line.tag = topLineTag
        self.addSubview(line)
        
        line.layer.masksToBounds = true
        line.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsMake(0, 0, 0, 0), excludingEdge: ALEdge.Bottom)
//        line.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: self, withOffset: 0)
//        line.autoSetDimension(ALDimension.Width, toSize: width)
        line.autoSetDimension(ALDimension.Height, toSize: lineHeight)
        
        line.image = Utility.imageWithColor(CD_LineColor, _size: CGSizeMake(1, 1))
        
//        line.autoMatchDimension(ALDimension.Width, toDimension: ALDimension.Width, ofView: self)
    }
    
/**
 *	@brief	画底部线
 *
 *	@param
 *
 *	@return
 */
    func drawBottomLine() -> Void
    {
        if (self.viewWithTag(bottomLineTag) != nil)
        {
            self.viewWithTag(bottomLineTag)?.removeFromSuperview()
        }
        var line: UIImageView! = UIImageView(forAutoLayout: ())
        line.tag = bottomLineTag
        self.addSubview(line)
        
        line.layer.masksToBounds = true
        line.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsMake(0, 0, 0, 0), excludingEdge: ALEdge.Top)
        line.autoSetDimension(ALDimension.Height, toSize: lineHeight)

        line.image = Utility.imageWithColor(CD_LineColor, _size: CGSizeMake(1, 1))
        
    }
}
