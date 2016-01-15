//
//  HWactivityVC.swift
//  Partner-Swift
//
//  Created by zhangxun on 15/3/24.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWactivityVC: UIViewController {

    var actUrl : NSString!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationItem.titleView = Utility.navTitleView("活动详情")
        self.navigationItem.leftBarButtonItem = Utility.navLeftBackBtn(self, _selector: "doBack")
        var webView : UIWebView = UIWebView(frame: CGRectMake(0, 0, kScreenWidth, contentHeight))
        webView.loadRequest(NSURLRequest(URL: NSURL(string: actUrl as String)!))
        self.view.addSubview(webView)
        // Do any additional setup after loading the view.
    }
    
    func doBack()
    {
        self.navigationController?.popViewControllerAnimated(true)
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
