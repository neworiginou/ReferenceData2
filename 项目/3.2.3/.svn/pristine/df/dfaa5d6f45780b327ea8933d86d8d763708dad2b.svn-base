//
//  HWAgreementController.swift
//  Partner-Swift
//
//  Created by hw500028 on 15/3/24.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWAgreementController: HWBaseViewController {
    var agreement:(() -> ())?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = Utility.navTitleView("协议详情")
        self.view.backgroundColor = CD_BackGroundColor
        
        let webView = UIWebView(frame: CGRect(x: 0, y: -64, width: kScreenWidth, height: contentHeight + 20))
        webView.backgroundColor = CD_BackGroundColor
        view.addSubview(webView)
        let url:NSURL = NSBundle.mainBundle().URLForResource("协议.html", withExtension: nil)!
        let request:NSURLRequest = NSURLRequest(URL: url)
        webView.loadRequest(request)
        let agreeBtn:UIButton = UIButton.newAutoLayoutView()
        view.addSubview(agreeBtn)
        agreeBtn.autoPinEdgeToSuperviewEdge(ALEdge.Bottom, withInset: 0)
        agreeBtn.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
        agreeBtn.autoSetDimensionsToSize(CGSize(width: kScreenWidth, height: 44))
        agreeBtn.addTarget(self, action: "agreeBtnAction", forControlEvents: UIControlEvents.TouchUpInside)
        agreeBtn.setBackgroundImage(Utility.imageWithColor(CD_Btn_MainColor, _size: CGSize(width: kScreenWidth, height: 44)), forState: UIControlState.Normal)
        agreeBtn.setTitle("已阅读并同意", forState: UIControlState.Normal)
        agreeBtn.titleLabel?.font = Define.font(TF_15)
    }

    func agreeBtnAction()
    {
        self.navigationController?.popViewControllerAnimated(true)
        agreement?()
    }

}
