//
//  HWAddCoilViewController.swift
//  Partner-Swift
//
//  Created by wuxiaohong on 15/4/27.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWAddCoilViewController: HWBaseViewController,UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,UITextFieldDelegate{
     var phoneTF = UITextField()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.titleView = Utility .navTitleView("添加下线")
        self.view.backgroundColor = CD_BackGroundColor
        var tableView = UITableView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height * kRate))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = CD_BackGroundColor
        tableView.separatorStyle = UITableViewCellSeparatorStyle(rawValue:0)!
        self.view .addSubview(tableView)
        //创建表头
        let view = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, 10 * kRate))
        view.backgroundColor = CD_BackGroundColor
        tableView.tableHeaderView = view
        tableView.tableHeaderView?.drawBottomLine()
        let line = UIView(frame: CGRectMake(0, 10, self.view.frame.size.width, lineHeight))
        line.backgroundColor = CD_LineColor
        // view.addSubview(line)
        //创建表尾
        let footView = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, 80 * kRate))
        tableView.tableFooterView = footView
        //创建退出按钮
        let logoutBtn = UIButton(frame: CGRectMake(15, 20, self.view.frame.size.width-30 , 45 * kRate))
        logoutBtn .setTitle("确定并生成邀请码", forState: UIControlState.Normal)
        logoutBtn.backgroundColor  = CD_MainColor
        logoutBtn.layer.cornerRadius = 3
        logoutBtn .addTarget(self, action: "doConfirm", forControlEvents:UIControlEvents.TouchUpInside)
        footView .addSubview(logoutBtn)
        
        let tap = UITapGestureRecognizer (target: self, action: "doTap")
        tableView .addGestureRecognizer(tap)
       
        
        
    }
    //MARK: UITextField的代理
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool
    {
         if textField == phoneTF
        {
            if countElements(textField.text) >= 11 && range.length == 0
            {
                return false
            }
        }
        return true
    }

    //MARK:修改姓名的请求
    func doConfirm()
    {
        if phoneTF.text == ""
        {
            Utility .showToastWithMessage("请输入下线手机号", _view: self.view)
            return
        }
        if Utility .validateMobile(phoneTF.text) == false
        {
            Utility .showToastWithMessage("请输入正确的手机号", _view: self.view)
            return
        }
//        if phoneTF.text == HWUserLogin.currentUserLogin().brokerTel
//        {
//            var alert = UIAlertView(title: "该手机号码已被注册，无法发送邀请码", message: "", delegate: nil, cancelButtonTitle: "取消", otherButtonTitles: "确定");
//            alert.show()
//            return
//           
//            
//        }
//        
        Utility .showMBProgress(self.view, _message: "发送数据")
        let manager = HWHttpRequestOperationManager.baseManager()
        var param: NSMutableDictionary! = NSMutableDictionary()
        param .setObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param .setObject(phoneTF.text, forKey: "phone")
        manager .postHttpRequest(kInviteCode, parameters: param, queue: nil, success: { (responseObject) -> Void in
            Utility .hideMBProgress(self.view)
            var dataDict: NSDictionary = responseObject.dictionaryObjectForKey("data")
            var state = dataDict .stringObjectForKey("state")
            var message = dataDict .stringObjectForKey("message")
            if state == "0"
            {
                var alert = UIAlertView(title: "邀请码发送成功", message:"本次的邀请码为"+message, delegate: self, cancelButtonTitle: "确定");
                alert.tag = 1001
                alert.show()

            }
            if state == "1"
            {
                var alert = UIAlertView(title: "", message:"邀请码发送失败", delegate: self, cancelButtonTitle: "确定", otherButtonTitles: "重新发送");
                alert.tag = 1000
                alert.show()
                
            }
            if state == "2"
            {
                var alert = UIAlertView(title: "", message:"该下线已注册为合伙人，如确定要转为下线，请先注销原账号", delegate: self, cancelButtonTitle: "确定");
                alert.show()
                
            }

                 }) { (code, error) -> Void in
                Utility .hideMBProgress(self.view)
                var alert = UIAlertView(title: "", message: error, delegate: self, cancelButtonTitle: "确定");
                 alert.show()
        }
        
        
    }
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int)
    {
        if alertView.tag == 1000
        {
            if buttonIndex == 1
            {
                self.doConfirm()
            }
        }
        
       if alertView.tag == 1001
        {
            if buttonIndex == 0
            {
                self.navigationController?.popViewControllerAnimated(true)
            }
            
        }
    }
    //MARK:添加手势
    func doTap()
    {
        self.view .endEditing(true)
        
    }
    //MARK:表的代理
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 45 * kRate
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        phoneTF.frame = CGRectMake(15, 0, self.view.frame.size.width-30, 45 * kRate)
        //nickNameTF.placeholder = "姓名"
//        nickNameTF.text = HWUserLogin.currentUserLogin().brokerName
        phoneTF.textColor = CD_Txt_Color_99
        phoneTF.font = Define.font(15)
        phoneTF.delegate = self
        phoneTF.contentVerticalAlignment = UIControlContentVerticalAlignment(rawValue:0)!
        phoneTF.placeholder = "请输入下线手机号"
        cell.contentView .addSubview(phoneTF)
        cell .drawBottomLine()
        return cell
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
