//
//  HWSetPasswordTableViewController.swift
//  Partner-Swift
//
//  Created by hw500028 on 15/2/27.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit
class HWSetPasswordTableViewController: HWBaseViewController,HWSetPasswordViewDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate {
    var setPasswordTF:UITextField?
    var setPasswordView = HWBaseRefreshView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: contentHeight + 64))
    var telStr = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = Utility.navTitleView("找回密码")
        self.view.addSubview(setPasswordView)
        setPasswordView.baseTable.dataSource = self
        setPasswordView.baseTable.delegate = self
        setPasswordView.baseTable.tableFooterView = footerViewFunc()
        setPasswordView.baseTable.rowHeight = 44
        
    }

    func footerViewFunc() -> UIView
    {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 100))
        let hwlabel = UILabel.newAutoLayoutView()
        footerView.addSubview(hwlabel)
        hwlabel.autoPinEdgeToSuperviewEdge(ALEdge.Top, withInset: 10)
        hwlabel.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: 15)
        hwlabel.text = "密码长度6-20位字母、数字或符号"
        hwlabel.textColor = CD_Txt_Color_99
        hwlabel.font = Define.font(TF_13)
        
        //
        let completeBtn = UIButton.newAutoLayoutView()
        footerView.addSubview(completeBtn)
        completeBtn.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: hwlabel, withOffset: 20)
        completeBtn.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
        completeBtn.autoSetDimensionsToSize(CGSize(width: kScreenWidth - 30, height: 45))
        Utility.buttonStyle(completeBtn, color: CD_Btn_MainColor, title: "完成")
        completeBtn.addTarget(self, action: "completeAction", forControlEvents: UIControlEvents.TouchUpInside)
        return footerView
    }
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identify = "cell\(indexPath.section)\(indexPath.row)"
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(identify) as? UITableViewCell
        if cell == nil
        {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identify)
            setPasswordTF = UITextField.newAutoLayoutView()
            Utility.textFeildStyle(setPasswordTF!, placeHoderstr: "设置密码", superView: cell!.contentView)
            setPasswordTF!.delegate = self
        }
        cell?.contentView.drawBottomLine()
        cell?.contentView.drawTopLine()
        return cell!
    }
    
    //MARK:---action
    func completeAction() -> Void
    {
        /*
        accountPhone:*** - 账户手机号
        password:*** - 密码
        */
        
        if setPasswordTF!.text!.isEmpty
        {
            Utility.showToastWithMessage("密码不能为空", _view: self.view)
            return
        }
        
        if (Utility.validatePassWord(setPasswordTF!.text) == false)
        {
            Utility.showToastWithMessage("密码为6-20位数字、字母或符号的组合", _view: self.view)
            return
        }
        Utility.showMBProgress(self.view, _message: "修改中")
        var param = NSMutableDictionary()
        param.setPObject(telStr, forKey: "accountPhone")
        param.setPObject(setPasswordTF!.text!.md5, forKey: "password")
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        var manager = HWHttpRequestOperationManager.baseManager()
            manager.postHttpRequest(kSetForgetPWD, parameters: param, queue: nil, success: { (responseObject) -> Void in
                Utility.hideMBProgress(self.view)
                let userdefault = NSUserDefaults.standardUserDefaults()
                userdefault.setObject(self.telStr, forKey: kLastLoginTel)
                self.navigationController?.popToViewController(shareAppDelegate.loginCtrl!, animated: true)
                
                
            }) { (code, error) -> Void in
                
                Utility.hideMBProgress(self.view)
                Utility.showToastWithMessage(error, _view: self.view)
                
        }
    
    }


//MARK:---actions
    func SetPasswordViewCompleteBtnClick() {
        
    }
    
}
