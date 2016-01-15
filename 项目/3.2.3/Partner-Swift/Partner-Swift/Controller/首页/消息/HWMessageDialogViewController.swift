//
//  HWMessageDialogViewController.swift
//  Partner-Swift
//
//  Created by caijingpeng.haowu on 15/3/4.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWMessageDialogViewController: HWBaseViewController, UITextFieldDelegate {

    var sendTF: UITextField!
    var dialogView: HWMessageDialogView!
    var msgListModel: HWMessageListModel?
    dynamic var sendView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.titleView = Utility.navTitleView("消息")
        
        dialogView = HWMessageDialogView(frame: CGRectMake(0, 0, kScreenWidth, contentHeight - 50))
        dialogView.msgListModel = msgListModel
        self.view.addSubview(dialogView)
        
        // Do any additional setup after loading the view.
        self.initialSendView()
    }
    
    func initialSendView() -> Void
    {
        sendView = UIView(frame: CGRectMake(0, contentHeight - 50, kScreenWidth, 50))
        sendView.backgroundColor = UIColor.whiteColor()
        if(msgListModel?.msgType == "system")
        {
            
        }
        else
        {
            sendView.drawTopLine()
        }
        
        self.view.addSubview(sendView)
        
        sendTF = UITextField(frame: CGRectMake(15, 10, kScreenWidth - 15 - 50 - 10 - 15, 30))
        sendTF.layer.cornerRadius = 3.0
        sendTF.layer.masksToBounds = true
        sendTF.backgroundColor = CD_GrayColor
        sendTF.leftViewMode = UITextFieldViewMode.Always
        sendTF.leftView = UIView(frame: CGRectMake(0, 0, 5, 15))
        sendTF.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
        sendTF.font = Define.font(TF_13)
        sendTF.delegate = self
        sendView.addSubview(sendTF)
        
        let button: UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        button.setBackgroundImage(Utility.imageWithColor(CD_MainColor, _size: CGSizeMake(50, 30)), forState: UIControlState.Normal)
        button.layer.cornerRadius = 3
        button.layer.masksToBounds = true
        button.setTitle("发送", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        button.titleLabel?.font = Define.font(TF_13)
        button.frame = CGRectMake(kScreenWidth - 50 - 15, 10, 50, 30)
        button.addTarget(self, action: "toSendMessage:", forControlEvents: UIControlEvents.TouchUpInside)
        sendView.addSubview(button)
        
        if(msgListModel?.msgType == "system")
        {
            button.hidden = true;
            sendTF.hidden = true;
            dialogView = HWMessageDialogView(frame: CGRectMake(0, 0, kScreenWidth, contentHeight))
        }
        
        let keyboardHelper = HWKeyBoardHelper.shareInstance()
        keyboardHelper.addObserver(sendView, keyBoardOffsetY: -1)

        sendView.addObserver(self, forKeyPath: "center", options: NSKeyValueObservingOptions.New, context: nil)
    }
    
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        
//        println("kvo: \(keyPath) \n \(object) \n \(change)")
        
        if (keyPath == "center")
        {
            let originY: CGFloat = CGRectGetMinY(sendView.frame)
            dialogView.frame = CGRectMake(0, 0, kScreenWidth, originY)
            dialogView.baseTable.frame = dialogView.bounds
        }
    }
    
    
    func toSendMessage(sender: UIButton) -> Void
    {
        if countElements(sendTF.text) <= 0
        {
            Utility.showToastWithMessage("请输入内容", _view: self.view)
            return
        }
        
        sendTF.resignFirstResponder()
        
        Utility.showMBProgress(self.view, _message: "发送中")
        
        let manager = HWHttpRequestOperationManager.baseManager()
        var param: NSMutableDictionary = NSMutableDictionary()
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param.setPObject(sendTF.text, forKey: "message")
        param.setPObject(msgListModel?.messageId, forKey: "messageId")
        param.setPObject(msgListModel?.source, forKey: "source")
        //        param.setPObject(msgListModel.brokerId, forKey: "brokerId")
        manager.postHttpRequest(kMessageReply, parameters: param, queue: nil, success: { (responseObject) -> Void in
//            println(responseObject)
            Utility.hideMBProgress(self.view)
            self.dialogView.currentPage = 1;
            self.dialogView.queryListData()
            self.sendTF.text = ""
            }) { (code, error) -> Void in
                
                Utility.hideMBProgress(self.view)
                Utility.showToastWithMessage(error, _view: self.view)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
