//
//  HWSubordinateDetailsViewController.swift
//  Partner-Swift
//
//  Created by hw500029 on 15/2/25.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit
import MessageUI

class HWSubordinateDetailsViewController: HWBaseViewController,HWCustomAlertViewDelegate,HWSubordinateDetailDelegate2,MFMessageComposeViewControllerDelegate,HWSubordinateDetailDelegate
{
    var refreshView:HWSubordinateDetailRefreshView?
    var refreshView2:HWSubordinateDetailRefreshView2?
    var bID:NSString?
    var topView:HWSubordinateRefreshTopView?
    var topViewPhoneNum:NSString = ""
    
    typealias nicNameChangeBlock = () ->Void
    var reloadListView = nicNameChangeBlock?()

    override func viewDidLoad() {
        super.viewDidLoad()
 
        self.navigationItem.titleView = Utility.navTitleView("下线详情")
        
        topView = HWSubordinateRefreshTopView(frame: CGRectMake(0, 0, kScreenWidth, 140 * kScreenRate))
        self.view.addSubview(topView!)
        //topView?.editBtn?.addTarget(self, action: "showNickNameEditView", forControlEvents: UIControlEvents.TouchUpInside)
        topView?.leftView?.userInteractionEnabled = true
        topView?.rightView?.userInteractionEnabled = true
        var tapGasL = UITapGestureRecognizer(target: self, action: "leftList")
        topView?.leftView?.addGestureRecognizer(tapGasL)
        var tapGasR = UITapGestureRecognizer(target: self, action: "rightList")
        topView?.rightView?.addGestureRecognizer(tapGasR)
        topView?.callBtn?.addTarget(self, action: "phoneCall:", forControlEvents: UIControlEvents.TouchUpInside)
        topView?.textMessageBtn?.addTarget(self, action: "send", forControlEvents: UIControlEvents.TouchUpInside)
        topView?.callBtn?.highlighted = false
        
        var tapGes = UITapGestureRecognizer(target: self, action: "showNickNameEditView")
        topView?.clearView?.addGestureRecognizer(tapGes)
        
        refreshView2 = HWSubordinateDetailRefreshView2(frame: CGRectMake(0, 130 * kScreenRate, kScreenWidth, contentHeight - 130 * kScreenRate))
        refreshView2?.brockerID = bID
        refreshView2?.queryListData()
        refreshView2?.delegate = self
        self.view.addSubview(refreshView2!)
        
        refreshView = HWSubordinateDetailRefreshView(frame: CGRectMake(0, 130 * kScreenRate, kScreenWidth, contentHeight - 130 * kScreenRate))
        refreshView?.brockerID = bID
        refreshView?.queryListData()
        refreshView?.delegate = self
        self.view.addSubview(refreshView!)
    }

    func send()
    {
        var MFCtrl = MFMessageComposeViewController()
        if MFMessageComposeViewController.canSendText() == true
        {
            MFCtrl.messageComposeDelegate = self
            MFCtrl.recipients = [topViewPhoneNum]
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
    
       
    func phoneCall(sender:UIButton)
    {
        if topViewPhoneNum.isEqualToString("") || topViewPhoneNum == Optional.None
        {
            Utility.showAlertWithMessage("电话号码无效")
        }
        else
        {
            var callWebView = UIWebView()
            self.view.addSubview(callWebView)
            var telUrl = NSURL(string: "tel:\(topViewPhoneNum)")
            callWebView.loadRequest(NSURLRequest(URL: telUrl!))
        }
    }
    
    func callAction(phoneNum:NSString)
    {
        println("打电话")
        
        var callWebView = UIWebView()
        self.view.addSubview(callWebView)
        var telUrl = NSURL(string: "tel:\(phoneNum)")
        callWebView.loadRequest(NSURLRequest(URL: telUrl!))
    }
    
    func leftList()
    {
        self.view.bringSubviewToFront(refreshView!)
    }
    
    func rightList()
    {
        self.view.bringSubviewToFront(refreshView2!)
    }
    
    //编辑下限昵称
    func showNickNameEditView()
    {
        let al = HWCustomAlertView(type: AlertViewType.EditNickName)
        shareAppDelegate.window?.addSubview(al)
        al.delegate = self
        al.showAnimate()
    }
    

    func didSelectedCustomer2(clientInfoId: NSString, clientType:NSString)
    {
        if clientType.isEqualToString("合作")
        {
            var vc = HWAgentCutomerVC()
            vc.clientInfoId = clientInfoId
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else
        {
            var vc = HWCustomerDetailViewController()
            vc.clientInfoId = clientInfoId
            self.navigationController?.pushViewController(vc, animated: true)
        }
    
    }
    func didSelectedCustomer(clientInfoId: NSString, clientType:NSString)
    {
        if clientType.isEqualToString("合作")
        {
            var vc = HWAgentCutomerVC()
            vc.clientInfoId = clientInfoId
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else
        {
            var vc = HWCustomerDetailViewController()
            vc.clientInfoId = clientInfoId
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    func fetchTopViewData(name: NSString, phoneNum: NSString, customerNum: NSString, achievement: NSString,imgUrl:NSString) {
        topView?.fethTopdicData(name, phoneNum: phoneNum, customerNum: customerNum, achievement: achievement,imgUrl:imgUrl)
        topViewPhoneNum = phoneNum
    }
    
    func ConfirmInPut(content: NSString) {
        println("发送编辑下线姓名请求")
        topView?.nameLabel?.text = content
        
        var parma = NSMutableDictionary()
        parma.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        parma.setPObject(content, forKey: "nameComment")
        parma.setPObject(bID, forKey: "brokerId")
        var manager = HWHttpRequestOperationManager.baseManager()
        manager.postHttpRequest(kSubordinateChangeNickName, parameters: parma, queue: nil, success:
            { (responseObject) -> Void in
//                println("responseObject ============== \(responseObject)")
                
                var responseDic = responseObject as NSDictionary
                
                self.topView?.nameLabel?.text = responseDic.stringObjectForKey("data")
                //self.topView?.nameLabel?.text = content
                //self.topView?.nameLabel?.text = "今天明天后天今年明年"
                self.reloadListView!()
            }) { (failure, error) -> Void in
                
        }
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





