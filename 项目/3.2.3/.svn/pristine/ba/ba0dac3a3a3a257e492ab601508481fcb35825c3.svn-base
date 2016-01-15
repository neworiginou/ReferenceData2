//
//  HWNewParametersVC.swift
//  Partner-Swift
//
//  Created by zhangxun on 15/3/2.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWNewParametersVC: HWBaseViewController {
    
    var houseURL : NSString!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.titleView = Utility.navTitleView("楼盘参数")
        self.navigationItem.leftBarButtonItem = Utility.navLeftBackBtn(self, _selector: "backMethod")
        var webV : UIWebView = UIWebView(frame: CGRectMake(0, 0, kScreenWidth, contentHeight))
        webV.loadRequest(NSURLRequest(URL: NSURL(string: houseURL as String)!))
        self.view.addSubview(webV)
    }
        
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
