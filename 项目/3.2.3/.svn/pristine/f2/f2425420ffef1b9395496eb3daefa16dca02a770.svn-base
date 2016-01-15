//
//  HWPersonRegisterNextStepView.swift
//  Partner-Swift
//
//  Created by hw500028 on 15/2/26.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

protocol HWPersonRegisterNextStepViewDelegate:NSObjectProtocol
{
    func hwPersonRegisterNextStepViewSureBtnClick(view:UIView)->Void
}

class HWPersonRegisterNextStepView: HWBaseRefreshView,UITextFieldDelegate {
    var nameTF:UITextField?
    var passWordTF:UITextField?
    var organizationLabel:UILabel?
    var shopLabel:UILabel?
    var delegate:HWPersonRegisterNextStepViewDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setIsNeedHeadRefresh(false)
        self.baseTable.tableFooterView = footerViewFunc()
        self.baseTable.tableHeaderView = headerViewFunc()
    }

    var dicInfo:NSDictionary = NSDictionary()
    {
        didSet
        {
            organizationLabel?.text = dicInfo.stringObjectForKey("orgName")
            shopLabel?.text = dicInfo.stringObjectForKey("stroeName")
        }
    }
    func headerViewFunc()->UIView
    {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 100 * kScreenRate))
        //门店信息
        let label1 = UILabel.newAutoLayoutView()
        headerView.addSubview(label1)
        label1.autoPinEdgeToSuperviewEdge(ALEdge.Top, withInset: 15)
        label1.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: 15)
        label1.text = "门店信息"
        label1.textColor = CD_Txt_Color_99
        label1.font = Define.font(TF_12)
        //机构
        let label2 = UILabel.newAutoLayoutView()
        headerView.addSubview(label2)
        label2.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: 15)
        label2.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: label1, withOffset: 5)
        label2.font = Define.font(TF_14)
        label2.text = "机构:"
        //门店
        let label3 = UILabel.newAutoLayoutView()
        headerView.addSubview(label3)
        label3.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: label2, withOffset: 5)
        label3.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: 15)
        label3.text = "门店:"
        label3.backgroundColor = UIColor.clearColor()
        label3.font = Define.font(TF_14)
        
        //
        organizationLabel = UILabel.newAutoLayoutView()
        headerView.addSubview(organizationLabel!)

        organizationLabel?.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: 10)
        organizationLabel?.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: label2, withOffset: 10)
        organizationLabel?.autoAlignAxis(ALAxis.Horizontal, toSameAxisOfView: label2)
        organizationLabel?.font = Define.font(TF_14)
        organizationLabel?.backgroundColor = UIColor.clearColor()
        //
        
        shopLabel = UILabel.newAutoLayoutView()
        headerView.addSubview(shopLabel!)
        shopLabel?.autoAlignAxis(ALAxis.Horizontal, toSameAxisOfView: label3)
        shopLabel?.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: label3, withOffset: 10)
//
        shopLabel?.font = Define.font(TF_14)
        shopLabel?.backgroundColor = UIColor.clearColor()
//
        return headerView
    }
    
    
    func footerViewFunc()->UIView
    {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 100))
        let sureBtn = UIButton.newAutoLayoutView()
        footerView.addSubview(sureBtn)
        sureBtn.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 15, left: 15, bottom: 0, right: 15), excludingEdge: ALEdge.Bottom)
        sureBtn.autoSetDimension(ALDimension.Height, toSize: 45)
        Utility.buttonStyle(sureBtn, color: CD_Btn_MainColor, title: "确认")
        sureBtn.addTarget(self, action: "sureBtnAction", forControlEvents: UIControlEvents.TouchUpInside)
        
        return footerView
    }
    
    //MARK:tableViewDelegate
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
     func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
     func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0
        {
            return 10
        }
        else
        {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let hwSection = indexPath.section
        let hwRow = indexPath.row
        let identify = "cell\(hwSection)\(hwRow)"
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(identify) as? UITableViewCell
        if cell == nil
        {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier:identify)
            if hwSection == 0 && hwRow == 0
            {
                cell?.textLabel?.text = "姓名"
                cell?.textLabel?.font = Define.font(TF_15)
                nameTF = UITextField.newAutoLayoutView()
                cell?.contentView.addSubview(nameTF!)
                nameTF?.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 0, left: 85, bottom: 0, right: 0))
                nameTF?.placeholder = "请输入你的姓名"
                nameTF?.delegate = self
                nameTF?.font = Define.font(TF_15)
                cell?.contentView.drawTopLine()
                
            }
            if hwSection == 1 && hwRow == 0
            {
                cell?.textLabel?.text = "设置密码"
                cell?.textLabel?.font = Define.font(TF_15)
                passWordTF = UITextField.newAutoLayoutView()
                cell?.contentView.addSubview(passWordTF!)
                passWordTF?.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 0, left: 85, bottom: 0, right: 0))
                passWordTF?.placeholder = "6-20位数字、字母或符号"
                passWordTF?.delegate = self
                passWordTF?.secureTextEntry = true
                cell?.contentView.drawTopLine()

            }
            
            cell?.contentView.drawBottomLine()
        }
        return cell!
    }
    
    
    //MARK:---Actions
    func sureBtnAction()->Void
    {
        
        if (nameTF!.text.isEmpty)
        {
            Utility.showToastWithMessage("姓名不能为空", _view: self)
            return
        }
        if (Utility.validatePassWord(passWordTF!.text) == false)
        {
         Utility.showToastWithMessage("密码为6-20位数字、字母或符号的组合", _view: self)
            return
        }
        Utility.showMBProgress(self, _message: "提交中")
        /*
        storeId: *** - 门店id
        phone:*** - 经纪人手机
        name:*** - 经纪人姓名
        password:*** - 经纪人密码(APP端MD5加密后传入)
        */
//        var params = ["phone":telNum,"name":nameTF!.text,"password":passWordTF!.text.md5]
        var params = NSMutableDictionary()
        params.setPObject(dicInfo.stringObjectForKey("phone"), forKey: "phone")
        params.setPObject(dicInfo.stringObjectForKey("inviteCode"), forKey: "inviteCode")
        params.setPObject(nameTF!.text, forKey: "name")
        params.setPObject(passWordTF!.text.md5, forKey: "password")
        params.setPObject(dicInfo.stringObjectForKey("storeId"), forKey: "storeId")
        var manager = HWHttpRequestOperationManager.baseManager()
            manager.postHttpRequest(kpersonRegister, parameters: params, queue: nil, success: { (responseObject) -> Void in
                Utility.hideMBProgress(self)
                let dataDic = responseObject.objectForKey("data") as NSDictionary
            //存用户信息 
                HWUserLogin.currentUserLogin().initUserLogin(dataDic)
                HWUserLogin.currentUserLogin().key = responseObject.objectForKey("key") as String
                HWCoreDataManager.saveUserInfo()
                let userDefault = NSUserDefaults.standardUserDefaults()
                userDefault.setObject(self.dicInfo.stringObjectForKey("phone"), forKey: kLastLoginTel)
            if (self.delegate != nil && self.delegate?.respondsToSelector("hwPersonRegisterNextStepViewSureBtnClick:") != false)
            
           {
                self.delegate?.hwPersonRegisterNextStepViewSureBtnClick(self)
            }
 
            
            
            }) { (code, error) -> Void in
            
                Utility.hideMBProgress(self)
                Utility.showToastWithMessage(error, _view: self)

        }
        
    }
    
// MARK:---textFeildDelegate
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if textField == passWordTF
        {
        
            if range.location >= 20 && range.length == 0
            {
                return false
            }
        }
        return true
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        self.endEditing(true)
    }
}
