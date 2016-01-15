//
//  HWMeaageSetPWDController.swift
//  Partner-Swift
//
//  Created by hw500028 on 15/3/17.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit
import MessageUI
class HWMessageSetPWDController: HWBaseViewController,HWEyeOpenViewDelegate,UITextFieldDelegate,MFMessageComposeViewControllerDelegate {
    var pwdTF:UITextField?
    var shangxingMessagePhone = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = Utility.navTitleView("短信找回密码")
        //
        let hwlabel1 = UILabel.newAutoLayoutView()
        view.addSubview(hwlabel1)
        hwlabel1.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: 15)
        hwlabel1.autoSetDimension(ALDimension.Height, toSize: 40)
        hwlabel1.autoPinEdgeToSuperviewEdge(ALEdge.Top, withInset: 0)
        hwlabel1.text = "请用注册手机号进行短信密码修改\n短信费用一般为0.1元/条,由运营商收取"
        hwlabel1.numberOfLines = 0
        hwlabel1.font = Define.font(TF_13)
        //
        let hwView = UIView.newAutoLayoutView()
        view.addSubview(hwView)
        hwView.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
        hwView.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: hwlabel1, withOffset: 10)
        hwView.autoSetDimensionsToSize(CGSize(width: kScreenWidth, height: 44))
        hwView.backgroundColor = UIColor.whiteColor()
        hwView.drawBottomLine()
        hwView.drawTopLine()

        
        //
        pwdTF = UITextField.newAutoLayoutView()
        hwView.addSubview(pwdTF!)
        pwdTF!.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0))
        pwdTF!.placeholder = "请输入新密码"
        pwdTF!.font = Define.font(TF_15)
        pwdTF!.delegate = self
        pwdTF?.secureTextEntry = true
        let eyeBtn = HWEyeOpenView(frame: CGRect(x: kScreenWidth - 47, y: 0, width: 47, height: 44))
        hwView.addSubview(eyeBtn)
        eyeBtn.delegate = self
        //
        let hwlabel2 = UILabel.newAutoLayoutView()
        view.addSubview(hwlabel2)
        hwlabel2.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: 15)
        hwlabel2.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: pwdTF, withOffset: 15)
        hwlabel2.font = Define.font(TF_13)
        hwlabel2.text = "密码长度为6-20位字母、数字或符号"
        //
        let setBtn = UIButton.newAutoLayoutView()
        view.addSubview(setBtn)
        setBtn.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: hwlabel2, withOffset: 30)
        setBtn.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
        setBtn.autoSetDimensionsToSize(CGSize(width: kScreenWidth - 30, height: 44))
        Utility.buttonStyle(setBtn, color: CD_Btn_MainColor, title: "短信密码重置")
        setBtn.addTarget(self, action: "setBtn", forControlEvents: UIControlEvents.TouchUpInside)
        queryServiceNumber()
        
        //收回键盘手势
        let hideKeyboard = UITapGestureRecognizer(target: self, action: "hideKeyboard")
        view.addGestureRecognizer(hideKeyboard)
        
    }

    
    func queryServiceNumber()
    {
        Utility.showMBProgress(view, _message: "发送中")
        var manager = HWHttpRequestOperationManager.baseManager()
        manager.postHttpRequest(kServiceNum, parameters: nil, queue: nil, success: { (responseObject) -> Void in
            
            let serviceNum = responseObject.objectForKey("data") as String
            self.shangxingMessagePhone = serviceNum
            Utility.hideMBProgress(self.view)
            
            }) { (failure, error) -> Void in
                Utility.hideMBProgress(self.view)
        }
    }
    
    func setBtn()
    {
        if (Utility.validatePassWord(pwdTF!.text) == false)
        {
            Utility.showAlertWithMessage("密码为6-20数字、字母或符号的组合")
            return
        }
        if shangxingMessagePhone.isEmpty
        {
            Utility.showAlertWithMessage("没有服务号码")
            return
        }
        var MFCtrl = MFMessageComposeViewController()
        if MFMessageComposeViewController.canSendText() == true
        {
            MFCtrl.body = "hhrzhmm#" + pwdTF!.text
            MFCtrl.recipients = [shangxingMessagePhone]
            MFCtrl.messageComposeDelegate = self
            self.presentViewController(MFCtrl, animated: true, completion: nil)
        }
    }

    // MARK:---收起键盘
    func hideKeyboard()
    {
        view.endEditing(true)
    }
}

extension HWMessageSetPWDController:MFMessageComposeViewControllerDelegate
{
    func messageComposeViewController(controller: MFMessageComposeViewController!, didFinishWithResult result: MessageComposeResult) {
        controller.dismissViewControllerAnimated(true, completion: nil)
        if result.value == MessageComposeResultCancelled.value
        {
            Utility.showToastWithMessage("取消发送", _view: self.view)
        }
        if result.value == MessageComposeResultSent.value
        {
            Utility.showToastWithMessage("发送成功", _view: self.view)
        }
        if result.value == MessageComposeResultFailed.value
        {
            Utility.showToastWithMessage("发送失败", _view: self.view)
        }
    }

}

extension HWMessageSetPWDController:HWEyeOpenViewDelegate
{
    func hwEyeOpenSate() {
        pwdTF?.secureTextEntry = false
        let str = pwdTF!.text
        pwdTF?.text = nil
        pwdTF?.text = str

    }
    func hwEyeCloseSate() {
        pwdTF?.secureTextEntry = true
        let str = pwdTF!.text
        pwdTF?.text = nil
        pwdTF?.text = str

    }

}

extension HWMessageSetPWDController:UITextFieldDelegate
{
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if range.location >= 11 && range.length == 0
        {
            return false
        }
        return true
    }
}
