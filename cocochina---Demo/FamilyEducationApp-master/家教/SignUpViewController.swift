//
//  SignUpViewController.swift
//  家教
//
//  Created by goofygao on 15/11/16.
//  Copyright © 2015年 goofyy. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var phoneSignButton: UIButton!
    
    @IBOutlet weak var emailSignButton: UIButton!
    
    
    var registerView: UIView = UIView()
    
    let phoneTextField = UITextField()
    
    let nickNameTextFied = UITextField()
    
    let passwordFirstText = UITextField()
    
    let passwordSecondText = UITextField()
    
    let verificationCodeText = UITextField()
    
    let getVerificationCodeButton = UIButton()
    
    let agreeProtocolButton = UIButton()
    
    let agreeTittleLabel = UILabel()
    
    let registerButton = UIButton()
    
    var timer = NSTimer?()
    
    var second = 60
    
    var alertView = UIAlertView()
    
    let submitRegisterButton = UIButton()
    
    let chooseTeacherOrStudent = UITextField()
    let manager = AFHTTPRequestOperationManager()
    

    
    var identtityButtonTag = 0
    /// 需要post的数据
    var postDictionary = NSMutableDictionary()
    
    var defalutValue = NSUserDefaults()
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        
    }
    
    
    /**
     界面初始化
     
     - returns: no return value
     */
    func initView() {
       
        self.navigationController?.navigationBarHidden = false
        self.view.backgroundColor = UIColor(red: 65.0 / 255.0, green: 62.0 / 255.0, blue: 79.0 / 255.0, alpha: 1)
        let navBar = self.navigationController?.navigationBar
        navBar?.barTintColor = UIColor(red: 65.0 / 255.0, green: 62.0 / 255.0, blue: 79.0 / 255.0, alpha: 1)
        navBar?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        phoneSignButton.addTarget(self, action: "phoneSignAction:", forControlEvents: UIControlEvents.TouchDown)
        emailSignButton.addTarget(self, action: "emailSianAction:", forControlEvents: UIControlEvents.TouchDown)
        registerView.frame = CGRectMake(0, 105, DeviceData.width * 2 , DeviceData.height - CGRectGetMaxY(phoneSignButton.frame))
        registerView.backgroundColor = UIColor(red: 65.0 / 255.0, green: 62.0 / 255.0, blue: 79.0 / 255.0, alpha: 1)
        self.view.addSubview(registerView)
        
        phoneTextField.frame = CGRectMake(40, 40, DeviceData.width - 80, 30)
        phoneTextField.placeholder = "输入你的手机号"
        phoneTextField.textColor = UIColor.blackColor()
        phoneTextField.borderStyle = UITextBorderStyle.RoundedRect
        phoneTextField.textAlignment = NSTextAlignment.Center
        phoneTextField.font = UIFont.systemFontOfSize(14)
        phoneTextField.keyboardType = UIKeyboardType.NumberPad
        phoneTextField.returnKeyType = UIReturnKeyType.Next
        self.registerView.addSubview(phoneTextField)
        
        nickNameTextFied.frame = CGRectMake(40, 80, DeviceData.width - 80, 30)
        nickNameTextFied.placeholder = "输入你的昵称"
        nickNameTextFied.textColor = UIColor.blackColor()
        nickNameTextFied.borderStyle = UITextBorderStyle.RoundedRect
        nickNameTextFied.textAlignment = NSTextAlignment.Center
        nickNameTextFied.font = UIFont.systemFontOfSize(14)
        nickNameTextFied.keyboardType = UIKeyboardType.EmailAddress
        nickNameTextFied.returnKeyType = UIReturnKeyType.Next
        self.registerView.addSubview(nickNameTextFied)
        
        passwordFirstText.frame = CGRectMake(40, 120, DeviceData.width - 80, 30)
        passwordFirstText.placeholder = "密码(不少于6位)"
        passwordFirstText.textColor = UIColor.blackColor()
        passwordFirstText.borderStyle = UITextBorderStyle.RoundedRect
        passwordFirstText.textAlignment = NSTextAlignment.Center
        passwordFirstText.font = UIFont.systemFontOfSize(14)
        passwordFirstText.keyboardType = UIKeyboardType.EmailAddress
        passwordFirstText.returnKeyType = UIReturnKeyType.Next
        passwordFirstText.secureTextEntry = true
        self.registerView.addSubview(passwordFirstText)
        
        passwordSecondText.frame = CGRectMake(40, 160, DeviceData.width - 80, 30)
        passwordSecondText.placeholder = "重复密码"
        passwordSecondText.textColor = UIColor.blackColor()
        passwordSecondText.borderStyle = UITextBorderStyle.RoundedRect
        passwordSecondText.textAlignment = NSTextAlignment.Center
        passwordSecondText.font = UIFont.systemFontOfSize(14)
        passwordSecondText.keyboardType = UIKeyboardType.EmailAddress
        passwordSecondText.returnKeyType = UIReturnKeyType.Next
         passwordSecondText.secureTextEntry = true
        self.registerView.addSubview(passwordSecondText)

        verificationCodeText.frame = CGRectMake(40, 200, DeviceData.width - 200, 30)
        verificationCodeText.placeholder = "输入验证码"
        verificationCodeText.textColor = UIColor.blackColor()
        verificationCodeText.borderStyle = UITextBorderStyle.RoundedRect
        verificationCodeText.textAlignment = NSTextAlignment.Center
        verificationCodeText.font = UIFont.systemFontOfSize(14)
        verificationCodeText.keyboardType = UIKeyboardType.EmailAddress
        verificationCodeText.returnKeyType = UIReturnKeyType.Next
        self.registerView.addSubview(verificationCodeText)
        
        getVerificationCodeButton.frame = CGRectMake(CGRectGetMaxX(verificationCodeText.frame) + 10, CGRectGetMinY(verificationCodeText.frame), 110, 30)
        getVerificationCodeButton.layer.cornerRadius = 5
        getVerificationCodeButton.layer.masksToBounds = true
        getVerificationCodeButton.backgroundColor = UIColor.blueColor()
        getVerificationCodeButton.setTitle("获取验证码", forState: UIControlState.Normal)
        getVerificationCodeButton.titleLabel?.font = UIFont.systemFontOfSize(13)
        getVerificationCodeButton.titleLabel?.text = "获取验证码"
        getVerificationCodeButton.addTarget(self, action: "getVerificationCodeAction:", forControlEvents: UIControlEvents.TouchDown)
        self.registerView.addSubview(getVerificationCodeButton)

//        agreeProtocolButton.frame = CGRectMake(40, 240, 20, 20)
//        agreeProtocolButton.setImage(UIImage(named: "new_feature_share_false"), forState: UIControlState.Normal)
//        agreeProtocolButton.addTarget(self, action: "agreeProtocolAction:", forControlEvents: UIControlEvents.TouchDown)
//        self.registerView.addSubview(agreeProtocolButton)
//        
//        agreeTittleLabel.frame = CGRectMake(65, 240, 100, 21)
//        agreeTittleLabel.text = "同意协议 "
//        self.registerView.addSubview(agreeTittleLabel)
        phoneSignButton.enabled = true
        
        alertView = UIAlertView(title: "提示", message: "请选择你注册的类型", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "老师", "家长")
        alertView.targetForAction("alertAction", withSender: self)
        
        chooseTeacherOrStudent.frame = CGRectMake(CGRectGetMinX(verificationCodeText.frame), CGRectGetMaxY(verificationCodeText.frame) + 15, DeviceData.width - 80, 30)
        
        chooseTeacherOrStudent.keyboardType = UIKeyboardType.NumberPad
//        chooseTeacherOrStudent.textColor = UIColor.whiteColor()
        chooseTeacherOrStudent.borderStyle = UITextBorderStyle.RoundedRect
        chooseTeacherOrStudent.font = UIFont.systemFontOfSize(14)
        chooseTeacherOrStudent.text = "家长"
        chooseTeacherOrStudent.delegate = self
        chooseTeacherOrStudent.tag = 400
        chooseTeacherOrStudent.placeholder = "你是老师还是家教"
        self.registerView.addSubview(chooseTeacherOrStudent)

        submitRegisterButton.frame = CGRectMake(CGRectGetMinX(verificationCodeText.frame), CGRectGetMaxY(chooseTeacherOrStudent.frame) + 15, DeviceData.width - 80, 35)
        submitRegisterButton.setImage(UIImage(named: "bt_setr_submit.png"), forState: UIControlState.Normal)
        submitRegisterButton.addTarget(self, action: "submitRegisterAction:", forControlEvents: UIControlEvents.TouchDown)
        self.registerView.addSubview(submitRegisterButton)
        identtityButtonTag = 10
        phoneSignButton.setTitleColor(UIColor(white: 1, alpha: 0.8), forState: UIControlState.Normal)
        phoneSignButton.backgroundColor = UIColor(red: 0.23, green: 0.34, blue: 0.54, alpha: 1)
         phoneSignButton.enabled = false
    }
    
    /**
     手机注册button
     
     - parameter sender: button self
     */
    func phoneSignAction(sender:UIButton) {
        emailSignButton.backgroundColor = UIColor.clearColor()
        sender.backgroundColor = UIColor(red: 0.23, green: 0.34, blue: 0.54, alpha: 1)
        emailSignButton.setTitleColor(UIColor(white: 0, alpha: 0.8), forState: UIControlState.Normal)
        sender.setTitleColor(UIColor(white: 1, alpha: 0.8), forState: UIControlState.Normal)
        phoneTextField.keyboardType = UIKeyboardType.NumberPad
        UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            
            self.registerView.bounds.origin.x -= DeviceData.width
            self.nickNameTextFied.center.x -= DeviceData.width
            self.passwordFirstText.center.x -= DeviceData.width
            self.passwordSecondText.center.x -= DeviceData.width
            self.getVerificationCodeButton.center.x -= DeviceData.height
            self.phoneTextField.center.x -= DeviceData.width
            self.phoneTextField.placeholder = "请输入你的手机号码"
            self.chooseTeacherOrStudent.center.x -= DeviceData.width
            self.chooseTeacherOrStudent.center.y += 45
            self.verificationCodeText.center.x += DeviceData.width
            self.submitRegisterButton.center.x -= DeviceData.width
            self.submitRegisterButton.center.y += 45
            }, completion: nil)
        
        sender.enabled = false
        emailSignButton.enabled = true
        print(sender.tag)
        identtityButtonTag = sender.tag
       
    }
    
    /**
     邮箱注册BUTTON
     
     - parameter sender: button self
     */
    func emailSianAction(sender:UIButton) {
        sender.backgroundColor = UIColor(red: 0.23, green: 0.34, blue: 0.54, alpha: 1)
        phoneSignButton.setTitleColor(UIColor(white: 0, alpha: 0.8), forState: UIControlState.Normal)
        sender.setTitleColor(UIColor(white: 1, alpha: 0.8), forState: UIControlState.Normal)
        phoneTextField.keyboardType = UIKeyboardType.EmailAddress
        phoneSignButton.backgroundColor = UIColor.clearColor()
        UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            
            self.registerView.bounds.origin.x += DeviceData.width
            self.nickNameTextFied.center.x += DeviceData.width
            self.passwordFirstText.center.x += DeviceData.width
            self.passwordSecondText.center.x += DeviceData.width
            self.getVerificationCodeButton.center.x += DeviceData.height
            self.phoneTextField.center.x += DeviceData.width
            self.phoneTextField.placeholder = "请输入你的邮箱"
            self.verificationCodeText.center.x -= DeviceData.width
            self.chooseTeacherOrStudent.center.x += DeviceData.width
            self.chooseTeacherOrStudent.center.y -= 45
            self.submitRegisterButton.center.x += DeviceData.width
            self.submitRegisterButton.center.y -= 45


            }, completion: nil)
       
        sender.enabled = false
        phoneSignButton.enabled = true
        identtityButtonTag = sender.tag
    }
    /**
     获取验证码 BUTTON
     
     - parameter sender: button self
     */
    func getVerificationCodeAction(sender:UIButton) {
        sender.enabled = false
       timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "timerAction", userInfo: nil, repeats: true)
        if phoneTextField.text == "" {
            
        } else {
            
            manager.responseSerializer.acceptableContentTypes = NSSet(object: "text/html") as Set<NSObject>
            let mobileDictionary:NSDictionary = ["mobile":phoneTextField.text!]
            manager.POST("http://115.29.54.119:888/Get/getAuth", parameters: mobileDictionary, success: { (operation, response) -> Void in
                let responseDic = response as? NSDictionary
                let result = responseDic!["userid"]
                
                if let _ = responseDic!["userid"] {
                    UIAlertView(title: "提示", message: "验证码已经发送\(responseDic!["authCode"])", delegate: nil, cancelButtonTitle: "完成").show()
                    self.defalutValue.setObject(responseDic!["userid"], forKey: "sign_userid")
                    self.defalutValue.setObject(responseDic!["authCode"], forKey: "sign_authCode")
                } else {
                    UIAlertView(title: "提示", message: "验证码发送失败", delegate: nil, cancelButtonTitle: "完成").show()
                }
                
                
                
                }) { (operation, error) -> Void in
                    
            }
        }
  
    }

    /**
     验证码点击后倒计时效果
     */
    func timerAction() {
        if second == 1 {
            timer = nil
            getVerificationCodeButton.enabled = true
            getVerificationCodeButton.backgroundColor = UIColor.blueColor()
        } else {
            second--
            getVerificationCodeButton.backgroundColor = UIColor(hue: 1, saturation: 0.23, brightness: 0.54, alpha: 0.8)
            getVerificationCodeButton.setTitle("\(second)" + "秒后重发", forState: UIControlState.Normal)
        }
    }
    /**
     同意协议 button
     
     - parameter sender: button self
     */
    func agreeProtocolAction(sender:UIButton) {
        sender.setImage(UIImage(named: "new_feature_share_true"), forState: UIControlState.Normal)
    }
    /**
     提交当前表单到服务器
     
     - parameter sender: 提交 - button self
     */
    
    func submitRegisterAction(sender:UIButton) {
       
        /**
        *  手机注册
        */
        if passwordSecondText.text != passwordFirstText.text {
            UIAlertView(title: "提示", message: "两次密码输入不一致", delegate: nil, cancelButtonTitle: "返回").show()
        } else
        if nickNameTextFied.text == "" || phoneTextField.text == "" {
            UIAlertView(title: "提示", message: "请正确填写表格", delegate: nil, cancelButtonTitle: "返回").show()
        }

        if identtityButtonTag == 10 {
            
            print("dfsfsd")
            if verificationCodeText.text! == "" || verificationCodeText.text != defalutValue.valueForKey("sign_authCode") as? String {
                UIAlertView(title: "提示", message: "请正确填写验证码", delegate: nil, cancelButtonTitle: "返回").show()
            } else {
//                21459121print(responseDic)
                print("手机注册")
                if let userid_sign = defalutValue.valueForKey("sign_userid") {
                    print("go go go ")
                    if chooseTeacherOrStudent.text == "老师" {
                        postDictionary = ["username":nickNameTextFied.text!,"password":passwordFirstText.text!,"type":0,"authCode":verificationCodeText.text!,"mobile":phoneTextField.text!,"userid":userid_sign]
                        
                        
                    } else {
                        postDictionary = ["username":nickNameTextFied.text!,"password":passwordFirstText.text!,"type":1,"authCode":verificationCodeText.text!,"mobile":phoneTextField.text!,"userId":userid_sign]
                    }
                    
                    manager.responseSerializer.acceptableContentTypes = NSSet(object: "text/html") as Set<NSObject>
                    manager.POST("http://115.29.54.119:888/Get/regByNum", parameters: postDictionary, success: { (operation, response) -> Void in
                        let responseDic = response as? NSDictionary
                        let result = responseDic!["userid"]
                       
                        if let _ = responseDic!["userid"] {
                            UIAlertView(title: "注册消息", message: "恭喜你注册成功ID为\(responseDic!["userid"]!)", delegate: nil, cancelButtonTitle: "完成").show()
                        } else {
                            UIAlertView(title: "注册消息", message: "注册失败,用户名或手机已注册", delegate: nil, cancelButtonTitle: "完成").show()
                        }
                        
                        
                        
                        }) { (operation, error) -> Void in
                     UIAlertView(title: "注册消息", message: "注册失败,用户名或手机已注册", delegate: nil, cancelButtonTitle: "完成").show()
                    }

                }
                
                
                

            }
            
        } else {
            
            if chooseTeacherOrStudent.text == "老师" {
                postDictionary = ["username":nickNameTextFied.text!,"password":passwordFirstText.text!,"email":phoneTextField.text!,"type":0]
                
                
                
                
            } else {
                postDictionary = ["username":nickNameTextFied.text!,"password":passwordFirstText.text!,"email":phoneTextField.text!,"type":1]
            }
            /// 创建AFNetWorking管理者
            manager.responseSerializer.acceptableContentTypes = NSSet(object: "text/html") as Set<NSObject>
            manager.POST("http://115.29.54.119:888/Get/reg", parameters: postDictionary, success: { (operation, response) -> Void in
                let responseDic = response as? NSDictionary
                
                let result = responseDic!["userid"]
                if let _ = responseDic!["userid"] {
                    UIAlertView(title: "注册消息", message: "恭喜你注册成功ID为\(responseDic!["userid"]!)", delegate: nil, cancelButtonTitle: "完成").show()
                } else {
                    UIAlertView(title: "注册消息", message: "注册失败,用户名或邮箱重复", delegate: nil, cancelButtonTitle: "完成").show()
                }
            
                
                
                }) { (operation, error) -> Void in
                    
            }
            
            
        }
        
        
    }
    
    /**
     注销第一响应者
     
     - parameter touches: 点击的透彻
     - parameter event:   点击事件
     */
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.passwordFirstText.resignFirstResponder()
        self.passwordSecondText.resignFirstResponder()
        self.phoneTextField.resignFirstResponder()
        self.verificationCodeText.resignFirstResponder()
        self.nickNameTextFied.resignFirstResponder()
        
    }
}

extension SignUpViewController: UIAlertViewDelegate,UITextFieldDelegate {
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        self.alertView.show()
        return false
    }
    
    func alertView(alertView: UIAlertView, didDismissWithButtonIndex buttonIndex: Int) {
        
        if buttonIndex == 1 {
            
            self.chooseTeacherOrStudent.text = "老师"
            
        } else if buttonIndex == 2{
            self.chooseTeacherOrStudent.text = "家长"
        }
    }
}
    
