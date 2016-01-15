//
//  HWNewDetailView.swift
//  Partner-Swift
//
//  Created by zhangxun on 15/3/2.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWNewDetailView: UIView {
    var countLabel : UILabel!
    var titleLabel : UILabel!
    
    init(frame: CGRect, title:String, count:String) {
        super.init(frame: frame)
        
        countLabel = UILabel(frame: CGRectMake(0, 7, frame.size.width, frame.size.height / 2.0 - 5))
        countLabel.textColor = CD_Txt_MainColor
        countLabel.text = count
        countLabel.textAlignment = NSTextAlignment.Center
        countLabel.font = Define.font(16)
        self.addSubview(countLabel)
        
        titleLabel = UILabel(frame: CGRectMake(0, frame.size.height / 2.0, frame.size.width, frame.size.height / 2.0 - 5))
        titleLabel.textColor = CD_Txt_Color_66
        titleLabel.text = title
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.font = Define.font(13)
        self.addSubview(titleLabel)
        
        var lineV1 =  UIView(frame:CGRectMake(0, 0, frame.size.width, 0.5))
        lineV1.backgroundColor = CD_LineColor
        self.addSubview(lineV1)
        
        var lineV2 =  UIView(frame:CGRectMake(0, frame.size.height - 0.5, frame.size.width, 0.5))
        lineV2.backgroundColor = CD_LineColor
        self.addSubview(lineV2)
        if (frame.origin.x != 0) {
            var lineV =  UIView(frame:CGRectMake(0, 0, 0.5, frame.size.height))
            lineV.backgroundColor = CD_LineColor
            self.addSubview(lineV)
            
        }
        self.backgroundColor = UIColor.whiteColor()
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
