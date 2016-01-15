//
//  HWUpMessageRegisterView.swift
//  Partner-Swift
//
//  Created by hw500028 on 15/2/27.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit
class HWUpMessageRegisterBtn: UIView {
    var upMessageBtn:UIButton?
    override init(frame: CGRect) {
        super.init(frame: frame)
        upMessageBtn = UIButton.newAutoLayoutView()
        self.addSubview(upMessageBtn!)
        upMessageBtn!.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: 0)
        upMessageBtn!.autoAlignAxisToSuperviewAxis(ALAxis.Horizontal)
        upMessageBtn?.autoSetDimension(ALDimension.Height, toSize: 30)
        var attributeStr = NSMutableAttributedString(string: "没有收到验证码,点此上行短信验证 ")
        upMessageBtn!.setAttributedTitle(attributeStr, forState: UIControlState.Normal)
        attributeStr.addAttribute(NSUnderlineStyleAttributeName, value: NSNumber(integer: NSUnderlineStyle.StyleSingle.rawValue), range: NSMakeRange(8, 8))
        attributeStr.addAttribute(NSUnderlineColorAttributeName, value: UIColor.blackColor(), range: NSMakeRange(8, 9))
        upMessageBtn?.backgroundColor = UIColor.clearColor()
        upMessageBtn?.titleLabel?.font = Define.font(TF_13)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
