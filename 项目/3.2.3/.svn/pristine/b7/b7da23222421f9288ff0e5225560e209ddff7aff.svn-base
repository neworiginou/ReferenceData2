//
//  HWChangePhoneViewController.swift
//  HWUser
//
//  Created by wuxiaohong on 15/2/9.
//  Copyright (c) 2015年 hw. All rights reserved.
//

import UIKit

class HWChangePhoneViewController: HWBaseViewController,UITableViewDelegate,UITableViewDataSource,HWCountDownViewDelegate ,UITextFieldDelegate{
    var textFiledOne = UITextField()
    var textFiledTwo = UITextField()
    var textFiledThree = UITextField()
    var contentTime = 60
    var changePhone:UIViewController?
    var sendCodeBtn : HWCountDownView  = HWCountDownView(frame: CGRectMake(kScreenWidth-110, 0, 110, 44 * kRate))
    var timer = NSTimer()
    override func viewWillAppear(animated: Bool)
    {
        self.navigationController?.navigationBarHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
           
        self.navigationItem.titleView = Utility .navTitleView("修改手机号")
        self.view.backgroundColor = UIColor .clearColor()
        var tableView = UITableView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height * kRate))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = CD_BackGroundColor
        tableView.separatorStyle = UITableViewCellSeparatorStyle(rawValue:0)!
        self.view .addSubview(tableView)
        //创建表头
        let view = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, 10 * kRate))
        view.backgroundColor = CD_BackGroundColor
       // tableView.tableHeaderView = view
        
        let line = UIView(frame: CGRectMake(0, 10, self.view.frame.size.width, lineHeight))
        line.backgroundColor = CD_LineColor
        view.addSubview(line)
        //创建表尾
        let footView = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, 80 * kRate))
        tableView.tableFooterView = footView
        //创建退出按钮
        let logoutBtn = UIButton(frame: CGRectMake(15, 20, self.view.frame.size.width-30, 45 * kRate))
        logoutBtn .setTitle("确认", forState: UIControlState.Normal)
        logoutBtn.backgroundColor  = CD_MainColor
        logoutBtn.layer.cornerRadius = 3
        logoutBtn .addTarget(self, action: "doConfirm", forControlEvents:UIControlEvents.TouchUpInside)
        footView .addSubview(logoutBtn)
        
        let tap = UITapGestureRecognizer (target: self, action: "doTap")
        tableView .addGestureRecognizer(tap)
        
    }
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UITextFieldTextDidChangeNotification, object: nil)
    }
    
    //MARK:修改手机号的请求
    func doConfirm()
    {
        if textFiledOne.text == HWUserLogin.currentUserLogin().brokerTel
        {
            Utility .showToastWithMessage("与当前手机号一致", _view: self.view)
            return
        }
        if(Utility.validateMobile(textFiledOne.text!) == false)
        {
            Utility.showToastWithMessage("请输入正确的电话号码", _view: self.view)
            return
        }

        Utility .showMBProgress(self.view, _message: "修改中")
        let manager = HWHttpRequestOperationManager.baseManager()
        var param: NSMutableDictionary! = NSMutableDictionary()
        param .setObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param .setObject(textFiledOne.text, forKey: "newPhone")
        param .setObject(textFiledTwo.text, forKey: "checkCode")
        param .setObject(textFiledThree.text.md5, forKey: "passwd")
        manager .postHttpRequest(kPersonalPhone, parameters: param, queue: nil, success: { (responseObject) -> Void in
            Utility .hideMBProgress(self.view)
            Utility .showToastWithMessage("修改成功", _view: self.view)
            
            let responseDic: NSDictionary? = responseObject as NSDictionary
            HWUserLogin.currentUserLogin().brokerTel = self.textFiledOne.text
            
            HWCoreDataManager .saveUserInfo()
            NSNotificationCenter .defaultCenter() .postNotificationName(kUpdateUserInfo, object: nil)
            let vc = HWChangePhoneSuccedVC()
            vc.nameLab.text  = self.textFiledOne.text
            vc.changePhoneSuccess = self.changePhone
            self.navigationController?.pushViewController(vc, animated: true)

            }) { (code, error) -> Void in
                Utility .hideMBProgress(self.view)
                Utility .showToastWithMessage(error, _view: self.view)
               
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
        if section == 0
        {
          return 2
        }
        else
        {
            return 1
        }
        
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 2
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        let line  = UIView (frame: CGRectMake(0, 45-0.5, self.view.frame.size.width, lineHeight))
        line.backgroundColor = CD_LineColor
       // cell.contentView .addSubview(line)
        let textFiled = UITextField()
         cell.textLabel?.font = Define.font(15)
         textFiled.font = Define.font(15)
         cell.contentView .addSubview(textFiled)
        if indexPath.section == 0
        {
            if indexPath.row == 0
            {
            textFiled.frame = CGRectMake(90,0,150, 45 * kRate)
           
            textFiled.placeholder = "请输入手机号"
            //textFiled.text = HWUserLogin.currentUserLogin().brokerTel
            textFiled.delegate = self
            textFiled.textColor = CD_Txt_Color_99
            textFiled.keyboardType = UIKeyboardType.NumberPad
            textFiledOne = textFiled
            cell.textLabel?.text  = "手机号:"
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "textfeildChange:", name: UITextFieldTextDidChangeNotification, object: nil)
           
            
            }
            else
            {
                
                cell.textLabel?.text  = "验证码:"
                textFiled.frame = CGRectMake(90, 0, 100, 45 * kRate)
                textFiled.font = Define.font(15)
                sendCodeBtn.frame = CGRectMake(self.view.frame.size.width-110, 0, 110, 44 * kRate)
                sendCodeBtn.delegate = self
                 textFiled.keyboardType = UIKeyboardType.NumberPad
                cell.contentView .addSubview(sendCodeBtn)
             
                textFiledTwo = textFiled
                
            }
        }
        
        else
        {
            cell.textLabel?.text  = "当前密码:"
            textFiled.frame = CGRectMake(100, 0, 200, 45 * kRate)
            textFiled.placeholder = "请输入您的当前登录密码"
            textFiled.secureTextEntry = true
            textFiled.font = Define.font(15)
            textFiledThree = textFiled
        }
        cell .drawBottomLine()
        return cell
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let view = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, 30 * kRate))
        view.backgroundColor = CD_BackGroundColor
        let line1  = UIView()
        line1.backgroundColor = CD_LineColor
        view .drawBottomLine()
       // view .addSubview(line1)

       if section == 0
       {
          let lab = UILabel()
          lab.frame = CGRectMake(10, 0,self.view.frame.size.width,30 * kRate)
          lab.text = "新账号保留您原账户数据"
          lab.textAlignment = NSTextAlignment(rawValue: 0)!
          lab.font = UIFont .systemFontOfSize(13)
          lab.textColor = CD_Txt_Color_66
          line1.frame = CGRectMake(0, 30-0.5, self.view.frame.size.width, lineHeight)
          view .addSubview(lab)
        
       }
        else
       {
        
        line1.frame = CGRectMake(0, 10-0.5, self.view.frame.size.width, lineHeight)

       }
        
        return view
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        if section == 0
        {
            return 30 * kRate
            
        }
        else
        {
            return 10 * kRate
        }
    }
    //MARK:点击请求获取验证码的代理
    func countDownStart() -> Void
    {
        Utility .showMBProgress(self.view, _message: "获取中")
        let manager = HWHttpRequestOperationManager.baseManager()
        var param: NSMutableDictionary! = NSMutableDictionary()
        param .setObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param .setObject(textFiledOne.text, forKey: "phone")
        param .setObject("modifyPhone", forKey: "type")
        manager .postHttpRequest(kGetCheckCode, parameters: param, queue: nil, success: { (responseObject) -> Void in
            Utility .hideMBProgress(self.view)
            Utility .showToastWithMessage("获取成功", _view: self.view)
            
//            let responseDic: NSDictionary? = responseObject as NSDictionary
//            HWUserLogin.currentUserLogin().brokerTel = responseDic?.stringObjectForKey("data") as String
            
          //  HWCoreDataManager .saveUserInfo()
            NSNotificationCenter .defaultCenter() .postNotificationName(kUpdateUserInfo, object: nil)
            
            }) { (code, error) -> Void in
                Utility .hideMBProgress(self.view)
                Utility .showToastWithMessage(error, _view: self.view)
        }
        

    }
    func countDownEnd() -> Void
    {
        
    }
     //MARK:TextFeildDelegate
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool
    {
        if textField == textFiledTwo
        {
            if range.location >= 6 && range.length == 0
            {
                return false
            }
        }
        
        if textField == textFiledOne
        {
            if range.location >= 11 && range.length == 0
            {
                return false
            }
            
            else
            {
                if sendCodeBtn.state == State.end
                {
                    sendCodeBtn.countDownBtn?.userInteractionEnabled = false
                    sendCodeBtn.countDownBtn?.setBackgroundImage(Utility.imageWithColor(CD_Btn_GrayColor_Clicked, _size: self.view.frame.size), forState: UIControlState.Normal)
                    
                }
            }
        }
        return true
    }
    
    func textfeildChange(notify:NSNotification)
    {
        var tf = notify.object as UITextField
        if countElements(tf.text) == 11 && sendCodeBtn.state == State.end
        {
            
            sendCodeBtn.countDownBtn?.userInteractionEnabled = true
            sendCodeBtn.countDownBtn?.setBackgroundImage(Utility.imageWithColor(CD_GreenColor, _size: self.view.frame.size), forState: UIControlState.Normal)
            
        }
    }

        // Do any additional setup after loading the view.
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
