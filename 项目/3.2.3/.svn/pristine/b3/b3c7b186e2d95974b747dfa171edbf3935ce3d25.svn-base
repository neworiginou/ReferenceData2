//
//  HWUpRegisterViewController.swift
//  Partner-Swift
//
//  Created by hw500028 on 15/2/27.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit
import MessageUI
class HWUpRegisterViewController: HWBaseViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,MFMessageComposeViewControllerDelegate {
    var shangxingMessagePhone = ""
    var passwordTF:UITextField?
    var cityLabel:UILabel?
    var nameTF:UITextField?
    var captchaTF:UITextField?
    var upMessageView:HWBaseRefreshView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = Utility.navTitleView("短信注册")
        upMessageView = HWBaseRefreshView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: UIScreen.mainScreen().bounds.size.height))
        self.view.addSubview(upMessageView)
        upMessageView.baseTable.dataSource = self
        upMessageView.baseTable.delegate = self
        upMessageView.baseTable.tableFooterView = footerViewFunc()
        queryServiceNumber()
    
    }

    func footerViewFunc()->UIView
    {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 100))
        let messageRegisterBtn = UIButton(frame: CGRect(x: 15, y: 30, width: kScreenWidth - 30, height: 45))
        footerView.addSubview(messageRegisterBtn)
        Utility.buttonStyle(messageRegisterBtn, color: CD_Btn_MainColor, title: "短信注册")
        messageRegisterBtn.addTarget(self, action: "messageRegisterBtnClick", forControlEvents: UIControlEvents.TouchUpInside)
        return footerView
    }
    
    //MARK:---tableViewDelegate
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section
        {
        case 0:return 1;
        case 1:return 2;
        case 2:return 1;
        default:return 0
        }
        
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section
        {
        case 0: return 50;
        case 1: return 30;
        case 2: return 10;
        default: return 0
        }
        
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0
        {
            let hwView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 45))
            let hwlabel1 = UILabel.newAutoLayoutView()
            hwView.addSubview(hwlabel1)
            hwlabel1.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: 15)
            hwlabel1.autoPinEdgeToSuperviewEdge(ALEdge.Top, withInset: 10)
            hwlabel1.text = "请用注册手机号进行短信注册"
            hwlabel1.textColor = CD_Txt_Color_99
            hwlabel1.font = Define.font(TF_13)
            let hwlabel2 = UILabel.newAutoLayoutView()
            hwView.addSubview(hwlabel2)
            hwlabel2.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: 15)
            hwlabel2.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: hwlabel1, withOffset: 0)
            //            hwlabel2.autoAlignAxisToSuperviewAxis(ALAxis.Horizontal)
            hwlabel2.autoAlignAxis(ALAxis.Vertical, toSameAxisOfView: hwlabel1)
            hwlabel2.text = "短信费用一般0.1元/条,由运营商收取"
            hwlabel2.textColor = CD_Txt_Color_99
            hwlabel2.font = Define.font(TF_13)
            
            return hwView
        }
        else if section == 1
        {
            let hwView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 30))
            let hwlabel1 = UILabel.newAutoLayoutView()
            hwView.addSubview(hwlabel1)
            hwlabel1.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: 15)
            hwlabel1.autoAlignAxisToSuperviewAxis(ALAxis.Horizontal)
            hwlabel1.text = "密码长度为6-20位字母、数字或符号"
            hwlabel1.textColor = CD_Txt_Color_99
            hwlabel1.font = Define.font(TF_13)
            return hwView
        }
        
        return nil
    }
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let hwSection = indexPath.section
        let hwRow = indexPath.row
        let identify = "cell" + "\(hwSection)" + "\(hwRow)"
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(identify) as? UITableViewCell
        if cell == nil
        {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identify)
            if hwSection == 0 && hwRow == 0
            {
                passwordTF = UITextField.newAutoLayoutView()
                Utility.textFeildStyle(passwordTF!, placeHoderstr: "密码", superView: cell!.contentView)
                passwordTF!.delegate = self
                cell?.contentView.drawTopLine()
            }
            if hwSection == 1 && hwRow == 0
            {
                nameTF = UITextField.newAutoLayoutView()
                Utility.textFeildStyle(nameTF!, placeHoderstr: "姓名", superView: cell!.contentView)
                nameTF!.delegate = self
                cell?.contentView.drawTopLine()
            }
            if hwSection == 1 && hwRow == 1
            {
                let arrowImage = UIImageView.newAutoLayoutView()
                cell?.contentView.addSubview(arrowImage)
                arrowImage.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: 15)
                arrowImage.autoAlignAxisToSuperviewAxis(ALAxis.Horizontal)
                arrowImage.autoSetDimensionsToSize(CGSize(width: 8, height: 14))
                arrowImage.image = UIImage(named: "arrow_next")
                cityLabel = UILabel.newAutoLayoutView()
                cell?.contentView.addSubview(cityLabel!)
                cityLabel?.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0), excludingEdge: ALEdge.Right)
                cityLabel?.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Left, ofView: arrowImage)
                cityLabel?.text = "上海"
                cityLabel?.textColor = CD_Txt_Color_99
                cityLabel?.font = Define.font(TF_15)
                
            }
            
            if hwSection == 2 && hwRow == 0
            {
                captchaTF = UITextField.newAutoLayoutView()
                Utility.textFeildStyle(captchaTF!, placeHoderstr: "请输入邀请码", superView: cell!.contentView)
                captchaTF!.delegate = self
                cell?.contentView.drawTopLine()
            }
        }
        
        cell?.contentView.drawBottomLine()
        return cell!
    }
    
     func scrollViewDidScroll(scrollView: UIScrollView) {
        self.view.endEditing(true)
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.upMessageView.bounds.origin.y = 0
        })
        
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if (indexPath.section == 1 && indexPath.row == 1)
        {
            let teamworkcityCtrl = HWTeamworkCityListController()
            teamworkcityCtrl.selectCityCell =
            { cityName in
                self.cityLabel!.text = cityName
            }
            self.navigationController?.pushViewController(teamworkcityCtrl, animated: true)
        }
        
        
    }
    //MARK:---获取上行短信服务号码
    
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
    
    //MARK:---actions
    func messageRegisterBtnClick()
    {
        if shangxingMessagePhone.isEmpty
        {
            Utility.showToastWithMessage("无服务号码", _view: self.view)
            return
        }
        if passwordTF!.text!.isEmpty
        {
            Utility.showToastWithMessage("密码不能为空", _view: self.view)
            return
        }
        if countElements(passwordTF!.text!) < 6 || countElements(passwordTF!.text!) > 20
        {
            Utility.showToastWithMessage("密码长度为6-20位字母、数字或符号", _view: self.view)
        }
        if nameTF!.text!.isEmpty
        {
            Utility.showToastWithMessage("姓名不能为空", _view: self.view)
            return
        }
        if captchaTF!.text!.isEmpty
        {
            Utility.showToastWithMessage("邀请码不能为空", _view: self.view)
            return
        }
        
        sendMSM("hhrzc#\(passwordTF!.text!)#\(nameTF!.text!)#\(cityLabel!.text!)#\(captchaTF!.text!)", recipientList: [self.shangxingMessagePhone])
    }
    
    func sendMSM(message:String,recipientList lists:[String]) -> Void
    {
    
        var MFCtrl = MFMessageComposeViewController()
        if MFMessageComposeViewController.canSendText() == true
        {
            MFCtrl.messageComposeDelegate = self
            MFCtrl.body = message
            MFCtrl.recipients = lists
            self.presentViewController(MFCtrl, animated: true, completion: nil)
        }
        
    }
//MARK:---messageComposeViewControllerDelegate
    func messageComposeViewController(controller: MFMessageComposeViewController!, didFinishWithResult result: MessageComposeResult) {
        
        controller.dismissViewControllerAnimated(true, completion: nil)
        
        if  result.value == MessageComposeResultCancelled.value
        {
            Utility.showToastWithMessage("短信被取消", _view: self.view)
            
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

extension HWUpRegisterViewController:UITextFieldDelegate
{
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        if(!iPhone6 && !iPhone6plus)
        {
            if textField == captchaTF
            {
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    
                    self.upMessageView.bounds.origin.y = 100
                })
                
            }
            else
            {
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.upMessageView.bounds.origin.y = 0
                    
                })
            }

        
        }
        

    }
}
