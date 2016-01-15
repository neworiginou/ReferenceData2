//
//  SearchFamilyAndVolunController.swift
//  家教
//
//  Created by goofygao on 15/11/20.
//  Copyright © 2015年 goofyy. All rights reserved.
//

import UIKit

class FindFamilyAndVolunController: UIViewController,UITextViewDelegate,UIAlertViewDelegate {
    
    let introuduceSelfTextView = UITextView()
    
    
    let textFieldBG = UIImageView()
    
    let residueWordNumber = UILabel()
    
    let canTeachCourseText = UITextField()
    
    let chooseFamilyOrVolunText = UITextField()
    let chooseFamilyOrVolunPick = UIPickerView()
    let pickTittleArray = ["找家教","找义教"]
    
    let basicMoneyText = UITextField()
    
    let higherMoneyText = UITextField()
    
    let needVolunterTimeText = UITextField()
    
    var alertView = UIAlertView()
    
    let chooseGroupTypeText = UITextField()
    
    let studentClassText = UITextField()
    
    let submitButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
    }
    
    
    /**
     初始化当前视图
     
     - returns: 无返回值
     */
    func initView() {
        self.view.backgroundColor = UIColor(red: 65.0 / 255.0, green: 62.0 / 255.0, blue: 79.0 / 255.0, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.title = "找家教&义教"
        
        textFieldBG.frame = CGRectMake(3, 2, DeviceData.width - 5, 120)
        textFieldBG.layer.cornerRadius = 5
        textFieldBG.layer.masksToBounds = true
        textFieldBG.alpha = 0.8
        textFieldBG.image = UIImage(named: "bg_setr.png")
        self.view.addSubview(textFieldBG)
        
        introuduceSelfTextView.frame = CGRectMake(3, 2, DeviceData.width - 5, 120)
        introuduceSelfTextView.textAlignment = NSTextAlignment.Left
        introuduceSelfTextView.delegate = self
        introuduceSelfTextView.backgroundColor = UIColor.clearColor()
        introuduceSelfTextView.font = UIFont.systemFontOfSize(15)
        self.view.addSubview(introuduceSelfTextView)
        
        residueWordNumber.frame = CGRectMake(DeviceData.width - 100, CGRectGetMaxY(introuduceSelfTextView.frame) - 21, 98, 21)
        residueWordNumber.font = UIFont.systemFontOfSize(10)
        residueWordNumber.text = "你可以输入140个字符"
        residueWordNumber.textAlignment = NSTextAlignment.Right
        residueWordNumber.textColor = UIColor(white: 0, alpha: 0.7)
        self.view.addSubview(residueWordNumber)
        
        canTeachCourseText.frame = CGRectMake(10, CGRectGetMaxY(introuduceSelfTextView.frame) + 15, DeviceData.width - 20, 21)
        canTeachCourseText.textColor = UIColor.whiteColor()
        canTeachCourseText.tintColor = UIColor.whiteColor()
        canTeachCourseText.borderStyle = UITextBorderStyle.None
        canTeachCourseText.font = UIFont.systemFontOfSize(14)
        canTeachCourseText.attributedPlaceholder = NSAttributedString(string:"请输入可辅导课程",
            attributes:[NSForegroundColorAttributeName: UIColor(white: 1, alpha: 0.5)])
        self.view.addSubview(canTeachCourseText)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.whiteColor().CGColor
        shapeLayer.lineWidth = 1
        let bezier = UIBezierPath()
        bezier.moveToPoint(CGPointMake(CGRectGetMinX(canTeachCourseText.frame),CGRectGetMaxY(canTeachCourseText.frame)))
        bezier.addLineToPoint(CGPointMake(DeviceData.width - 10,CGRectGetMaxY(canTeachCourseText.frame)))
        shapeLayer.path = bezier.CGPath
        self.view.layer.addSublayer(shapeLayer)
        
        chooseFamilyOrVolunText.frame = CGRectMake(10, CGRectGetMaxY(canTeachCourseText.frame) + 15, DeviceData.width - 20, 21)
        chooseFamilyOrVolunText.delegate = self
        chooseFamilyOrVolunText.textColor = UIColor.whiteColor()
        chooseFamilyOrVolunText.borderStyle = UITextBorderStyle.None
        chooseFamilyOrVolunText.font = UIFont.systemFontOfSize(14)
        chooseFamilyOrVolunText.attributedPlaceholder = NSAttributedString(string:"请选择义教或者家教",
            attributes:[NSForegroundColorAttributeName: UIColor(white: 1, alpha: 0.5)])
        self.view.addSubview(chooseFamilyOrVolunText)

        bezier.moveToPoint(CGPointMake(CGRectGetMinX(chooseFamilyOrVolunText.frame),CGRectGetMaxY(chooseFamilyOrVolunText.frame)))
        bezier.addLineToPoint(CGPointMake(DeviceData.width - 10,CGRectGetMaxY(chooseFamilyOrVolunText.frame)))
        shapeLayer.path = bezier.CGPath
        self.view.layer.addSublayer(shapeLayer)
     
        chooseFamilyOrVolunPick.frame = CGRectMake(0,DeviceData.height - 110, DeviceData.width, 50)
        chooseFamilyOrVolunPick.delegate = self
        chooseFamilyOrVolunPick.dataSource = self
        chooseFamilyOrVolunPick.hidden = true
        chooseFamilyOrVolunPick.backgroundColor = UIColor(white: 1, alpha: 0.7)
        self.view.addSubview(chooseFamilyOrVolunPick)
        
        basicMoneyText.frame = CGRectMake(10, CGRectGetMaxY(chooseFamilyOrVolunText.frame) + 15, DeviceData.width - 20, 21)
        basicMoneyText.keyboardType = UIKeyboardType.NumberPad
        basicMoneyText.textColor = UIColor.whiteColor()
        basicMoneyText.borderStyle = UITextBorderStyle.None
        basicMoneyText.font = UIFont.systemFontOfSize(14)
        basicMoneyText.attributedPlaceholder = NSAttributedString(string:"输入你想要的起薪",
            attributes:[NSForegroundColorAttributeName: UIColor(white: 1, alpha: 0.5)])
        self.view.addSubview(basicMoneyText)
        
        bezier.moveToPoint(CGPointMake(CGRectGetMinX(basicMoneyText.frame),CGRectGetMaxY(basicMoneyText.frame)))
        bezier.addLineToPoint(CGPointMake(DeviceData.width - 10,CGRectGetMaxY(basicMoneyText.frame)))
        shapeLayer.path = bezier.CGPath
        self.view.layer.addSublayer(shapeLayer)

        higherMoneyText.frame = CGRectMake(10, CGRectGetMaxY(basicMoneyText.frame) + 15, DeviceData.width - 20, 21)
        higherMoneyText.keyboardType = UIKeyboardType.NumberPad
        higherMoneyText.textColor = UIColor.whiteColor()
        higherMoneyText.borderStyle = UITextBorderStyle.None
        higherMoneyText.font = UIFont.systemFontOfSize(14)
        higherMoneyText.attributedPlaceholder = NSAttributedString(string:"输入你想要的底薪",
            attributes:[NSForegroundColorAttributeName: UIColor(white: 1, alpha: 0.5)])
        self.view.addSubview(higherMoneyText)
        
        bezier.moveToPoint(CGPointMake(CGRectGetMinX(higherMoneyText.frame),CGRectGetMaxY(higherMoneyText.frame)))
        bezier.addLineToPoint(CGPointMake(DeviceData.width - 10,CGRectGetMaxY(higherMoneyText.frame)))
        shapeLayer.path = bezier.CGPath
        self.view.layer.addSublayer(shapeLayer)
        
        needVolunterTimeText.frame = CGRectMake(10, CGRectGetMaxY(higherMoneyText.frame) + 15, DeviceData.width - 20, 21)
        needVolunterTimeText.keyboardType = UIKeyboardType.NumberPad
        needVolunterTimeText.textColor = UIColor.whiteColor()
        needVolunterTimeText.borderStyle = UITextBorderStyle.None
        needVolunterTimeText.font = UIFont.systemFontOfSize(14)
        needVolunterTimeText.attributedPlaceholder = NSAttributedString(string:"请输入你要的义工时间",
            attributes:[NSForegroundColorAttributeName: UIColor(white: 1, alpha: 0.5)])
        self.view.addSubview(needVolunterTimeText)
        
        bezier.moveToPoint(CGPointMake(CGRectGetMinX(needVolunterTimeText.frame),CGRectGetMaxY(needVolunterTimeText.frame)))
        bezier.addLineToPoint(CGPointMake(CGRectGetMinX(needVolunterTimeText.frame) + DeviceData.width - 20,CGRectGetMaxY(needVolunterTimeText.frame)))
        shapeLayer.path = bezier.CGPath
        self.view.layer.addSublayer(shapeLayer)
    
        alertView = UIAlertView(title: "提示", message: "请选择发布的组织类型", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "个人", "组织","社区")
        alertView.targetForAction("alertAction", withSender: self)
        
        chooseGroupTypeText.frame = CGRectMake(10, CGRectGetMaxY(needVolunterTimeText.frame) + 15, DeviceData.width - 20, 21)
        chooseGroupTypeText.keyboardType = UIKeyboardType.NumberPad
        chooseGroupTypeText.textColor = UIColor.whiteColor()
        chooseGroupTypeText.borderStyle = UITextBorderStyle.None
        chooseGroupTypeText.font = UIFont.systemFontOfSize(14)
        chooseGroupTypeText.delegate = self
        chooseGroupTypeText.tag = 200
        chooseGroupTypeText.attributedPlaceholder = NSAttributedString(string:"请选择发布组织的类型",
            attributes:[NSForegroundColorAttributeName: UIColor(white: 1, alpha: 0.5)])
        self.view.addSubview(chooseGroupTypeText)
        
        bezier.moveToPoint(CGPointMake(CGRectGetMinX(chooseGroupTypeText.frame),CGRectGetMaxY(chooseGroupTypeText.frame)))
        bezier.addLineToPoint(CGPointMake(CGRectGetMinX(chooseGroupTypeText.frame) + DeviceData.width - 20,CGRectGetMaxY(chooseGroupTypeText.frame)))
        shapeLayer.path = bezier.CGPath
        self.view.layer.addSublayer(shapeLayer)
        
        studentClassText.frame = CGRectMake(10, CGRectGetMaxY(chooseGroupTypeText.frame) + 15, DeviceData.width - 20, 21)
        studentClassText.keyboardType = UIKeyboardType.NumberPad
        studentClassText.textColor = UIColor.whiteColor()
        studentClassText.borderStyle = UITextBorderStyle.None
        studentClassText.font = UIFont.systemFontOfSize(14)
        studentClassText.delegate = self
        studentClassText.attributedPlaceholder = NSAttributedString(string:"输入你的班级",
            attributes:[NSForegroundColorAttributeName: UIColor(white: 1, alpha: 0.5)])
        self.view.addSubview(studentClassText)
        
        bezier.moveToPoint(CGPointMake(CGRectGetMinX(studentClassText.frame),CGRectGetMaxY(studentClassText.frame)))
        bezier.addLineToPoint(CGPointMake(CGRectGetMinX(studentClassText.frame) + DeviceData.width - 20,CGRectGetMaxY(studentClassText.frame)))
        shapeLayer.path = bezier.CGPath
        self.view.layer.addSublayer(shapeLayer)
        
        submitButton.frame = CGRectMake(10, CGRectGetMaxY(studentClassText.frame) + 15, DeviceData.width - 20, 41)
        submitButton.setImage(UIImage(named: "bt_setr_submit.png"), forState: UIControlState.Normal)
        submitButton.addTarget(self, action: "submitAction", forControlEvents: UIControlEvents.TouchDown)
        self.view.addSubview(submitButton)

    }
    
    /**
    *  delegate
    */
   
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if(range.location > 140){
            let alert:UIAlertView = UIAlertView(title: "警告", message: "输入过头了", delegate: self, cancelButtonTitle: "好")
            alert.show()
            return false
        }else{
            let surplusWordCount = 140 - textView.text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
            residueWordNumber.text = "还可以输入" + "\(surplusWordCount)" + "字"
            return true
        }
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 1 {
            self.chooseGroupTypeText.text = "个人"
        } else if buttonIndex == 2 {
            self.chooseGroupTypeText.text = "组织"
            
        } else if buttonIndex == 3 {
            self.chooseGroupTypeText.text = "社区"
        }
    }
    
    func submitAction() {
        
    }
    
}


extension FindFamilyAndVolunController:UIPickerViewDelegate,UITextFieldDelegate,UIPickerViewDataSource {
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return  pickTittleArray[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        chooseFamilyOrVolunText.text = "\(pickTittleArray[row])"
//        chooseFamilyOrVolunText.enabled = false
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField.tag == 200 {
            
        } else {
            chooseFamilyOrVolunText.text = "找家教"
        }
        
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyBoBoardHidden", name: UIKeyboardWillShowNotification, object: nil)
        
        if textField.tag == 200 {
            alertView.show()
        } else {
            chooseFamilyOrVolunPick.hidden = false
        }
        return true
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickTittleArray.count
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        self.chooseFamilyOrVolunPick.hidden = true
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.chooseFamilyOrVolunText.resignFirstResponder()
        self.chooseGroupTypeText.resignFirstResponder()
        self.studentClassText.resignFirstResponder()
        self.canTeachCourseText.resignFirstResponder()
        self.basicMoneyText.resignFirstResponder()
        self.higherMoneyText.resignFirstResponder()
    }
    /**
    通知
    */
    func keyBoBoardHidden() {
        self.chooseFamilyOrVolunText.resignFirstResponder()
        self.chooseGroupTypeText.resignFirstResponder()
    }
    
    
    
}