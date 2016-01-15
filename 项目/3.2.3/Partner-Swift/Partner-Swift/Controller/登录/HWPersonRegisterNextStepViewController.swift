//
//  HWPersonRegisterNextStepViewController.swift
//  Partner-Swift
//
//  Created by hw500028 on 15/2/26.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWPersonRegisterNextStepViewController: HWBaseViewController,HWPersonRegisterNextStepViewDelegate {
    var dic = NSDictionary()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = Utility.navTitleView("注册")
        let nextStepView = HWPersonRegisterNextStepView(frame: self.view.bounds)
        self.view.addSubview(nextStepView)
        nextStepView.delegate  = self 
        nextStepView.dicInfo = dic
    }
 
    func hwPersonRegisterNextStepViewSureBtnClick(view: UIView) {
        let userDefault = NSUserDefaults.standardUserDefaults()
        userDefault.setObject("broker", forKey: kLastLoginRole)
        userDefault.synchronize()
        
        APService.setTags(NSSet(object: HWUserLogin.currentUserLogin().cityName), alias: HWUserLogin.currentUserLogin().brokerTel, callbackSelector: nil, object: nil)
        
        let tabbar = HWTabbarViewController()
        var tabbarNav = HWBaseNavigationController(rootViewController: tabbar)
        Utility.transController(currentNav, newCtrl: tabbarNav)
    }
}
