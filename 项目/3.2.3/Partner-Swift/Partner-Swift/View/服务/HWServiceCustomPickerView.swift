//
//  HWServiceCustomPickerView.swift
//  Swift_合伙人服务模块
//
//  Created by hw500027 on 15/2/5.
//  Copyright (c) 2015年 luxiaobo. All rights reserved.
//

import UIKit

@objc protocol HWServiceCustomPickViewDelegate:NSObjectProtocol
{
  optional  func passSelectedItem(model:HWServiceProductModel)
  optional  func passSelectedItems(str:NSString)
}

class HWServiceCustomPickerView: UIView,UIPickerViewDataSource,UIPickerViewDelegate {

    weak var customPickerViewDelegate:HWServiceCustomPickViewDelegate?
    
    let kScreenHeight: CGFloat = UIScreen.mainScreen().bounds.size.height
    let pickViewHeight: CGFloat = UIScreen.mainScreen().bounds.size.height / 2.0
    var _backGroundView:UIView!
    var _unitView:UIView!
    var _pickView:UIPickerView!
    var _arrayIndex:NSInteger! = 0
    var _dataArray:NSArray!
    var isStr:NSString!
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
    }
    
    init(dataArray:NSArray,str:NSString)
    {
        super.init()
        self._dataArray = dataArray
        isStr = str;
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight)
        _backGroundView = UIView(frame: CGRectMake(0, 0, kScreenWidth, kScreenHeight))
        _backGroundView.backgroundColor = UIColor.grayColor()
        _backGroundView.alpha = 0.5
        self.addSubview(_backGroundView)
        
        _unitView = UIView(frame: CGRectMake(0, kScreenHeight, kScreenWidth, pickViewHeight))
        _unitView.backgroundColor = UIColor.whiteColor()
        self.addSubview(_unitView)
        
        _pickView = UIPickerView(frame: CGRectMake(0, 0, _unitView.frame.size.width, _unitView.frame.size.height))
        _pickView.delegate = self
        _pickView.dataSource = self
        _unitView.addSubview(_pickView)
        
        //添加动画，显示选择器
        self.showPickView()
        
        //创建按钮
        self.createBtn()
    }

    func createBtn()
    {
        let btnTitle = ["取消","确定"]
        for i in 0...1
        {
            var button = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
            button.layer.masksToBounds = true
            button.layer.cornerRadius = 3
            //button.backgroundColor = CD_MainColor
            button.frame = CGRectMake(10 + (self._pickView.frame.size.width - 50 - 20) * CGFloat(i), 5, 50, 30)
            button.setTitle(btnTitle[i], forState: UIControlState.Normal)
            button.titleLabel?.font = Define.font(TF_13)
            button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            button.addTarget(self, action: "didSelectedButton:", forControlEvents: UIControlEvents.TouchUpInside)
            button.tag = i
            _unitView.addSubview(button)
            if (i == 0)
            {
                button.setBackgroundImage(Utility.imageWithColor(CD_Btn_GrayColor, _size: CGSizeMake(50, 30)), forState: UIControlState.Normal)
                button.setBackgroundImage(Utility.imageWithColor(CD_Btn_GrayColor_Clicked, _size: CGSizeMake(50, 30)), forState: UIControlState.Highlighted)
            }
            else
            {
                button.setBackgroundImage(Utility.imageWithColor(CD_Btn_MainColor, _size: CGSizeMake(50, 30)), forState: UIControlState.Normal)
                button.setBackgroundImage(Utility.imageWithColor(CD_Btn_MainColor_Clicked, _size: CGSizeMake(50, 30)), forState: UIControlState.Highlighted)
            }
        }
    }
    
    func didSelectedButton(btn:UIButton)
    {
        if btn.tag == 0
        {
            println("取消")
        }
        else if btn.tag == 1
        {
            println("确定")
            if isStr == "0"
            {
                customPickerViewDelegate?.passSelectedItem!(_dataArray.pObjectAtIndex(_arrayIndex) as HWServiceProductModel)
            }
          else if isStr == "1"
            {

                customPickerViewDelegate?.passSelectedItems!(_dataArray[_arrayIndex] as NSString)
            }
        }
        self.hidePickView()
    }
    
    func hidePickView()
    {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self._unitView.frame = CGRectMake(0, self.kScreenHeight , self._unitView.frame.size.width, self._unitView.frame.size.height)
        }) { (finished) -> Void in
            self.removeFromSuperview()
        }
    }
    
    func showPickView()
    {
        UIView.animateWithDuration(0.3, animations:
        {() in
            self._unitView.frame = CGRectMake(0, self.kScreenHeight - self.pickViewHeight, self._unitView.frame.size.width, self._unitView.frame.size.height)
        })
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return _dataArray.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!
    {
      
        if isStr == "1"
        {
            var str:NSString = _dataArray.pObjectAtIndex(row) as NSString
           return str
        }
        else
        {
            var model:HWServiceProductModel = _dataArray.pObjectAtIndex(row) as HWServiceProductModel
            return model.productName
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        _arrayIndex = row
    }
    
    required init(coder aDecoder: NSCoder)
    {
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
