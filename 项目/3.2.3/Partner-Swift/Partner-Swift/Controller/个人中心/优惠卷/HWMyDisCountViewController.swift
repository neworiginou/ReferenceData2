//
//  HWMyDisCountViewController.swift
//  Partner-Swift
//
//  Created by hw500029 on 15/5/22.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWMyDisCountViewController: HWBaseViewController ,HWMyDisCountRefreshViewDelegate{

    var shareCouponNum:String = ""
    var shareModel:HWShareViewModel!
    var mainList:HWMyDisCountRefreshView!
    var fromVC:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationItem.titleView = Utility.navTitleView("我的优惠劵")
        
        var robBtn:UIButton = UIButton(frame: CGRectMake(0, 0, 54, 30))
        robBtn.backgroundColor = CD_MainColor
        robBtn.setTitle("抢", forState:UIControlState.Normal)
        robBtn.titleLabel?.font = Define.font(TF_15)
        robBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        robBtn.addTarget(self, action: "gotoDisCountListVC", forControlEvents: UIControlEvents.TouchUpInside)
        robBtn.layer.cornerRadius = 3
        robBtn.layer.masksToBounds = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: robBtn)
        
        mainList = HWMyDisCountRefreshView(frame: CGRectMake(0, 0, kScreenWidth, contentHeight))
        mainList.delegate = self
        self.view .addSubview(mainList)

        
    }
    
    func reloadCouponList()
    {
        mainList.currentPage = 1
        mainList.queryListData()
    }
    
    override func viewWillAppear(animated: Bool) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reloadCouponList", name: "reloadList", object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        //NSNotificationCenter.defaultCenter().removeObserver(self, name: "reloadList", object: nil)
    }
    
    
    func shareCouponByIndex(model:HWMyDisCountModel) {
         //println("分享优惠卷\(index)")
        /*
        var shareModel : HWShareViewModel = HWShareViewModel(shareContent: "发现一个不错的楼盘 " + newModel.houseName! + " " + newModel.houseAddress!, image: image, shareUrl: newModel.shareUrl)
        shareModel.projectId = newModel.houseId
        shareModel.showInView(shareAppDelegate.window, presentController: self.houseVC)
        */
        
        var imgView = UIImageView()
        imgView.setImageWithURL(NSURL(string:model.picKey), placeholderImage: UIImage(named: "shareIcon")!)
        //shareModel = HWShareViewModel(shareContent: model.content, image: UIImage(named: "shareIcon")!, shareUrl: model.couponShareUrl)
        shareModel = HWShareViewModel(shareContent: model.content, image: imgView.image, shareUrl: model.couponShareUrl)
        shareModel.shareSuccess = {type in
            self.shareSuccessRequest(type)
        }
        shareCouponNum = model.couponNum
        shareModel.showInView(shareAppDelegate.window, presentController: self)
    }
    
    func shareSuccessRequest(shareType:String)
    {
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
        parma.setPObject(shareCouponNum, forKey: "couponNum")
        var manager = HWHttpRequestOperationManager.baseManager()
        manager.postHttpRequest(kCouponShareSuccess, parameters: parma, queue: nil, success: { (responsObject) -> Void in
            println("responsObject ================= \(responsObject)")
        }) { (error, code) -> Void in
            println("error ================= \(error)")

        }
    }
    
    func gotoDisCountListVC()
    {
        var vc:HWDisCountViewController = HWDisCountViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func backMethod() {
        if fromVC == "个人中心"
        {
            self.navigationController?.popViewControllerAnimated(true)
        }
        else if fromVC == "消息列表"
        {
            if shareAppDelegate.messageListVC == nil
            {
                self.navigationController?.popToRootViewControllerAnimated(true)
            }
            else
            {
                self.navigationController?.popToViewController(shareAppDelegate.messageListVC, animated: true)
            }
        }
        else
        {
            self.navigationController?.popToRootViewControllerAnimated(true)
        }
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "reloadList", object: nil)
    }
   
    func pushDetailViewByModel(model: HWMyDisCountModel) {
        let vc = HWDisCountDetailViewController()
        vc.webViewUrlStr = model.couponDetailUrl
        vc.couponId = model.disCountID
        vc.onlyShowDetail = true
        println("couponDetailUrl ======================== \(vc.webViewUrlStr)")
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
