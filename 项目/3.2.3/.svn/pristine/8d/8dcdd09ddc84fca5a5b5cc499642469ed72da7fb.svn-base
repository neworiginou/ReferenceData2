//
//  HWPersonRegisterView.swift
//  Partner-Swift
//
//  Created by hw500028 on 15/2/26.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

protocol HWPersonRegisterDelegate:NSObjectProtocol
{
    func hwPersonRegisterViewPushController(dic:NSDictionary)->Void
    func hwPersonRegisterViewUpmessageBtnClick() -> Void
}

class HWPersonRegisterView: HWBaseRefreshView,UITextFieldDelegate,HWCountDownViewDelegate {
    var invitationTF:UITextField?
    var telphoneTF:UITextField?
    var captchaTF:UITextField?
    var footerView:UIView?
    var nextStepBtn:UIButton?
    var countDownView:HWCountDownView?
    var delegate:HWPersonRegisterDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setIsNeedHeadRefresh(false)
        self.baseTable.frame = CGRectMake(self.baseTable.frame.origin.x, self.baseTable.frame.origin.y, self.baseTable.frame.size.width, contentHeight - 50)
        self.baseTable.tableFooterView = footerViewFunc()
        self.customerPhoneView();
    }
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UITextFieldTextDidChangeNotification, object: nil)
    }
    func customerPhoneView()->Void
    {
        let footerView = UIView(frame: CGRect(x: 0, y:  contentHeight - 50, width: kScreenWidth, height: 50))
        footerView.backgroundColor = UIColor.whiteColor();
        self.addSubview(footerView);
        
        var tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "chickPhone");
        footerView.addGestureRecognizer(tapGesture);
        
        let width = kScreenWidth/3.0;
        var customerTipLabel:UILabel = UILabel(frame: CGRectMake(0, 15, width, 20));
        customerTipLabel.text = "客服热线:";
        customerTipLabel.textColor = CD_Txt_Color_33;
        customerTipLabel.font = Define.font(15.0);
        customerTipLabel.textAlignment = NSTextAlignment.Right;
        footerView.addSubview(customerTipLabel);
        
        
        var phoneLabel:UILabel = UILabel(frame: CGRectMake(width, 15, width, 20));
        phoneLabel.text = "400-096-2882";
        phoneLabel.textColor = CD_OrangeColor;
        phoneLabel.font = Define.font(15.0);
        phoneLabel.textAlignment = NSTextAlignment.Center;
        footerView.addSubview(phoneLabel);
        
        
        
        var phoneIconImageV:UIImageView = UIImageView(frame: CGRectMake(2 * width, 15, 32, 32));
        phoneIconImageV.image = UIImage(named: "phone2");
        footerView.addSubview(phoneIconImageV);
    }
    func chickPhone()->Void
    {
        var callWebView = UIWebView()
        var telUrl = NSURL(string: "tel://"+"4000962882")
        callWebView .loadRequest(NSURLRequest(URL:telUrl!))

    }
    func footerViewFunc()->UIView
    {
        if footerView == nil
        {
            footerView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenRate, height: 200))
            //
            let upmessageBtn = HWUpMessageRegisterBtn(frame: CGRect(x: 15, y: 0, width: kScreenWidth - 15, height: 30))
            footerView?.addSubview(upmessageBtn)
            upmessageBtn.upMessageBtn?.addTarget(self, action: "upMessageBtnAction", forControlEvents: UIControlEvents.TouchUpInside)
            nextStepBtn = UIButton.newAutoLayoutView()
            footerView!.addSubview(nextStepBtn!)
            nextStepBtn!.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: 15)
            nextStepBtn!.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: 15)
            Utility.buttonStyle(nextStepBtn!, color: CD_Btn_GrayColor_Clicked, title: "下一步")
            nextStepBtn?.userInteractionEnabled = false
            nextStepBtn!.autoSetDimension(ALDimension.Height, toSize: 45)
            nextStepBtn!.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: upmessageBtn, withOffset: 30)
            nextStepBtn!.addTarget(self, action: "nextStepAction", forControlEvents: UIControlEvents.TouchUpInside)
        }
        return footerView!
    }
    
    //MARK:tableViewDelegate

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0
        {
            return 1
        }
        else
        {
            return 2
        }
    }
    
     func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
     func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
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
                invitationTF = UITextField.newAutoLayoutView()
                cell?.contentView.addSubview(invitationTF!)
                invitationTF?.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0))
                invitationTF?.delegate = self
                invitationTF?.placeholder = "请输入6位数加入邀请码"
               // invitationTF?.keyboardType = UIKeyboardType.NumberPad
                invitationTF?.font = Define.font(TF_14)
                cell?.contentView.drawTopLine()

            }
            
            if hwSection == 1 && hwRow == 0
            {
                telphoneTF = UITextField.newAutoLayoutView()
                cell?.contentView.addSubview(telphoneTF!)
                telphoneTF?.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0))
                telphoneTF?.placeholder = "请输入11位电话号码"
                telphoneTF?.keyboardType = UIKeyboardType.NumberPad
                telphoneTF?.delegate = self
                telphoneTF?.font = Define.font(TF_14)
                NSNotificationCenter.defaultCenter().addObserver(self, selector: "textfeildChange:", name: UITextFieldTextDidChangeNotification, object: nil)
                
                cell?.contentView.drawTopLine()

            }
            
            if hwSection == 1 && hwRow == 1
            {
                captchaTF = UITextField.newAutoLayoutView()
                cell?.contentView.addSubview(captchaTF!)
            captchaTF?.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0))
                captchaTF?.placeholder = "请输入您收到的验证码"
                captchaTF?.delegate = self
                captchaTF?.font = Define.font(TF_14)
                countDownView = HWCountDownView(frame: CGRect(x: kScreenWidth - 110, y: 0, width: 110, height: 44)) 
                cell?.contentView.addSubview(countDownView!)
                countDownView!.delegate = self

            }
            cell?.contentView.drawBottomLine()
        }
        cell!.selectionStyle = UITableViewCellSelectionStyle.None
        return cell!
    }
    
    //MARK:TextFeildDelegate
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if textField == invitationTF
        {
            if range.location >= 6 && range.length == 0
            {
                return false
            }
        }
        
        if textField == telphoneTF
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
    
    //MARK:Actions
    func nextStepAction()->Void
    {
        println("下一步")
        if (countElements(invitationTF!.text) < 6)
        {
        Utility.showToastWithMessage("请输入六位数邀请码", _view: self)
            return
        }
        if(Utility.validateMobile(telphoneTF!.text!) == false)
        {
            Utility.showToastWithMessage("请输入正确的电话号码", _view: self)
            return
        }
        if captchaTF!.text.isEmpty
        {
            Utility.showToastWithMessage("验证码不能为空", _view: self)
            return
        }
        /*
        inviteCode：*** - 邀请码
        phone:*** - 经纪人手机
        checkCode:*** - 验证码
        */
        Utility.showMBProgress(self, _message: "注册中")
        var params = ["inviteCode":invitationTF!.text,"phone":telphoneTF!.text,"checkCode":captchaTF!.text]
        var manager = HWHttpRequestOperationManager.baseManager()
            manager.postHttpRequest(kpersonCheckCode, parameters: params, queue: nil, success: { (responseObject) -> Void in
                Utility.hideMBProgress(self)
                var tempDic = responseObject.objectForKey("data") as? NSDictionary
                if tempDic != nil
                {
                    if (self.delegate != nil && self.delegate?.respondsToSelector("hwPersonRegisterViewPushController:") != false)
                    {
                        self.delegate?.hwPersonRegisterViewPushController(tempDic!)
                    }
                }

                
            }) { (failure, error) -> Void in
                Utility.hideMBProgress(self)
                Utility.showToastWithMessage(error, _view: self)

                
        }
        
        
        
    }
    
    func upMessageBtnAction()->Void
    {
        
            if (delegate != nil && delegate?.respondsToSelector("hwPersonRegisterViewUpmessageBtnClick") != false)
            {
                delegate?.hwPersonRegisterViewUpmessageBtnClick()
            }
    }
    
    func textfeildChange(notify:NSNotification)
    {
        var tf = notify.object as UITextField
        if Utility.validateMobile(tf.text) && countDownView?.state == State.end
        {
            
            countDownView?.countDownBtn?.userInteractionEnabled = true
            countDownView?.countDownBtn?.setBackgroundImage(Utility.imageWithColor(CD_GreenColor, _size: frame.size), forState: UIControlState.Normal)
            

        }
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        self.endEditing(true)
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension HWPersonRegisterView:HWCountDownViewDelegate
{
    func countDownEnd() {
        
        
    }

    func countDownStart() {
        
        
        /*
        
        phone:*** - 手机号码
        type: ***  - 验证码类型(orgRegister机构注册,brokerRegister经纪人注册,forgetPasswd忘记密码,modifyPhone修改手机号)
        */
        Utility .showMBProgress(self, _message: "获取中")
        var params = ["phone":telphoneTF!.text!,"type":"brokerRegister"]
        var manager = HWHttpRequestOperationManager.baseManager()
        manager.postHttpRequest(kGetCheckCode, parameters: params, queue: nil, success: { (responseObject) -> Void in
            Utility .hideMBProgress(self)
            Utility .showToastWithMessage("获取验证码成功", _view: self)
            
            }) { (failure, error) -> Void in
           Utility .hideMBProgress(self)
           Utility .showToastWithMessage(error, _view: self)
                
        }
        nextStepBtn?.userInteractionEnabled = true
         Utility.buttonStyle(nextStepBtn!, color: CD_MainColor, title: "下一步")
        
    }
    

}
