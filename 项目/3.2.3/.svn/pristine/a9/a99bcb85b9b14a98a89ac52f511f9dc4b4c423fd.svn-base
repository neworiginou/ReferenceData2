//
//  HWCreateOrganizationNextStepView.swift
//  Partner-Swift
//
//  Created by hw500028 on 15/2/26.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

protocol HWCreateOrganizationNextStepViewDelegate:NSObjectProtocol
{
    func hwCreateOrganizationNextStepViewUpMessageClick()->Void
//    func gobackLogin(tel:String) -> Void
}

class HWCreateOrganizationNextStepView: HWBaseRefreshView,UITextFieldDelegate,HWEyeOpenViewDelegate,HWCountDownViewDelegate,UIAlertViewDelegate {
    var delegate:HWCreateOrganizationNextStepViewDelegate?
    var telPhoneTF:UITextField?
    var captchaTF:UITextField?
    var setPassWordTF:UITextField?
    var cityId = ""
    var orgName = ""
    var countDownView:HWCountDownView?
    var createSuccess:(() -> ())?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.baseTable.tableFooterView = footerViewFunc()
    }
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UITextFieldTextDidChangeNotification, object: telPhoneTF!)
    }

    func footerViewFunc()->UIView
    {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 100))
        footerView.backgroundColor = UIColor.clearColor()
        let commitBtn = UIButton(frame: CGRect(x: 15, y: 30, width: kScreenWidth - 30, height: 45))
        Utility.buttonStyle(commitBtn, color: CD_Btn_MainColor, title: "提交")
        commitBtn.addTarget(self, action: "commitAction", forControlEvents: UIControlEvents.TouchUpInside)
        footerView.addSubview(commitBtn)
        return footerView
    }
    
    //MARK:---tableviewDelegate
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
     func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0
        {
            return 0
        }
        else
        {
            return 10
        }
    }
    
     func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0
        {
            return 2
        }
        else
        {
            return 1
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let hwSection = indexPath.section
        let hwRow = indexPath.row
        let identify = "cell" + "\(hwSection)" + "\(hwRow)"
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(identify) as? UITableViewCell
        
        if cell == nil
        {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identify)
            if hwSection == 0 && hwRow == 0
            {
                telPhoneTF = UITextField(frame: CGRect(x: 15, y: 0, width: kScreenWidth - 15, height: 44))
                cell?.contentView.addSubview(telPhoneTF!)
                telPhoneTF!.placeholder = "请输入机构管理员手机号"
                telPhoneTF!.font = Define.font(TF_15)
                telPhoneTF!.keyboardType = UIKeyboardType.NumberPad
                telPhoneTF!.delegate = self
                cell?.contentView.drawBottomLine()
                cell?.contentView.drawTopLine()
                NSNotificationCenter.defaultCenter().addObserver(self, selector: "textChange:", name: UITextFieldTextDidChangeNotification, object: telPhoneTF!)
                
            }
            if hwSection == 0 && hwRow == 1
            {
                captchaTF = UITextField.newAutoLayoutView()
                cell?.contentView.addSubview(captchaTF!)
                captchaTF?.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 110))
                captchaTF?.font = Define.font(TF_15)
                captchaTF?.placeholder = "请输入接收到的验证码"
                captchaTF?.keyboardType = UIKeyboardType.NumberPad
                captchaTF?.delegate = self
                countDownView = HWCountDownView(frame: CGRect(x: kScreenWidth - 110, y: 0, width: 110, height: 44))
                countDownView!.delegate = self
                cell?.contentView.addSubview(countDownView!)
                cell?.contentView.drawBottomLine()

            }
            if hwSection == 1 && hwRow == 0
            {
                setPassWordTF = UITextField.newAutoLayoutView()
                cell?.addSubview(setPassWordTF!)
                setPassWordTF?.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 47))
                setPassWordTF?.placeholder = "设置密码"
                setPassWordTF?.font = Define.font(TF_15)
                setPassWordTF?.delegate = self
                cell?.contentView.drawBottomLine()
                cell?.contentView.drawTopLine()
                setPassWordTF?.secureTextEntry = true
                var eyeView = HWEyeOpenView(frame: CGRect(x: kScreenWidth - 47, y: 0, width: 47, height: 44))
                cell?.contentView.addSubview(eyeView)
                eyeView.delegate = self
            }

        }
        cell?.selectionStyle = UITableViewCellSelectionStyle.None
        return cell!
    }
    
     func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0
        {
            let hwView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 30))
            let hwLabel = UILabel(frame: CGRect(x: 15, y: 0, width: kScreenWidth - 15, height: 30))
            hwView.addSubview(hwLabel)
            hwLabel.text = "管理员信息 (开通经纪人帐号)"
            hwLabel.font = Define.font(TF_13)
            hwLabel.textColor = CD_Txt_Color_99
            return hwView
        }
        if section == 1
        {
            let hwView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 10))
            return hwView
            
        }
        return nil
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        self.endEditing(true)
    }
    
    //MARK:---textFeildDelegate
    
    //MARK:---HEEyeViewDelegate
    func hwEyeCloseSate() {
        setPassWordTF?.secureTextEntry = true
    }
    func hwEyeOpenSate() {
        setPassWordTF?.secureTextEntry = false
    }
    
    //MARK:---actions
    func commitAction()->Void
    {
        
        /*
        checkCode：*** - 验证码
        cityId：*** - 城市ID
        orgName:*** - 机构名称
        phone:*** - 管理员手机||经纪人手机
        password:*** - 管理员密码||经纪人密码(APP端MD5加密后传入)
        
        */
        
        if (Utility.validateMobile(telPhoneTF!.text!) == false)
        {
            Utility.showToastWithMessage("请输入正确的电话号码", _view: self)
            return 
        }
        if (captchaTF!.text.isEmpty)
        {
                Utility.showToastWithMessage("验证码不能为空", _view: self)
                return
        }
        if (Utility.validatePassWord(setPassWordTF!.text) == false)
        {
                    Utility.showToastWithMessage("密码为6-20位数字、字母或符号的组合", _view: self)
                    return
        }
        
      /*
        checkCode：*** - 验证码
        cityId：*** - 城市ID
        orgName:*** - 机构名称
        phone:*** - 管理员手机||经纪人手机
        password:*** - 管理员密码||经纪人密码(APP端MD5加密后传入)
        */
        Utility.showMBProgress(self, _message: "注册中")
        var param = NSMutableDictionary()
        param.setPObject(captchaTF!.text!, forKey: "checkCode")
        param.setPObject(HWUserLogin.currentUserLogin().cityId, forKey: "cityId")
        param.setPObject(telPhoneTF!.text, forKey: "phone")
        param.setPObject(setPassWordTF!.text.md5, forKey: "password")
        param.setObject(orgName, forKey: "orgName")
        var manager = HWHttpRequestOperationManager.baseManager()
            manager.postHttpRequest(kcreateOrganization, parameters: param, queue: nil, success: { (responseObject) -> Void in
                Utility.hideMBProgress(self)
                let dataDic:NSDictionary = responseObject.objectForKey("data") as NSDictionary
                HWUserLogin.currentUserLogin().initUserLogin(dataDic)
                HWUserLogin.currentUserLogin().key = responseObject.objectForKey("key") as String
                HWCoreDataManager.saveUserInfo()
                let userDefault = NSUserDefaults.standardUserDefaults()
                userDefault.setObject(self.telPhoneTF!.text!, forKey: kLastLoginTel)
                userDefault.synchronize()
                self.createSuccess?()
             
            }) { (code, error) -> Void in
            
                Utility.hideMBProgress(self)
                Utility.showToastWithMessage(error, _view: self)
                if error.isEqualToString("此号码已注册!")
                {
                    let hwAlert = UIAlertView(title: "提示", message: "此号码已注册!", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "重新注册", "登录")
                    hwAlert.show()
                    
                }
                
                
        }
    }
    func upMessageAction()->Void
    {
            if (delegate != nil && delegate?.respondsToSelector("hwCreateOrganizationNextStepViewUpMessageClick") != false)
            {
                delegate?.hwCreateOrganizationNextStepViewUpMessageClick()
            }

    }
    
    //MARK:---hwcountDownDelegate
    func countDownEnd() {
        
    }
    func countDownStart() {
        /*
        phone:*** - 手机号码
        type: ***  - 验证码类型(orgRegister机构注册,brokerRegister经纪人注册,forgetPasswd忘记密码,modifyPhone修改手机号)
        */
        var params = ["phone":telPhoneTF!.text!,"type":"orgRegister"]
        var manager = HWHttpRequestOperationManager.baseManager()
            manager.postHttpRequest(kGetCheckCode, parameters: params, queue: nil, success: { (responseObject) -> Void in
            
            
            }) { (failure, error) -> Void in
                
                
        }
        
        
    }
    
    func textChange(notify:NSNotification) -> Void
    {
        if notify.object as UITextField == telPhoneTF!
        {
            
            if countElements(telPhoneTF!.text) == 11 && countDownView?.state == State.end
            {
                countDownView?.countDownBtn?.userInteractionEnabled = true
                countDownView?.countDownBtn?.setBackgroundImage(Utility.imageWithColor(CD_GreenColor, _size: frame.size), forState: UIControlState.Normal)
            }
        }
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HWCreateOrganizationNextStepView:UITextFieldDelegate
{
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if textField == telPhoneTF!
        {
            if range.location >= 11 && range.length == 0
            {
                return false
            }
            else
            {
                if countDownView?.state == State.end
                {
                    countDownView?.countDownBtn?.userInteractionEnabled = false
                    countDownView?.countDownBtn?.setBackgroundImage(Utility.imageWithColor(CD_Btn_GrayColor_Clicked, _size: frame.size), forState: UIControlState.Normal)
                }
            }
        }
        
        return true
    }

    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 1
        {
            //重新注册
        }
        if buttonIndex == 2
        {
            //登录
//            if (delegate != nil && delegate?.respondsToSelector("gobackLogin:") != false)
//            {
//                delegate?.gobackLogin(telPhoneTF!.text)
//            }

            
        }
    }
    
}

