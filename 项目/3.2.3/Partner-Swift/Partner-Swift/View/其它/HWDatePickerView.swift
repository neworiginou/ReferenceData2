//
//  HWDatePickerView.swift
//  Partner-Swift
//
//  Created by caijingpeng.haowu on 15/2/18.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWDatePickerView: UIView {
    
    let screenHeight: CGFloat = UIScreen.mainScreen().bounds.size.height
    let screenWidth: CGFloat = UIScreen.mainScreen().bounds.size.width
    let pickerHeight: CGFloat = 216
    
    var pickerBackView: UIView!
    
    override init(frame: CGRect)
    {
        let defaultFrame: CGRect = CGRectMake(0, 0 , screenWidth, screenHeight)
        super.init(frame: defaultFrame)
        
        self.backgroundColor = UIColor.clearColor()
        self.initialPickerView()
    
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialPickerView() -> Void
    {
        pickerBackView = UIView(frame: CGRectMake(0, screenHeight, screenWidth, pickerHeight + 40))
        pickerBackView.backgroundColor = UIColor.whiteColor()
        self.addSubview(pickerBackView)
        
        let cancelBtn: UIButton! = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        cancelBtn.titleLabel?.font = Define.font(TF_Text_15)
        cancelBtn.setTitleColor(CD_Txt_Color_33, forState: UIControlState.Normal)
        cancelBtn.frame = CGRectMake(15, 0, 60, 40)
        cancelBtn.layer.cornerRadius = 3
        cancelBtn.layer.masksToBounds = true
        pickerBackView.addSubview(cancelBtn)
        
        
        let rightBtn: UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        rightBtn.titleLabel?.font = Define.font(TF_Text_15)
        rightBtn.setTitleColor(CD_OrangeColor, forState: UIControlState.Normal)
        rightBtn.frame = CGRectMake(screenWidth - 60 - 15, 0, 60, 40)
        rightBtn.layer.cornerRadius = 3
        rightBtn.layer.masksToBounds = true
        pickerBackView.addSubview(rightBtn)
        
        var datePicker: UIDatePicker = UIDatePicker(frame: CGRectMake(0, 40, screenWidth, pickerHeight))
        datePicker.datePickerMode = UIDatePickerMode.DateAndTime
        pickerBackView.addSubview(datePicker)
    }
    
    func showAnimate() -> Void
    {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.backgroundColor = UIColor(white: 0, alpha: 0.4)
            self.pickerBackView.frame = CGRectMake(0, self.screenHeight - self.pickerHeight, self.screenWidth, self.pickerHeight)
        })
    }
    
    func hideAnimate() -> Void
    {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.backgroundColor = UIColor(white: 0, alpha: 0.0)
            self.pickerBackView.frame = CGRectMake(0, self.screenHeight, self.screenWidth, self.pickerHeight)
            }) { (finished) -> Void in
                self.removeFromSuperview()
        }
    }
    
    func showDatePicker() -> Void
    {
        self.showAnimate()
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
