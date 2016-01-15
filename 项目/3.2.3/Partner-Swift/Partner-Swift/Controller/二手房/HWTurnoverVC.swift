//
//  HWTurnoverVC.swift
//  Partner-Swift
//
//  Created by wuxiaohong on 15/4/14.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWTurnoverVC: HWBaseViewController {
   var turnoverView = HWTurnoverView(frame: CGRectMake(0, 0, kScreenWidth, contentHeight))
    var houseId = NSString()
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
         self.navigationItem.titleView = Utility.navTitleView("成交确认")
         self.view .addSubview(turnoverView)
         var confirmBtn = UIButton(frame: CGRectMake(0, contentHeight-44, kScreenWidth, 44))
        confirmBtn.backgroundColor = CD_MainColor
        confirmBtn.addTarget(self, action: "confirmBtnClick", forControlEvents: .TouchUpInside)
        confirmBtn.setTitle("确认", forState: .Normal)
        confirmBtn.bringSubviewToFront(self.view)
        self.view .addSubview(confirmBtn)
        let tap = UITapGestureRecognizer (target: self, action: "doTap")
        self.view .addGestureRecognizer(tap)
        
    }
    func doTap()
    {
        self.view .endEditing(true)
    }
     func confirmBtnClick()
     {
               if turnoverView.moneyTextFiled.text == ""
        {
            Utility .showToastWithMessage("成交金额不能为空", _view: self.view)
            return;
        }
        if turnoverView.nameTextFiled.text == ""
        {
            Utility .showToastWithMessage("客户姓名不能为空", _view: self.view)
            return;
        }
        if turnoverView.phoneTextFiled.text == ""
        {
            Utility .showToastWithMessage("手机号码不能为空", _view: self.view)
            return;
        }

        if Utility .validateMobile(turnoverView.phoneTextFiled.text) == false
        {
            Utility .showToastWithMessage("请输入正确的手机号", _view: self.view)
            return;
        }

        Utility .showMBProgress(self.view, _message: "加载中")
        let manager = HWHttpRequestOperationManager.baseManager()
        var param = NSMutableDictionary()
        param .setObject(houseId, forKey: "houseId")
        param .setObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param .setObject(turnoverView.moneyTextFiled.text, forKey: "dealPrice")
        param .setObject(turnoverView.nameTextFiled.text, forKey: "dealClientPhone")
        param .setObject(turnoverView.phoneTextFiled.text, forKey: "dealClientName")
        manager .postHttpRequest(kScdHoudeal, parameters: param, queue: nil, success: { (responseObject) -> Void in
            Utility .hideMBProgress(self.view)
            Utility .showToastWithMessage("加载成功", _view: self.view)
            self.navigationController?.popViewControllerAnimated(true)
            
        }) { ( code, error) -> Void in
             Utility .hideMBProgress(self.view)
            Utility .showToastWithMessage(error,_view:self.view)
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
