


//
//  HWDisCountDetailViewController.swift
//  Partner-Swift
//
//  Created by hw500029 on 15/5/25.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWDisCountDetailViewController: HWBaseViewController ,UIWebViewDelegate{

    var couponId:String = ""
    var webView:UIWebView = UIWebView()
    var robBtn:UIButton!
    var webViewUrlStr:String = ""
    var brokerId:String = ""
    
    var couponMoney:String = ""
    var couponStatus:String = ""
    var robSuccessModel:HWDisCountShareModel!
    var onlyShowDetail:Bool = false
    
    var fromVCName:String = ""
    
    var v:HWDiscountCouponAlertView!
    var shareModel:HWShareViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
        //self.loadUI()
        
        
//        var v:HWDiscountCouponAlertView = HWDiscountCouponAlertView(frame: CGRectMake(0, 0, kScreenWidth, contentHeight + 64), model: NSDictionary(), isRobSuccess: true)
//        shareAppDelegate.window?.addSubview(v)
        
        
        // Do any additional setup after loading the view.
        self.requestData()
    }

    
    func requestData()
    {
        var parma = NSMutableDictionary()
        parma.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        parma.setPObject(couponId, forKey: "id")
        parma.setPObject(HWUserLogin.currentUserLogin().brokerId, forKey: "brokerId")
        var manager = HWHttpRequestOperationManager.baseManager()
        manager.postHttpRequest(kCouponDetail, parameters: parma, queue: nil, success:
            { (responseObject) -> Void in
                println("responseObject =============== \(responseObject)")
                let dataDic = responseObject.dictionaryObjectForKey("data") as NSDictionary
                self.couponMoney = dataDic.stringObjectForKey("couponMoney")
                self.couponStatus = dataDic.stringObjectForKey("couponStatus")
                if self.couponMoney == ""
                {
                    self.backMethod()
                }
                self.navigationItem.titleView = Utility.navTitleView(dataDic.stringObjectForKey("couponTitle"))
                self.loadUI()
                
                
            }) { (failure, error) -> Void in
                //println("请求失败")
                Utility.showToastWithMessage("加载失败", _view:shareAppDelegate.window!)
                self.backMethod()
        }

    }
    
    func loadUI()
    {
        
        webView = UIWebView(frame: CGRectMake(0, 0, kScreenWidth, contentHeight - (onlyShowDetail == true ? 0:50)))
        webView.delegate = self;
        webView.scrollView.scrollEnabled = true;
        self.view.addSubview(webView)
        var url = NSURL(string:webViewUrlStr)
        webView.loadRequest(NSURLRequest(URL: url!))
        
        if onlyShowDetail == true
        {
            return
        }
        
        robBtn = UIButton(frame: CGRectMake(0, self.view.frame.size.height - 50, kScreenWidth, 50))
        if couponStatus == "0"
        {
            self.robBtn.backgroundColor = CD_Btn_GrayColor
            self.robBtn.setTitle("机会已用完", forState: UIControlState.Normal)
        }
        else if couponStatus == "1"
        {
            robBtn.backgroundColor = CD_MainColor
            robBtn.addTarget(self, action: "robAction", forControlEvents: UIControlEvents.TouchUpInside)
            robBtn.setTitle("抢 ￥" + couponMoney, forState: UIControlState.Normal)
        }
        else if couponStatus == "2"
        {
            self.robBtn.backgroundColor = CD_Btn_GrayColor
            self.robBtn.setTitle("已过期", forState: UIControlState.Normal)
        }
        else
        {
            self.robBtn.backgroundColor = CD_Btn_GrayColor
            self.robBtn.setTitle("已抢完 ￥" + self.couponMoney, forState: UIControlState.Normal)
        }
        
        
        //robBtn.backgroundColor = CD_MainColor
        //robBtn.addTarget(self, action: "robAction", forControlEvents: UIControlEvents.TouchUpInside)
        //robBtn.setTitle("抢 ￥" + couponMoney, forState: UIControlState.Normal)
        robBtn.titleLabel?.textColor = UIColor.whiteColor()
        self.view.addSubview(robBtn)

    }
    
    func robAction()
    {
        robBtn.userInteractionEnabled = false
        var parma = NSMutableDictionary()
        parma.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        parma.setPObject(couponId, forKey: "couponId")
        var manager = HWHttpRequestOperationManager.baseManager()
        manager.postHttpRequest(kRobCoupon, parameters: parma, queue: nil, success:
            { (responseObject) -> Void in
                println("responseObject =============== \(responseObject)")
                let dataDic = responseObject.dictionaryObjectForKey("data") as NSDictionary
                self.robSuccessModel = HWDisCountShareModel()
                self.robSuccessModel.fetchData(dataDic)
                
                var isSuccess = false
//                if(self.robSuccessModel.isRobed == "0" && self.robSuccessModel.isLimit == "0")
//                {
//                    isSuccess = true
//                }
//                else
//                {
//                    isSuccess = false
//                }
                
//                if (self.robSuccessModel.isRobed == "1")
//                {
//                    isSuccess = true
//                }
//                else
//                {
//                    isSuccess = false
//                }
//                
//                self.v = HWDiscountCouponAlertView(frame: CGRectMake(0, 0, kScreenWidth, contentHeight + 64), model: self.robSuccessModel, isRobSuccess: isSuccess)
//                shareAppDelegate.window?.addSubview(self.v)
//                self.v.hideBtn.addTarget(self, action: "hideAction", forControlEvents: UIControlEvents.TouchUpInside)
                
//                if isSuccess == true
//                {
//                    self.v.bottomBtn.addTarget(self, action: "shareAction", forControlEvents: UIControlEvents.TouchUpInside)
//                    var tapGas:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "gotoMyCouponList")
//                    self.v.bottomLabel.addGestureRecognizer(tapGas)
//                }
//                else
//                {
//                    //机会已用完
//                    if (self.robSuccessModel.isLimit == "1")
//                    {
//                        self.robBtn.backgroundColor = CD_Btn_GrayColor
//                        self.robBtn.setTitle("机会已用完", forState: UIControlState.Normal)
//                        self.robBtn.removeTarget(self, action: "shareAction", forControlEvents: UIControlEvents.TouchUpInside)
//                    }
//
//                    //已抢完
//                    if (self.robSuccessModel.isRobed == "1")
//                    {
//                        self.robBtn.backgroundColor = CD_Btn_GrayColor
//                        self.robBtn.setTitle("已抢完 ￥" + self.couponMoney, forState: UIControlState.Normal)
//                        self.robBtn.removeTarget(self, action: "shareAction", forControlEvents: UIControlEvents.TouchUpInside)
//                    }
//                    
//                }
                
                
                
                if (self.robSuccessModel.isRobed == "1")
                {
                    isSuccess = true
                    NSNotificationCenter.defaultCenter().postNotificationName("reloadList", object: nil)
                    NSNotificationCenter.defaultCenter().postNotificationName("reloadPersonalCenterData", object: nil)
                }
                else
                {
                    isSuccess = false
                }
                
                
                self.v = HWDiscountCouponAlertView(frame: CGRectMake(0, 0, kScreenWidth, contentHeight + 64), model: self.robSuccessModel, isRobSuccess: isSuccess)
                shareAppDelegate.window?.addSubview(self.v)
                self.v.hideBtn.addTarget(self, action: "hideAction", forControlEvents: UIControlEvents.TouchUpInside)
                
                if isSuccess == true
                {
                    self.v.bottomBtn.addTarget(self, action: "shareAction", forControlEvents: UIControlEvents.TouchUpInside)
                    var tapGas:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "gotoMyCouponList")
                    self.v.bottomLabel.addGestureRecognizer(tapGas)
                }
                else
                {
                    
                }
                
                
                if self.robSuccessModel.isRobed == "0"
                {
                    self.robBtn.backgroundColor = CD_Btn_GrayColor
                    self.robBtn.setTitle("机会已用完", forState: UIControlState.Normal)
                    self.robBtn.removeTarget(self, action: "shareAction", forControlEvents: UIControlEvents.TouchUpInside)
                }
                else if self.robSuccessModel.isRobed == "1"
                {
                    self.robBtn.backgroundColor = CD_MainColor
                    self.robBtn.setTitle("抢 ￥" + self.couponMoney, forState: UIControlState.Normal)
                }
                else if self.robSuccessModel.isRobed == "2"
                {
                    self.robBtn.backgroundColor = CD_Btn_GrayColor
                    self.robBtn.setTitle("已过期", forState: UIControlState.Normal)
                    self.robBtn.removeTarget(self, action: "shareAction", forControlEvents: UIControlEvents.TouchUpInside)
                }
                else
                {
                    self.robBtn.backgroundColor = CD_Btn_GrayColor
                    self.robBtn.setTitle("已抢完 ￥" + self.couponMoney, forState: UIControlState.Normal)
                    self.robBtn.removeTarget(self, action: "shareAction", forControlEvents: UIControlEvents.TouchUpInside)
                }

            
                self.robBtn.userInteractionEnabled = true
            }) { (failure, error) -> Void in
                //println("请求失败")
                self.robBtn.userInteractionEnabled = true
        }

    }
    
    func gotoMyCouponList()
    {
        v.hide()
        let myCouponVC = HWMyDisCountViewController()
        self.navigationController?.pushViewController(myCouponVC, animated: true)
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError)
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func hideAction()
    {
        v.hide()
    }
    
    func shareAction()
    {
        var imgView = UIImageView()
        imgView.setImageWithURL(NSURL(string:robSuccessModel.picUrl), placeholderImage: UIImage(named: "shareIcon")!)
        shareModel = HWShareViewModel(shareContent: robSuccessModel.content, image: imgView.image, shareUrl: robSuccessModel.couponShareUrl)
        shareModel.showInView(shareAppDelegate.window, presentController: self)
        shareModel.shareSuccess = {type in
        
        self.shareSuccessRequest(type)
        }
    }
    
    func shareSuccessRequest(shareType:String)
    {
        v.hide()
        
        var parma = NSMutableDictionary()
        parma.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        var type:String = ""
        if shareType == "1"
        {
            type = "WeChat"
        }
        else if shareType == "6"
        {
            type = "CircleOfFriends"
        }
        else if shareType == "7"
        {
            type = "note"
        }
        parma.setPObject(type, forKey: "shareChannel")
        parma.setPObject(robSuccessModel.couponNum, forKey: "couponNum")
        var manager = HWHttpRequestOperationManager.baseManager()
        manager.postHttpRequest(kCouponShareSuccess, parameters: parma, queue: nil, success: { (responsObject) -> Void in
            println("responsObject ================= \(responsObject)")
            }) { (error, code) -> Void in
            println("error ================= \(error)")
        }
        
        
        var vc = HWMyDisCountViewController()
        vc.fromVC = fromVCName
        self.navigationController?.pushViewController(vc, animated: true)
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
