//
//  LoginViewController.swift
//  家教
//
//  Created by goofygao on 15/11/14.
//  Copyright © 2015年 goofyy. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,UINavigationControllerDelegate,UITextFieldDelegate {

    let avaterImageView = UIImageView()
    
    let loginTextBG = UIImageView()
    
    let loginUserNameTextField = UITextField()
    
    let passwordTextField = UITextField()
    
    let loginButton = UIButton()
    
    var acitivityView = UIActivityIndicatorView()
    
    var alertView = UIAlertView()
    
    let defaultValue = NSUserDefaults()
    override func viewDidLoad() {
        super.viewDidLoad()
        loginUserNameTextField.delegate = self
        passwordTextField.delegate = self
        self.navigationController?.delegate = self
        self.navigationController?.navigationBarHidden = true
        self.navigationController?.toolbarHidden = true
        self.initView()
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "timerAction", userInfo: nil, repeats: true)
//        let time = NSTimer(timeInterval: 2, target: self, selector: "timerAction", userInfo: nil, repeats: true)
        
      
    }
    
    
    //initView
    func initView() {
        
        avaterImageView.bounds.size = CGSizeMake(100, 100)
        avaterImageView.center = CGPointMake(DeviceData.width/2, 100)
        avaterImageView.image = UIImage(named: "touxiang.png")
        avaterImageView.layer.cornerRadius = 50
        avaterImageView.layer.masksToBounds = true
        avaterImageView.layer.borderWidth = 5
        avaterImageView.layer.borderColor = UIColor(white: 0.5, alpha: 0.7).CGColor
        self.view.addSubview(avaterImageView)
        
        loginTextBG.bounds.size = CGSizeMake(DeviceData.width + 20, 100)
        loginTextBG.center = CGPointMake(DeviceData.width/2, 240)
        loginTextBG.alpha = 0.8
        loginTextBG.image = UIImage(named: "bg_login.png")
        self.view.addSubview(loginTextBG)
        
        loginUserNameTextField.frame = CGRectMake(40, 200, DeviceData.width - 80, 30)
        loginUserNameTextField.placeholder = "手机号/邮箱"
        loginUserNameTextField.borderStyle = UITextBorderStyle.None
        loginUserNameTextField.textAlignment = NSTextAlignment.Center
        loginUserNameTextField.keyboardType = UIKeyboardType.EmailAddress
        loginUserNameTextField.font = UIFont.systemFontOfSize(14)
        loginUserNameTextField.text = "goofyyivan"
        self.view.addSubview(loginUserNameTextField)
        
        passwordTextField.frame = CGRectMake(40, 250, DeviceData.width - 80, 30)
        passwordTextField.placeholder = "密码"
        passwordTextField.text = "123456"
        passwordTextField.borderStyle = UITextBorderStyle.None
        passwordTextField.textAlignment = NSTextAlignment.Center
        passwordTextField.font = UIFont.systemFontOfSize(14)
        passwordTextField.keyboardType = UIKeyboardType.EmailAddress
        passwordTextField.secureTextEntry = true
        self.view.addSubview(passwordTextField)
        
        loginButton.frame = CGRectMake(20, 300, DeviceData.width - 40, 50)
        loginButton.setBackgroundImage(UIImage(named: "bt_login.png"), forState: UIControlState.Normal)
        loginButton.addTarget(self, action: "loginAction", forControlEvents: UIControlEvents.TouchDown)
        self.view.addSubview(loginButton)
        
        acitivityView.frame = CGRectMake(0, 0, 30, 30)
        acitivityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.White
        acitivityView.center = CGPointMake(60, loginButton.center.y)
//        acitivityView.becomeFirstResponder()
        self.view.addSubview(acitivityView)
//        acitivityView.startAnimating()
    }
    
    func loginAction() {
       
        print(loginUserNameTextField.text)
        if loginUserNameTextField.text == "" || passwordTextField.text == "" {
            self.alertView = UIAlertView(title: "提示", message: "亲好像还没有登陆哦", delegate:  self, cancelButtonTitle: "OK")
            alertView.show()
        } else {
             acitivityView.startAnimating()
            
            
            let manager = AFHTTPRequestOperationManager()
            manager.responseSerializer.acceptableContentTypes = NSSet(object: "text/html") as Set<NSObject>
            let params:NSDictionary = ["password":passwordTextField.text!,"username":loginUserNameTextField.text!]
            print(params)
            manager.POST("http://115.29.54.119:888/Post/login", parameters: params, success: { (operation, response) -> Void in
                let responseDic = response as? NSDictionary
                let accessToken:String? = responseDic?["access_token"] as? String
                self.defaultValue.setValue(accessToken, forKey: "access_token")
                print(accessToken)
                if(responseDic == nil) {
                    self.alertView = UIAlertView(title: "提示", message: "亲好像还没注册哦", delegate:  self, cancelButtonTitle: "OK")
                    self.alertView.show()
                    self.acitivityView.stopAnimating()
                } else {
                    let storyBoadrd = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
                    let homePageNavigationController:UINavigationController = storyBoadrd.instantiateViewControllerWithIdentifier("homePage") as! UINavigationController
                    self.presentViewController(homePageNavigationController, animated: true, completion: nil)
                }
                
                }) { (operation, error) -> Void in
                    
            }
           
        }
        
        
    }
    
    func timerAction() {
    
        UIView.animateWithDuration(1, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
             self.avaterImageView.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI_2), 0, 1, 0)
            }) { (bool:Bool) -> Void in
                UIView.animateWithDuration(1) { () -> Void in
    
                    self.avaterImageView.layer.transform = CATransform3DMakeRotation(CGFloat(-M_PI_4), 0, 1, 0)
                }
        }
        
    }
    
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        if viewController == self {
            self.navigationController?.navigationBarHidden = true
        }
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        return true
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        loginUserNameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        loginUserNameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        loginUserNameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
}



