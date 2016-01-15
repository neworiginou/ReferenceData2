//
//  HWChangePasswordViewController.swift
//  HWUser
//
//  Created by wuxiaohong on 15/2/6.
//  Copyright (c) 2015年 hw. All rights reserved.
//

import UIKit

class HWChangePasswordViewController: HWBaseViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    
     var oldPwdTF =  UITextField()
     var newPwdTF = UITextField()
     var renewPwdTF = UITextField()
    override func viewWillAppear(animated: Bool)
    {
        self.navigationController?.navigationBarHidden = false
    }

     override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = Utility .navTitleView("修改密码")
        self.view.backgroundColor = CD_BackGroundColor
       
        // Do any additional setup after loading the view.
        
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
        
        let line = UIView(frame: CGRectMake(0, 10-0.5, self.view.frame.size.width,lineHeight))
        line.backgroundColor = CD_LineColor
        view.addSubview(line)
        //创建表尾
        let footView = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, 80 * kRate))
       
        tableView.tableFooterView = footView
        //创建lable
        let lable = UILabel(frame: CGRectMake(15, 0, self.view.frame.size.width-30, 40))
        lable.text = "密码长度6-20位字母、数字或符号"
        lable.font = Define.font(13)
        lable.textColor = CD_Txt_Color_99
        footView .addSubview(lable)
        //创建退出按钮
        let confirmBtn = UIButton(frame: CGRectMake(15, 45, self.view.frame.size.width-30, 45 * kRate))
        confirmBtn .setTitle("修改", forState: UIControlState.Normal)
        confirmBtn.backgroundColor  = CD_MainColor
        confirmBtn.layer.cornerRadius = 3
        confirmBtn .addTarget(self, action: "doConfirm", forControlEvents:UIControlEvents.TouchUpInside)
        footView .addSubview(confirmBtn)
        
        let tap = UITapGestureRecognizer (target: self, action: "doTap")
        tableView .addGestureRecognizer(tap)
        

    }
    //MARK:修改密码的请求
    func doConfirm()
    {
        if countElements(oldPwdTF.text) == 0
        {
            //-----****提示框***------
            Utility .showToastWithMessage("请输入当前密码", _view: self.view)
            return
        }
        if countElements(newPwdTF.text) == 0
        {
            //-----****提示框***------
             Utility .showToastWithMessage("请输入新密码", _view: self.view)
            return
        }
        if countElements(newPwdTF.text) < 6
        {
            //-----****提示框***------
            Utility .showToastWithMessage("密码不能小于六位数", _view: self.view)
            return
        }
        if countElements(newPwdTF.text) > 20
        {
            //-----****提示框***------
            Utility .showToastWithMessage("密码不能大于二十位数", _view: self.view)
            return
        }


        if countElements(renewPwdTF.text) == 0
        {
            //-----****提示框***------
             Utility .showToastWithMessage("请输入确认密码", _view: self.view)
            return
        }
     
        if renewPwdTF.text != newPwdTF.text
        {
            //-----****提示框***------
             Utility .showToastWithMessage("两次密码输入不一致", _view: self.view)
            return
        }
        
        if oldPwdTF.text == newPwdTF.text && oldPwdTF.text == renewPwdTF.text
        {
             //-----****提示框***------
             Utility .showToastWithMessage("新密码与原密码不一致", _view: self.view)
            return
        }
        
        Utility .showMBProgress(self.view, _message: "发送数据")
        let manager = HWHttpRequestOperationManager.baseManager()
        var param: NSMutableDictionary! = NSMutableDictionary()
        param .setObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param .setObject(oldPwdTF.text.md5, forKey: "oldPwd")
        param .setObject(newPwdTF.text.md5, forKey: "newPwd")
        manager .postHttpRequest(kpeersonalPwd, parameters: param, queue: nil, success: { (responseObject) -> Void in
//            println(responseObject)
            Utility .hideMBProgress(self.view)
            Utility .showToastWithMessage("修改成功", _view: self.view)
            
//            HWUserLogin.currentUserLogin().password = self.newPwdTF.text
            HWCoreDataManager .saveUserInfo()
            NSNotificationCenter .defaultCenter() .postNotificationName(kUpdateUserInfo, object: nil)
            var timer =  NSTimer .scheduledTimerWithTimeInterval(2, target: self, selector: "hidePop", userInfo: nil, repeats: true)
            }) { (code, error) -> Void in
                Utility .hideMBProgress(self.view)
                Utility .showToastWithMessage(error, _view: self.view)
        }
        

    }
    func hidePop()
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
    //MARK:添加手势
    func doTap()
    {
        self.view .endEditing(true)
        
    }
    //MARK:表的代理
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 45
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 3
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        let textFiled = UITextField()
        textFiled.frame = CGRectMake(15, 0, self.view.frame.size.width-30, 45 * kRate)
        textFiled.delegate = self
        textFiled.font = Define.font(15)
        textFiled.contentVerticalAlignment = UIControlContentVerticalAlignment(rawValue:0)!
        cell.contentView .addSubview(textFiled)
        textFiled.secureTextEntry = true
        let line  = UIView (frame: CGRectMake(0, 45-0.5, self.view.frame.size.width, lineHeight))
        line.backgroundColor = CD_LineColor
       // cell.contentView .addSubview(line)
        if indexPath.row == 0
        {
            textFiled.placeholder = "密码"
            oldPwdTF = textFiled
        }
        else if indexPath.row == 1
        {
            textFiled.placeholder = "新密码"
            newPwdTF = textFiled
        }
        else
        {
            textFiled.placeholder = "确认新密码"
            renewPwdTF = textFiled
        }
        cell .drawBottomLine()
        return cell
    }
      //MARK :textFiled 的代理
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        textField .resignFirstResponder()
        return true
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
