//
//  HWProductIntroductionViewController.swift
//  Partner-Swift
//
//  Created by hw500027 on 15/2/27.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：服务首页-产品说明
//
//  修改记录：
//      姓名         日期              修改内容
//    陆晓波      2015-02-27           文件创建
//

import UIKit

class HWProductIntroductionViewController: HWBaseViewController,UIWebViewDelegate {

    var _urlStr:NSString!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationItem.titleView = Utility.navTitleView("产品说明")
        self.view.backgroundColor = CD_GrayColor
        var webView = UIWebView(frame: CGRectMake(0, -5, kScreenWidth, contentHeight + 5))
        webView.delegate = self
        webView.opaque = false
        webView.backgroundColor = CD_GrayColor
        webView.loadRequest(NSURLRequest(URL: NSURL(string: _urlStr)!))
        self.view.addSubview(webView)

        // Do any additional setup after loading the view.
    }

    //MARK:--webView代理
//    func webViewDidFinishLoad(webView: UIWebView)
//    {
//        webView.stringByEvaluatingJavaScriptFromString("document.getElementsByTagName('body')[0].style.background='#f5f5f5'")
//    }
    
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
