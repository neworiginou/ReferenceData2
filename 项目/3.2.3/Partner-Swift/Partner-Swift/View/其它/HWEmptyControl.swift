//
//  HWEmptyControl.swift
//  Partner-Swift
//
//  Created by caijingpeng.haowu on 15/3/6.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

typealias onClickBlock = () -> Void

class HWEmptyControl: UIView {

    var block: onClickBlock?
    
    init(frame: CGRect, titleStr: String, imageName: String?, click: onClickBlock?)
    {
        super.init(frame: frame)
        
        self.block = click
        
        if (imageName != nil)
        {
            let imgView: UIImageView = UIImageView(image: UIImage(named: imageName!))
            imgView.center = CGPointMake(frame.size.width / 2.0, frame.size.height / 2.0 - 40)
            self.addSubview(imgView)
            
            let titleLabel: UILabel = UILabel(frame: CGRectMake(0, (frame.size.height) / 2.0, frame.size.width, 30))
            titleLabel.textAlignment = NSTextAlignment.Center
            titleLabel.textColor = CD_Txt_Color_99
            titleLabel.text = titleStr
            titleLabel.font = Define.font(TF_13)
            self.addSubview(titleLabel)
        }
        else
        {
            let titleLabel: UILabel = UILabel(frame: CGRectMake(0, (frame.size.height - 30) / 2.0, frame.size.width, 30))
            titleLabel.textAlignment = NSTextAlignment.Center
            titleLabel.textColor = CD_Txt_Color_66
            titleLabel.text = titleStr
            titleLabel.font = Define.font(TF_13)
            self.addSubview(titleLabel)
        }
        
        let button: UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        button.frame = self.bounds
        button.addTarget(self, action: "clickAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(button)
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func clickAction(sender: UIButton) -> Void
    {
        if self.block != nil
        {
            self.block!()
        }
    }
    
}
