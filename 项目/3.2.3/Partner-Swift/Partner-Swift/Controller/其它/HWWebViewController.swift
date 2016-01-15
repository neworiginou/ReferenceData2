//
//  HWWebViewController.swift
//  Partner-Swift
//
//  Created by hw500029 on 15/4/17.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit
class HWWebViewController: HWBaseViewController,UIWebViewDelegate{
 
    var paramDic:NSDictionary = NSDictionary()
    
    var secondId:NSString = "" //二手房id
    var clientId:NSString = ""//客户id
    var urlStr:NSString = ""//
    var type:NSString = "";//type代表来源
    var webView = UIWebView();
    var messageModel:HWMessageListModel = HWMessageListModel(messageInfo: NSDictionary());
    var _bridge:WebViewJavascriptBridge = WebViewJavascriptBridge();
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        webView = UIWebView(frame: CGRectMake(0, 20, kScreenWidth, contentHeight + 44))
        webView.delegate = self;
        webView.scrollView.scrollEnabled = false;
        self.view.addSubview(webView)
        //添加聊天断开刷新通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refershMessage", name: kRefershChatListNotification, object: nil);
        
        //add by gusheng
        WebViewJavascriptBridge.enableLogging();
        _bridge = WebViewJavascriptBridge(forWebView: webView, webViewDelegate: self, handler: { (object , responseBack) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil);
             NSNotificationCenter.defaultCenter().postNotificationName("refershMessageList", object: nil)
            self.navigationController?.popViewControllerAnimated(true);
        });
        
        _bridge.registerHandler("testObjcCallback", handler: { (object , responseBack) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil);
             NSNotificationCenter.defaultCenter().postNotificationName("refershMessageList", object: nil)
            self.navigationController?.popViewControllerAnimated(true);
        })
        
        _bridge.send("A string sent from ObjC before Webview has loaded.", responseCallback: { (responseData) -> Void in
            print(responseData);
        });
        //end
       self.loadRequest(self.urlStr);
      
        
    }
    func loadRequest(urlStr:NSString)->Void
    {
        var url = NSURL(string:urlStr)
         webView.loadRequest(NSURLRequest(URL: url!))
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillDisappear(animated);
        self.navigationController?.navigationBarHidden = true;
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated);
        self.navigationController?.navigationBarHidden = false;
        NSNotificationCenter.defaultCenter().removeObserver(self, name: kRefershChatListNotification, object: nil);
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func refershMessage()->Void
    {
        
         didSelectMessageList(messageModel);
//        if type == "消息"
//        {
//           didSelectMessageList(messageModel);
//        }
//        else if type == "二手房"
//        {
//            self.querySecondId()
//        }
//        else if type == "客户详情"
//        {
//            self.queryCustomer()
//        }
//        else if type == "抢客"
//        {
//            self.getRobCustomerMessageList()
//        }
//        else if type == "抢房"
//        {
//            self.getRobHouseMessageList()
//        }
    }
    

    
    //消息列表
    func didSelectMessageList(message: HWMessageListModel)
    {
        
            Utility.hideMBProgress(self.view);
             Utility.showMBProgress(self.view, _message:"正在获取");
            let manager = HWHttpRequestOperationManager.baseManager()
            var param: NSMutableDictionary = NSMutableDictionary()
            param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
            param .setObject(message.messageId, forKey: "messageId")
            param .setObject(message.source, forKey: "source")
            manager .postHttpRequest(kMessageDetail, parameters: param, queue: nil, success: { (responseObject) -> Void in
                Utility.hideMBProgress(self.view);
                let dict: NSDictionary = responseObject as NSDictionary
                var dataDic: NSDictionary = NSDictionary();
                var dataArr:NSArray = dict.arrayObjectForKey("data")
                dataDic = dataArr.objectAtIndex(0) as NSDictionary
                var urlStr = dataDic.stringObjectForKey("imUrl");
                self.loadRequest(urlStr);
                
                }, failure: { (error, code) -> Void in
                    Utility.hideMBProgress(self.view);
                    Utility .showToastWithMessage(error, _view: self.view)
                    self.navigationController?.popViewControllerAnimated(true);
                    

            })
        
    }

 func webView(webView: UIWebView, didFailLoadWithError error: NSError)
 {
    self.navigationController?.popViewControllerAnimated(true)
 }
// func webViewDidStartLoad(webView: UIWebView)
// {
//    Utility.showMBProgress(self.view, _message:"正在获取");
// }
// func webViewDidFinishLoad(webView: UIWebView)
// {
//    Utility.hideMBProgress(self.view);
// }
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
