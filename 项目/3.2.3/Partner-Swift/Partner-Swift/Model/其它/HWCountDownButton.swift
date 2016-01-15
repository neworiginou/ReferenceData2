//
//  HWCountDownButton.swift
//  HWUser
//
//  Created by wuxiaohong on 15/2/16.
//  Copyright (c) 2015年 hw. All rights reserved.
//

import UIKit



class HWCountDownButton: UIButton {

    let btnTimer :NSTimer?
    var countTime  = 60
    var resetTime  = 60
    //回调函数
    typealias SendAgainBlock = (sendAgainStatus:NSString) ->Void
    var myFunc = SendAgainBlock?()
    override init(frame: CGRect) {
        super.init(frame: frame)
        countTime = 60
        self .setTitle("\(countTime)重新发送", forState: .Normal)
        self .addTarget(self, action: "btnClick", forControlEvents:.TouchUpInside)
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func btnClick()
    {
        self.userInteractionEnabled = false
        countTime = resetTime
    }
    //MARK:设置时间
    func setTime(time:NSInteger)
    {
        countTime = time
        resetTime = time
    }
    
   func timerPlay()
   {
     countTime--
    if countTime > 0
    {
         self .setTitle("\(countTime)重新发送", forState: .Normal)
    
        
    }
    
    else
    {
        self .setTitle("点击重新发送", forState: .Normal)
        
        btnTimer?.invalidate()
        self.userInteractionEnabled = true
        if (myFunc != nil)
        {
            myFunc!(sendAgainStatus: "sendAgain")
        }
        
    }
    
    }
    //回调方法
    func initBack(mathFunction:(sendAgainStatus:NSString) ->Void)
    {
        myFunc = mathFunction
    }
    
    func setTimerStart(isStart:Bool)
    {
        if isStart
        {
            self .btnClick()
            resetTime = 60
            countTime  = 60
            NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "timerPlay", userInfo: nil, repeats: true)
        }
    }
    
    
    
    
}
