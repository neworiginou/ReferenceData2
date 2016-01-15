//
//  SearchViewController.swift
//  家教
//
//  Created by goofygao on 15/12/2.
//  Copyright © 2015年 goofyy. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController,UITextFieldDelegate,UIAlertViewDelegate {

    @IBOutlet weak var searchConditionSex: UITextField!
    
    @IBOutlet weak var searchConditionAge: UITextField!
    
    @IBOutlet weak var searchConditionMoneyStart: UITextField!
    
    
    @IBOutlet weak var searchConditionMoneyEnd: UITextField!
    
    
    @IBOutlet weak var searchConditionSubmit: UIButton!
    
    var alertView = UIAlertView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 
    func initView() {
        let navBar = self.navigationController?.navigationBar
        navBar?.barTintColor = UIColor(red: 65.0 / 255.0, green: 62.0 / 255.0, blue: 79.0 / 255.0, alpha: 1)
        navBar?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        searchConditionSex.delegate = self
        searchConditionAge.delegate = self
    }
    
    @IBAction func searchConditionAction(sender: UIButton) {
        if searchConditionAge.text == "" && searchConditionMoneyEnd.text == "" &&
            searchConditionMoneyStart.text == "" && searchConditionSex.text == "" {
               UIAlertView(title: "提示", message: "请填写查询信息", delegate: nil, cancelButtonTitle: "返回").show()
        } else {
            var alertView = LoadAlert()
            alertView = LoadAlert.instantiateFromNib()
            alertView.center = CGPointMake(self.view.frame.width/2, self.view.frame.height/2)
            self.view.addSubview(alertView)
            let queue:dispatch_queue_t = dispatch_queue_create("my.concurrent.queue", DISPATCH_QUEUE_CONCURRENT)
            dispatch_async(queue, { () -> Void in
                NSThread.sleepForTimeInterval(2)
                alertView.removeFromSuperview()
                print("hello")
//                self.navigationController?.popViewControllerAnimated(true)
            })
            
            
        }
        
       
        
    }
    
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        if textField.tag == 101 {
            alertView = UIAlertView(title: "提示", message: "请选择性别", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "男","女")
            alertView.targetForAction("sexAlertAction:", withSender: self)
            alertView.tag = 101

        } else {
            alertView = UIAlertView(title: "提示", message: "请选择年龄", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "10 - 20", "21 - 25","25 - 30","30 - 40")
            alertView.tag = 102
            alertView.targetForAction("ageAlertAction:", withSender: self)
        }
        alertView.show()
        return false
    }
    
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if alertView.tag == 101 {
            let searchConditionTitleArray = ["男","女"]
            searchConditionSex.text = searchConditionTitleArray[buttonIndex - 1]
        } else {
            let searchConditionTitleArray = ["10 - 20", "21 - 25","25 - 30","30 - 40"]
            searchConditionAge.text = searchConditionTitleArray[buttonIndex - 1]

        }
    }
    
}
