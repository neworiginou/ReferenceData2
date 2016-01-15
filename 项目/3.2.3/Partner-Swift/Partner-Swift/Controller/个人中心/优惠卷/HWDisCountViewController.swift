//
//  HWMyDisCountViewController.swift
//  Partner-Swift
//
//  Created by hw500029 on 15/5/20.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWDisCountViewController: HWBaseViewController ,HWDiscountRefreshViewDelegate{

    var mainList:HWDiscountRefreshView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.navigationItem.titleView = Utility.navTitleView("优惠劵")
        
        mainList = HWDiscountRefreshView(frame: CGRectMake(0, 0, kScreenWidth, contentHeight))
        mainList.delegate = self
        self.view .addSubview(mainList)
        // Do any additional setup after loading the view.
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

    
    func didSelectdAtIndex(couponID: String,urlStr:String,brokerId:String) {
        let vc = HWDisCountDetailViewController()
        vc.couponId = couponID
        vc.webViewUrlStr = urlStr
        vc.brokerId = brokerId
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func backMethod() {
        self.navigationController?.popViewControllerAnimated(true)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "reloadList", object: nil)
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
