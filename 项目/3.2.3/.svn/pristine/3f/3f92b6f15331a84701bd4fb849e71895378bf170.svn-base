//
//  HWForgetPasswordController.swift
//  Partner-Swift
//
//  Created by hw500028 on 15/2/27.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWForgetPasswordController: HWBaseViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate {
   var forgetPasswordView = HWBaseRefreshView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: contentHeight + 64))
    var telPhoneTF:UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = Utility.navTitleView("找回密码")
        self.view.addSubview(forgetPasswordView)
        forgetPasswordView.baseTable.dataSource = self
        forgetPasswordView.baseTable.delegate = self
        forgetPasswordView.baseTable.tableFooterView = footerViewFunc()
    }
    
    
    func footerViewFunc() -> UIView
    {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 100))
        let getCaptchaBtn = UIButton(frame: CGRect(x: 15, y: 30, width: kScreenWidth - 30, height:45))
        Utility.buttonStyle(getCaptchaBtn, color: CD_Btn_MainColor, title: "获取验证码")
        getCaptchaBtn.addTarget(self, action: "getCaptchaBtnClick", forControlEvents: UIControlEvents.TouchUpInside)
        footerView.addSubview(getCaptchaBtn)
        return footerView
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identify = "cell\(indexPath.section)\(indexPath.row)"
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(identify) as? UITableViewCell
        if cell == nil
        {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identify)
            telPhoneTF = UITextField.newAutoLayoutView()
            Utility.textFeildStyle(telPhoneTF!, placeHoderstr: "请输入电话号码", superView: cell!.contentView)
            telPhoneTF!.delegate  = self
            telPhoneTF?.keyboardType = UIKeyboardType.NumberPad
            cell?.contentView.drawBottomLine()
            cell?.contentView.drawTopLine()
        }
        
        return cell!
    }
    
    // MARK: - Table view data source
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    //MARK:---actions
    func getCaptchaBtnClick() -> Void
    {
     
        if Utility.validateMobile(telPhoneTF!.text!) == false
        {
            Utility.showToastWithMessage("请输入正确的电话号码", _view: self.view)
            return
        }
        var params = ["phone":telPhoneTF!.text,"type":"forgetPasswd"]
        var manager = HWHttpRequestOperationManager.baseManager()
        manager.postHttpRequest(kGetCheckCode, parameters: params, queue: nil, success: { (responseObject) -> Void in
         //   Utility .showToastWithMessage("验证码发送成功", _view: self.view)
            
            }) { (failure, error) -> Void in
          Utility .showToastWithMessage(error, _view: self.view)
                
                
        }
        let writeCaptchaCtrl = HWWriteCaptchaController()
        self.navigationController?.pushViewController(writeCaptchaCtrl, animated: true)
        writeCaptchaCtrl.telStr = self.telPhoneTF!.text!

        
    }

    //MARK:---textFeildDelegate
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if range.location >= 11 && range.length == 0
        {
            return false
        }
        return true
    }

}
