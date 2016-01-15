//
//  HWCountDowdLabel.swift
//  Partner-Swift
//
//  Created by hw500029 on 15/3/6.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWCountDownLabel: UILabel {

    var overTime:Int?
    var timer:NSTimer?
    
    init(frame:CGRect,totalSecond:NSString)
    {
        super.init(frame:frame)

        self.textColor = UIColor.whiteColor()
        self.font = Define.font(15)
        self.layer.cornerRadius = 3
        self.layer.masksToBounds = true
        self.backgroundColor = CD_MainColor
        self.textAlignment = NSTextAlignment.Center
        self.userInteractionEnabled = true
        
        overTime = totalSecond.integerValue + 1
        
        self.setLabelText(overTime!)
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "changeText", userInfo: Optional.None, repeats: true)
        timer?.fire()
    }
   
    func changeText()
    {
        overTime = overTime! - 1
        self.setLabelText(overTime!)
        if(overTime == 0)
        {
            self.backgroundColor = CD_LineColor
            self.textColor = CD_Txt_Color_00
            self.userInteractionEnabled = false
            timer?.invalidate()
            
            NSNotificationCenter.defaultCenter().postNotificationName("countdownover", object: nil)
        }
    }
    
    func setLabelText(overtime:Int)
    {
        //var totalSecond = secondStr.integerValue
        var min = overTime! / 60
        var sec = overTime! % 60
        if sec < 10
        {
            self.text = "\(min):0\(sec)积分解锁"
        }
        else
        {
            self.text = "\(min):\(sec)积分解锁"
        }
        //self.text = "\(min):\(sec)积分解锁"
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
