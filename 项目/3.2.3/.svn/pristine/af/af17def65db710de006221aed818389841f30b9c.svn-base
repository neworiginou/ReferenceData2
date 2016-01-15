//
//  HWCountDownView.swift
//  Partner-Swift
//
//  Created by hw500028 on 15/2/28.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit



protocol HWCountDownViewDelegate:NSObjectProtocol
{
    func countDownStart() -> Void
    func countDownEnd() -> Void
}

enum State
{
    case start
    case end
}
class HWCountDownView: UIView {
    var countDownBtn:UIButton?
    var count = 120
    var hwTimer:NSTimer?
    var delegate:HWCountDownViewDelegate?
    var state = State.end
    override init(frame:CGRect)
    {
        super.init(frame: frame)
        countDownBtn = UIButton(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        countDownBtn?.setTitle("获取验证码", forState: UIControlState.Normal)
        countDownBtn?.setBackgroundImage(Utility.imageWithColor(CD_GrayColor, _size: frame.size), forState: UIControlState.Normal)
        countDownBtn?.setTitleColor(UIColor.blackColor(), forState: UIControlState.Disabled)
        countDownBtn?.addTarget(self, action: "countDownBtnAction:", forControlEvents: UIControlEvents.TouchUpInside)
        countDownBtn?.titleLabel?.font = Define.font(TF_15)
        countDownBtn?.userInteractionEnabled = false
        self.addSubview(countDownBtn!)
    }


    func getTimer() -> NSTimer
    {
        if hwTimer == nil
        {
            hwTimer = NSTimer(timeInterval: 1.0, target: self, selector: "timerAction", userInfo: nil, repeats: true)
            NSRunLoop.currentRunLoop().addTimer(hwTimer!, forMode: NSRunLoopCommonModes)
        }
        return hwTimer!
    }
     
    func timerAction() -> Void
    {
        if count > 0
        {
            count--
            countDownBtn?.setTitle("\(count)s重新获取", forState: UIControlState.Normal)
            
        }
        else
        {
            hwTimer!.invalidate()
            hwTimer = nil
            countDownBtn!.setTitle("重新获取验证码", forState: UIControlState.Normal)
            countDownBtn?.userInteractionEnabled = true
            count = 120
            state = State.end
            countDownBtn?.setBackgroundImage(Utility.imageWithColor(CD_GreenColor, _size: frame.size), forState: UIControlState.Normal)
            if (delegate != nil && delegate?.respondsToSelector("countDownEnd") != false)
            {
                delegate?.countDownEnd()
            }
        }
    }
    
    func countDownBtnAction(sender:UIButton) -> Void
    {
        getTimer()
        countDownBtn?.userInteractionEnabled = false
        state = State.start
        countDownBtn?.setBackgroundImage(Utility.imageWithColor(CD_GrayColor, _size: frame.size), forState: UIControlState.Normal)
        if (delegate != nil && delegate?.respondsToSelector("countDownStart") != false)
        {
            delegate?.countDownStart()
        }
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
