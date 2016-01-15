//
//  HWinfomationViewController.swift
//  Partner-Swift
//
//  Created by gusheng on 15/3/4.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWinfomationViewController:HWBaseViewController
{
    var newUrl:NSString!;
    var webUrlWebV:UIWebView = UIWebView(frame: CGRectMake(0, 0, kScreenWidth, contentHeight));
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationItem.titleView = Utility.navTitleView("资讯");
        self.view.addSubview(webUrlWebV);
        self.refershUI(newUrl);
    }
    func refershUI(var url:NSString)->Void
    {
        var contentUrl:NSURL = NSURL(string: url)!;
        var request:NSURLRequest = NSURLRequest(URL:contentUrl);
        webUrlWebV.loadRequest(request);
    }
  override func backMethod() {
        NSNotificationCenter .defaultCenter() .postNotificationName(kRefershHomePageNotification, object: nil)
        self.navigationController?.popViewControllerAnimated(true)
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    
    }
}
