//
//  HWEyeOpenView.swift
//  Partner-Swift
//
//  Created by hw500028 on 15/2/27.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit
protocol HWEyeOpenViewDelegate:NSObjectProtocol
{
    func hwEyeOpenSate()->Void
    func hwEyeCloseSate()->Void
}
class HWEyeOpenView: UIView {
    var eyeOpenBtn:UIButton?
    var delegate:HWEyeOpenViewDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        eyeOpenBtn = UIButton.newAutoLayoutView()
        self.addSubview(eyeOpenBtn!)
        eyeOpenBtn!.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: 15)
        eyeOpenBtn!.autoSetDimensionsToSize(CGSize(width: 20, height: 10))
        eyeOpenBtn!.setBackgroundImage(UIImage(named: "eye_close"), forState: UIControlState.Selected)
        eyeOpenBtn!.selected = true
        eyeOpenBtn!.autoAlignAxisToSuperviewAxis(ALAxis.Horizontal)
        eyeOpenBtn!.addTarget(self, action: "btnClick:", forControlEvents: UIControlEvents.TouchUpInside)
        
        //线
        let line = UIView.newAutoLayoutView()
        self.addSubview(line)
        line.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0), excludingEdge: ALEdge.Right)
        line.autoSetDimension(ALDimension.Width, toSize: 0.5)
        line.backgroundColor = CD_LineColor
        
        
    }
    
    
    //MARK:----actions
    func btnClick(btn:UIButton)->Void
    {
        btn.selected = !btn.selected
        if btn.selected == true
        {
            eyeOpenBtn?.setBackgroundImage(UIImage(named: "eye_close"), forState: UIControlState.Selected)
            if (delegate != nil && delegate?.respondsToSelector("hwEyeCloseSate") != false)
            {
                delegate?.hwEyeCloseSate()
            }
        }
        if btn.selected == false
        {
            eyeOpenBtn?.setBackgroundImage(UIImage(named: "eye_open"), forState: UIControlState.Normal)
            if (delegate != nil && delegate?.respondsToSelector("hwEyeOpenSate") != false)
            {
                delegate?.hwEyeOpenSate()
            }
        }
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
