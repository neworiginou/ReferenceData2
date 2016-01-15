//
//  HWAddBrokerView.swift
//  Partner-Swift
//
//  Created by hw500028 on 15/3/2.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit
protocol HWAddBrokerViewDelegate:NSObjectProtocol
{
    func selectPosition() -> Void
}


class HWAddBrokerView: HWBaseRefreshView,UITextFieldDelegate,UIActionSheetDelegate {
    var brokerNameTF:UITextField?
    var brokerTelTF:UITextField?
    var brokerPositionLabel:UILabel?
    var model:HWBrokerModel?
    var storeModel:HWShopAdminHeaderModel?
    var delegate:HWAddBrokerViewDelegate?
    var ctrlType:ControllerType?
    var addBrokerSuccess:(() -> ())?
    override init(frame:CGRect)
    {
        super.init(frame: frame)
        self.baseTable.tableFooterView = footerViewFunc()
    }


    func footerViewFunc() -> UIView
    {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 100))
        let sureBtn = UIButton(frame: CGRect(x: 15, y: 30, width: kScreenWidth - 30, height: 45))
        Utility.buttonStyle(sureBtn, color: CD_Btn_MainColor, title: "确认")
        sureBtn.addTarget(self, action: "sureBtnAction", forControlEvents: UIControlEvents.TouchUpInside)
        footerView.addSubview(sureBtn)
        return footerView
    }
    
    //MARK:---tableVieDelegate
    
     func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
     func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
     override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section
        {
        case 0:
            return 2
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identify = "cell\(indexPath.section)\(indexPath.row)"
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(identify) as? UITableViewCell
        if cell == nil
        {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identify)
            if indexPath.section == 0 && indexPath.row == 0
            {
                cell?.drawTopLine()
                brokerNameTF = UITextField.newAutoLayoutView()
                Utility.textFeildStyle(brokerNameTF!, placeHoderstr: "请输入经纪人姓名", superView: cell!.contentView)
                brokerNameTF!.delegate = self
                if model != nil
                {
                    brokerNameTF?.text = model?.brokerName

                }
            }
            if indexPath.section == 0  && indexPath.row == 1
            {
                brokerTelTF = UITextField.newAutoLayoutView()
                brokerTelTF?.keyboardType = UIKeyboardType.NumberPad;
                Utility.textFeildStyle(brokerTelTF!, placeHoderstr: "请输入经纪人手机号", superView: cell!.contentView)
                let userDefault = NSUserDefaults.standardUserDefaults()
                let str = userDefault.valueForKey(kLastLoginTel) as String
                if model != nil
                {
                    if model!.phone == str
                    {
                        brokerTelTF?.userInteractionEnabled = false
                    }
                    brokerTelTF!.text = model?.phone

                }
                brokerTelTF!.delegate = self
            }
            if indexPath.section == 1 && indexPath.row == 0
            {
                cell?.drawTopLine()
                cell?.textLabel?.text = "职位"
                cell?.textLabel?.font = Define.font(TF_15)
                cell?.textLabel?.textColor = CD_Txt_Color_99
                
                //箭头
                let arrowImgV = UIImageView.newAutoLayoutView()
                cell?.contentView.addSubview(arrowImgV)
                arrowImgV.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: 15)
                arrowImgV.autoAlignAxisToSuperviewAxis(ALAxis.Horizontal)
                arrowImgV.autoSetDimensionsToSize(CGSize(width: 8, height: 14))
                arrowImgV.image = UIImage(named: "arrow_next")
                //职位
                brokerPositionLabel = UILabel.newAutoLayoutView()
                cell?.contentView.addSubview(brokerPositionLabel!)
                brokerPositionLabel?.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Left, ofView: arrowImgV, withOffset: -10)
                brokerPositionLabel?.autoAlignAxisToSuperviewAxis(ALAxis.Horizontal)
                if ctrlType == ControllerType.modify
                {
                    if model?.role == "ROLE_SHOPOWNER"
                    {
                        brokerPositionLabel?.text = "店长"
                    }
                    if model?.role == "ROLE_BROKER"
                    {
                        brokerPositionLabel?.text = "员工"
                    }

                }
                if ctrlType == ControllerType.addtional
                {
                    brokerPositionLabel?.text = "员工"

                }
                brokerPositionLabel?.font = Define.font(TF_15)
            }
        }
        cell?.contentView.drawBottomLine()
        return cell!
    }
    
     func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.section == 1 && indexPath.row == 0
        {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            let actionSheet = UIActionSheet()
            actionSheet.title = "选择职位"
            actionSheet.addButtonWithTitle("店长")
            actionSheet.addButtonWithTitle("员工")
            actionSheet.addButtonWithTitle("取消")
            actionSheet.cancelButtonIndex = 2
            actionSheet.destructiveButtonIndex = 2
            actionSheet.showInView(self)
            actionSheet.delegate = self
            if (delegate != nil && delegate?.respondsToSelector("selectPosition") != false)
            {
                delegate?.selectPosition()
            }

        }
    }
    //MARK:---textfeildDelegate
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if textField == brokerTelTF
        {
            if range.location >= 11 && range.length == 0
            {
                    return false
            }
        }
        return true
    }
    
    
    //MARK:---Action
    func sureBtnAction() -> Void
    {
        
        if brokerNameTF!.text.isEmpty
        {
            Utility.showToastWithMessage("经纪人姓名不能为空", _view: self)
            return
        }
        if brokerTelTF!.text.isEmpty
        {
            Utility.showToastWithMessage("经纪人电话不能为空", _view: self)
            return
        }
//        if countElements(brokerTelTF?.text) < 11
//        {
//            Utility.showToastWithMessage("经纪人电话不能小于11位", _view: self)
//            return
//        }
        if Utility.validateMobile(brokerTelTF!.text!) == false
        {
            Utility.showToastWithMessage("请输入正确的电话号码", _view: self)
            return
        }
        /*
        storeId=2
        name=zdw&
        phone=11111111112
        role=ROLE_BROKER
        */
        
        var param = NSMutableDictionary()
        
        param.setPObject(brokerNameTF!.text, forKey: "name")
        
        param.setPObject(brokerTelTF!.text, forKey: "phone")
        param .setObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        if brokerPositionLabel!.text == "店长"
        {
            param.setPObject("ROLE_SHOPOWNER", forKey: "role")

        }
        if brokerPositionLabel!.text == "员工"
        {
            param.setPObject("ROLE_BROKER", forKey: "role")

        }
        var urlStr = ""
        if ctrlType == ControllerType.addtional
        {
            urlStr = kAddBroker
            param.setPObject(storeModel!.id, forKey: "storeId")

        }
        else
        {
            urlStr = kModifyBroker
            param.setPObject(model!.brokerId, forKey: "brokerId")

        }
        Utility.showMBProgress(self, _message: "请求中")
        var manager = HWHttpRequestOperationManager.baseManager()
        manager.postHttpRequest(urlStr, parameters: param, queue: nil, success: { (responseObject) -> Void in
            Utility.hideMBProgress(self)
            NSNotificationCenter.defaultCenter().postNotificationName("addBrokerSuccess", object: nil)
            self.addBrokerSuccess?()
        
        }) { (code, error) -> Void in
            Utility.hideMBProgress(self)
            Utility.showToastWithMessage(error, _view: self)
        }
        
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:---actionSheetDelegate,scrollviewDelegate
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        self.endEditing(true)
        
    }
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        switch buttonIndex
        {
        case 0:
            brokerPositionLabel?.text = "店长"
        case 1:
            brokerPositionLabel?.text = "员工"
        default:
            return
        }
    }

}
