//
//  HWMessageListViewController.swift
//  Partner-Swift
//
//  Created by caijingpeng.haowu on 15/3/4.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//


import UIKit

class HWMessageListViewController: HWBaseViewController, HWMessageListRefreshViewDelegate {
     var dataDic = NSDictionary()
    
    var urlStr = ""//根据消息类型决定列表的数据分类
    var titleStr = ""//分类消息列表标题
    
    override func viewDidLoad()
    {
        super.viewDidLoad() 

        self.navigationItem.titleView = Utility.navTitleView(titleStr)
        
        //MYP add v3.2.3 修改msgRefreshView初始化方法
        //let messageListView = HWMessageListRefreshView(frame: CGRectMake(0, 0, kScreenWidth, contentHeight))
        let messageListView = HWMessageListRefreshView(frame: CGRectMake(0, 0, kScreenWidth, contentHeight), urlString:urlStr)
        messageListView.delegate = self
        self.view.addSubview(messageListView)
        
        //MYP add v3.2.3 进入详情列表消除消息分类列表系统消息一栏红点
        if titleStr == "系统消息"
        {
            NSNotificationCenter.defaultCenter().postNotificationName("reloadMsgListView", object: nil)
        }
        
        // Do any additional setup after loading the view.
        HWLocationManager.shareManager().startLoacting();
    }
    override func backMethod()
    {
        NSNotificationCenter.defaultCenter().postNotificationName(kRefershHomePageNotification, object: nil);
        self.navigationController?.popViewControllerAnimated(true)
    }
    func didSelectMessageList(message: HWMessageListModel)
    {
        if (message.msgType.isEqualToString("hi"))
        {
            let hiVC = HWHiDialogViewController()
            hiVC.msgListModel = message
            self.navigationController?.pushViewController(hiVC, animated: true)
        }
            
     else  if (message.msgType.isEqualToString("rental"))
        { 
            
            Utility.showMBProgress(self.view, _message: "加载中")
            let manager = HWHttpRequestOperationManager.baseManager()
            var param: NSMutableDictionary = NSMutableDictionary()
            param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
            param .setObject(message.messageId, forKey: "messageId")
            param .setObject(message.source, forKey: "source")
            manager .postHttpRequest(kMessageDetail, parameters: param, queue: nil, success: { (responseObject) -> Void in
                Utility .hideMBProgress(self.view);
                Utility .showToastWithMessage("请求成功", _view: self.view)
                let dict: NSDictionary = responseObject as NSDictionary
                var dataArr:NSArray = dict.arrayObjectForKey("data")
                self.dataDic = dataArr.objectAtIndex(0) as NSDictionary
                var webVC = HWWebViewController()
                 webVC.type = "消息"
                webVC.messageModel = message;
                webVC.urlStr = self.dataDic.stringObjectForKey("imUrl")
                if self.dataDic.stringObjectForKey("imUrl").length == 0
                {
                    Utility .showToastWithMessage("不可跳转", _view: self.view)
                    return
                }
                else
                {
                    self.navigationController?.pushViewController(webVC, animated: false);
                    
                }

               // self.navigationController?.pushViewController(webVC, animated: false);
                
            }, failure: { (error, code) -> Void in
                Utility .hideMBProgress(self.view);
                if (error.integerValue == kStatusFailure )
                {
                   Utility .showToastWithMessage("网络未连接", _view: self.view)
                }
                 else
                {
                    Utility .showToastWithMessage(error, _view: self.view)

                }
            })

        }

        else
        {
            if message.source == "coupon"
            {
                Utility.showMBProgress(self.view, _message: "加载中")
                let manager = HWHttpRequestOperationManager.baseManager()
                var param: NSMutableDictionary = NSMutableDictionary()
                param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
                param .setObject(message.messageId, forKey: "messageId")
                param .setObject(message.source, forKey: "source")
                manager .postHttpRequest(kMessageDetail, parameters: param, queue: nil, success: { (responseObject) -> Void in
                    Utility .hideMBProgress(self.view);
                    //Utility .showToastWithMessage("请求成功", _view: self.view)
                    let dict: NSDictionary = responseObject as NSDictionary
                    var dataArr:NSArray = dict.arrayObjectForKey("data")
                    self.dataDic = dataArr.objectAtIndex(0) as NSDictionary
                    
                    if self.dataDic.stringObjectForKey("couponDetailUrl").length == 0
                    {
                        Utility .showToastWithMessage("不可跳转", _view: self.view)
                        return
                    }
                    else
                    {
                        //跳转优惠券详情 MYP add v3.2
                        let vc = HWDisCountDetailViewController()
                        vc.couponId = message.messageId
                        vc.webViewUrlStr = message.webUrl
                        vc.brokerId = message.brokerId
                        vc.fromVCName = "消息列表"
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                    
                    
                    }, failure: { (error, code) -> Void in
                        Utility .hideMBProgress(self.view);
                        if (error.integerValue == kStatusFailure )
                        {
                            Utility .showToastWithMessage("网络未连接", _view: self.view)
                        }
                        else
                        {
                            Utility .showToastWithMessage(error, _view: self.view)
                            
                        }
                })

                
             }
            else
            {
                let dialogVC = HWMessageDialogViewController()
                dialogVC.msgListModel = message
                self.navigationController?.pushViewController(dialogVC, animated: true)
                
                //MYP add v3.2.3 系统消息（福利日消息）需加载h5详情页面
                
            }
        }
        //MYP add v3.2.3 通知主消息分类列表更新红点状态
        NSNotificationCenter.defaultCenter().postNotificationName("reloadMsgListView", object: nil)
    }
    override func didReceiveMemoryWarning()
    {
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
