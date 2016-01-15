//
//  HWCustomActionSheet.swift
//  Partner-Swift
//
//  Created by hw500028 on 15/2/26.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

protocol HWCustomActionSheetDelegate:NSObjectProtocol
{
    func customActionSheet(actionSheet: HWCustomActionSheet, didSelectButtonIndex index: NSInteger) -> Void
}

class HWCustomActionSheet: UIView
{
    var backgroundControl:UIControl?
    var cancelBtn:UIButton?
    var btnBackground:UIView?
    var containt:NSLayoutConstraint?
    var hwHeight:CGFloat?
    var delegate:HWCustomActionSheetDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    func customAction(title:String,cancelButtonTitle:String,otherBUttonTitles:[String])->Void
    {
        var height:CGFloat?
        let spaceInset = CGFloat(10)
        if title == ""
        {
             height = CGFloat(44 * otherBUttonTitles.count)
           
        }
        else
        {
             height = CGFloat(44 * otherBUttonTitles.count + 44)
        }
    
        
        hwHeight = height! + 44 + 20
        
        backgroundControl = UIControl(frame: shareAppDelegate.window!.bounds)
        backgroundControl!.backgroundColor = UIColor.blackColor()
        backgroundControl!.alpha = 0
        self.addSubview(backgroundControl!)
        backgroundControl?.addTarget(self, action: "hiden", forControlEvents: UIControlEvents.TouchUpInside)
        //
        btnBackground = UIView(frame: CGRect(x: 0, y: (UIScreen.mainScreen().bounds.size.height), width: kScreenWidth, height: hwHeight!))
        self.addSubview(btnBackground!)
        btnBackground?.backgroundColor = UIColor.clearColor()
        //取消按钮
        cancelBtn = UIButton.newAutoLayoutView()
        btnBackground!.addSubview(cancelBtn!)
        cancelBtn!.setTitle(cancelButtonTitle, forState: UIControlState.Normal)
        cancelBtn!.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 0, left: spaceInset, bottom: spaceInset, right: spaceInset), excludingEdge: ALEdge.Top)
        cancelBtn!.autoSetDimension(ALDimension.Height, toSize: 44.0)
        cancelBtn!.layer.cornerRadius = 3.0
        cancelBtn!.layer.masksToBounds = true
        cancelBtn!.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
         cancelBtn!.backgroundColor = UIColor.whiteColor()
        cancelBtn!.addTarget(self, action: "cancel", forControlEvents: UIControlEvents.TouchUpInside)
        //其他按钮背景
        var otherBtnBackground = UIView.newAutoLayoutView()
        btnBackground!.addSubview(otherBtnBackground)
        otherBtnBackground.layer.cornerRadius = 3.0
        otherBtnBackground.layer.masksToBounds = true
        otherBtnBackground.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: spaceInset)
        otherBtnBackground.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: spaceInset)
        otherBtnBackground.autoPinEdge(ALEdge.Bottom, toEdge: ALEdge.Top, ofView: cancelBtn, withOffset: -spaceInset)
        otherBtnBackground.autoSetDimension(ALDimension.Height, toSize: height!)
        otherBtnBackground.backgroundColor = UIColor.whiteColor()
        //title
        if title == ""
        {
            
        }
        
        else
        {
            var titleLabel = UILabel.newAutoLayoutView()

            otherBtnBackground.addSubview(titleLabel)
            titleLabel.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), excludingEdge: ALEdge.Bottom)
            titleLabel.autoSetDimension(ALDimension.Height, toSize: 44)
            titleLabel.text = title
            titleLabel.textColor = UIColor.blackColor()
            titleLabel.textAlignment = NSTextAlignment.Center

        }
        
        
        //
        for i in 0 ..< otherBUttonTitles.count
        {
            
             var btnY:CGFloat?
            if title == ""
            {
                btnY = CGFloat(i * 44)

            }
                
            else
            {
                btnY = CGFloat(i * 44 + 44)

            }

           // let btnY = CGFloat(i * 44 + 44)
            var otherBtn = UIButton(frame: CGRect(x: 0, y: btnY!, width: kScreenWidth - 10, height: 44))
            otherBtnBackground.addSubview(otherBtn)
            otherBtn.setTitle(otherBUttonTitles[i], forState: UIControlState.Normal)
            otherBtn.tag = 100 + i
            otherBtn.addTarget(self, action: "otherBtnAction:", forControlEvents: UIControlEvents.TouchUpInside)
            otherBtn.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
            otherBtn.backgroundColor = UIColor.clearColor()
            Utility.topLine(otherBtn)
        }
    
    }
    
    //隐藏
    func hiden()->Void
    {
        
        UIView.animateWithDuration(0.35, animations: { () -> Void in
            self.backgroundControl!.alpha = 0
            self.btnBackground!.frame = CGRect(x: 0, y: UIScreen.mainScreen().bounds.size.height, width: kScreenWidth, height: self.hwHeight!)

        }) { (Bool) -> Void in
            if Bool == true
            {
                self.removeFromSuperview()

            }
        }
    }
    //显示
    func show(showView:UIView)->Void
    {
        showView.addSubview(self)
        UIView.animateWithDuration(0.35, animations: { () -> Void in
            self.backgroundControl!.alpha = 0.6
            self.btnBackground!.frame = CGRect(x: 0, y: UIScreen.mainScreen().bounds.size.height - self.hwHeight!, width: kScreenWidth, height: self.hwHeight!)
            
        })
        
        
    }
    
    func cancel()->Void
    {
        hiden()
    }
    //
    func otherBtnAction(btn:UIButton)->Void
    {
        hiden()
        let index = btn.tag - 100
        if (delegate != nil && delegate?.respondsToSelector("customActionSheet:didSelectButtonIndex:") != false)
        {
            delegate?.customActionSheet(self, didSelectButtonIndex: index)
        }
    
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
