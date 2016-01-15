//
//  HWIntegrationFitView.swift
//  Partner-Swift
//
//  Created by WeiYuanlin on 15/3/5.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
// 创建积分筛选按钮
//
// 魏远林    2015-03-05
//

import UIKit

protocol HWIntegrationFitViewDelegate
{
    func buttonIsClick(index:NSInteger)
}

class HWIntegrationFitView: UIView
{
    var titlesArr:[String]!
    var deletage:HWIntegrationFitViewDelegate?
    init(frame:CGRect, titles:[String])
    {
        super.init(frame: frame)
        titlesArr = titles
        for var i = 0;i < titles.count;i++
        {
            var button = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
            button.frame = CGRectMake(0, CGFloat(i) * 45.0, kScreenWidth, 45.0)
            button.backgroundColor = UIColor.clearColor()
            button.tag = 1000 + i
//            button.titleLabel?.text = titles[i] as String
            button.titleLabel?.font = Define.font(TF_14)
            button.setTitle(titlesArr[i], forState: UIControlState.Normal)
            button.titleEdgeInsets = UIEdgeInsetsMake(15, 15, 15, kScreenWidth - 60)
            button.setTitleColor(CD_Txt_Color_00, forState: UIControlState.Normal)
            button.addTarget(self, action: "btnIsClick:", forControlEvents: UIControlEvents.TouchUpInside)
            self.addSubview(button)
            
            var line = UIView(frame: CGRectMake(14, CGFloat(i + 1) * button.frame.size.height - 0.5, kScreenWidth - 14, 0.5))
            line.tag = 2000 + i
            line.backgroundColor = CD_LineColor
            self.addSubview(line)
            
            if i == 0
            {
                button.setTitleColor(CD_MainColor, forState: UIControlState.Normal)
                line.backgroundColor = CD_MainColor
            }
        }

    }
    
    func btnIsClick(sender:UIButton)
    {
        for var i = 0;i < titlesArr.count;i++
        {
            self.hidden = false
            var btn:UIButton = self.viewWithTag(i + 1000) as UIButton
            var line:UIView = self.viewWithTag(i + 2000) as UIView!
            
            if btn.tag == sender.tag
            {
                btn.selected = true
                btn.setTitleColor(CD_MainColor, forState: UIControlState.Selected)
                line.backgroundColor = CD_MainColor
                self.deletage?.buttonIsClick(i)
            }
            else
            {
                btn.selected = false
                btn.setTitleColor(CD_Txt_Color_00, forState: UIControlState.Normal)
                line.backgroundColor = CD_LineColor
            }
            
        }
        self.hidden = true
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
