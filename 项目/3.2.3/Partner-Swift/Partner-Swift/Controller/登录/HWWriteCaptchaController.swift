//
//  HWWriteCaptchaController.swift
//  Partner-Swift
//
//  Created by hw500028 on 15/2/27.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWWriteCaptchaController: HWBaseViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,HWCountDownViewDelegate{
    var captchaTF:UITextField?
    var telPhoneLabel:UILabel?
    var telStr:String?
    var commitBtn:UIButton?
    var writeCaptchaView = HWBaseRefreshView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: contentHeight + 64))
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = Utility.navTitleView("填写验证码")
        self.view.addSubview(writeCaptchaView)
        writeCaptchaView.baseTable.dataSource = self
        writeCaptchaView.baseTable.delegate = self
        writeCaptchaView.baseTable.tableFooterView = footerViewFunc()
    }
    
    func footerViewFunc() -> UIView
    {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 200))
        commitBtn = UIButton(frame: CGRect(x: 15, y: 30, width: kScreenWidth - 30, height: 45))
        Utility.buttonStyle(commitBtn!, color: CD_Btn_MainColor, title: "提交")
        footerView.addSubview(commitBtn!)
        commitBtn?.addTarget(self, action: "commitAction", forControlEvents: UIControlEvents.TouchUpInside)
        let messageSetPWDBtn = UIButton.newAutoLayoutView()
        footerView.addSubview(messageSetPWDBtn)
        messageSetPWDBtn.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: 15)
        messageSetPWDBtn.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: commitBtn!, withOffset: 10)
        var attributeStr = NSMutableAttributedString(string: "收不到验证码?点击这里短信重置 ")
        attributeStr.addAttribute(NSUnderlineStyleAttributeName, value: NSUnderlineStyle.StyleSingle.rawValue, range: NSMakeRange(7, 8))
        attributeStr.addAttribute(NSUnderlineColorAttributeName, value: UIColor.blackColor(), range: NSMakeRange(7,9))
        messageSetPWDBtn.setAttributedTitle(attributeStr, forState: UIControlState.Normal)
        messageSetPWDBtn.addTarget(self, action: "messageAction", forControlEvents: UIControlEvents.TouchUpInside)
        messageSetPWDBtn.titleLabel?.font = Define.font(TF_13)
        return footerView
    }
    // MARK: - Table view data source
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let hwview = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 30))
        let hwlabel1 = UILabel.newAutoLayoutView()
        hwview.addSubview(hwlabel1)
        hwlabel1.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0), excludingEdge: ALEdge.Right)
        hwlabel1.text = "已将验证码发送至你的手机"
        hwlabel1.textColor = CD_Txt_Color_99
        hwlabel1.font = Define.font(TF_13)
        
        //
        telPhoneLabel = UILabel.newAutoLayoutView()
        hwview.addSubview(telPhoneLabel!)
        telPhoneLabel?.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: hwlabel1, withOffset: 10)
        telPhoneLabel?.autoAlignAxisToSuperviewAxis(ALAxis.Horizontal)
        telPhoneLabel?.text = telStr
        telPhoneLabel!.textColor = CD_Txt_Color_99
        telPhoneLabel!.font = Define.font(TF_13)
        
        return hwview
    }
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identify = "cell\(indexPath.section)\(indexPath.row)"
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(identify) as? UITableViewCell
        if cell == nil
        {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identify)
            captchaTF = UITextField.newAutoLayoutView()
            Utility.textFeildStyle(captchaTF!, placeHoderstr: "请输入验证码", superView: cell!.contentView)
            captchaTF!.delegate = self
            var countDownView = HWCountDownView(frame: CGRect(x: kScreenWidth - 110, y: 0, width: 110, height: 44))
            cell?.contentView.addSubview(countDownView)
            countDownView.delegate = self
            countDownView.countDownBtn?.setTitle("重新获取验证码", forState: UIControlState.Normal)
            countDownView.countDownBtn?.setBackgroundImage(Utility.imageWithColor(CD_GreenColor, _size: CGSize(width: 110, height: 44)), forState: UIControlState.Normal)
            countDownView.countDownBtn?.userInteractionEnabled = true
            cell?.contentView.drawTopLine()
            cell?.contentView.drawBottomLine()
        }
        
        return cell!
    }
    
    //MARK:---countDownDelegate
    func countDownEnd() {
        
    }
    func countDownStart() {
        /*
        phone:*** - 手机号码
        type: ***  - 验证码类型(orgRegister机构注册,brokerRegister经纪人注册,forgetPasswd忘记密码,modifyPhone修改手机号)
        */
        Utility.showMBProgress(self.view, _message: "发送中")
        var params = ["phone":telStr!,"type":"forgetPasswd"]
        var manager = HWHttpRequestOperationManager.baseManager()
        manager.postHttpRequest(kGetCheckCode, parameters: params, queue: nil, success: { (responseObject) -> Void in
            Utility.hideMBProgress(self.view)
            
            
            }) { (failure, error) -> Void in
                
                Utility.hideMBProgress(self.view)
                Utility.showToastWithMessage(error, _view: self.view)
                
        }

    }
    
    //MARK:---actions
    func commitAction() -> Void
    {
        
        if captchaTF!.text!.isEmpty
        {
            Utility.showToastWithMessage("验证码不能为空", _view: self.view)
        }
/*
        accountPhone:*** - 账户手机号
        checkCode:*** - 验证码
*/
        Utility.showMBProgress(self.view, _message: "发送中")
        var params = ["accountPhone":telStr!,"checkCode":captchaTF!.text!]
        var manager = HWHttpRequestOperationManager.baseManager()
            manager.postHttpRequest(kValidatePWDCheckCode, parameters: params, queue: nil, success: { (responseObject) -> Void in
                Utility.hideMBProgress(self.view)
            let setpasswordCtrl = HWSetPasswordTableViewController()
            self.navigationController?.pushViewController(setpasswordCtrl, animated: true)
                setpasswordCtrl.telStr = self.telStr!
            
            }) { (code, error) -> Void in
                Utility.hideMBProgress(self.view)
                Utility.showToastWithMessage(error, _view: self.view)

                
        }
        
    }
    
    func messageAction()
    {
        let messageCtrl = HWMessageSetPWDController()
        self.navigationController?.pushViewController(messageCtrl, animated: true)
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    
}
