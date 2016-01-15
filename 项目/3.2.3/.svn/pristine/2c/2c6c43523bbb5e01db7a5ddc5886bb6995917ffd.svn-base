//
//  HWCreateOrganizationNextStepViewController.swift
//  Partner-Swift
//
//  Created by hw500028 on 15/2/26.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWCreateOrganizationNextStepViewController: HWBaseViewController,HWCreateOrganizationNextStepViewDelegate {
    var cityId = ""
    var orgName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = Utility.navTitleView("创建机构")
        let createOrganizationNextStepView = HWCreateOrganizationNextStepView(frame: self.view.bounds)
        self.view.addSubview(createOrganizationNextStepView)
        createOrganizationNextStepView.delegate = self
        createOrganizationNextStepView.cityId = cityId
        createOrganizationNextStepView.orgName = orgName
        createOrganizationNextStepView.createSuccess = {
            let userDefault = NSUserDefaults.standardUserDefaults()
            userDefault.setObject("admin", forKey: kLastLoginRole)
            userDefault.synchronize()
            let createOrganizationSuccessCtrl = HWCreateOrganizationSuccessViewController()
            self.navigationController?.pushViewController(createOrganizationSuccessCtrl, animated: true)
        }
        
    }

    func hwCreateOrganizationNextStepViewUpMessageClick() {
        let upMessageCtrl = HWUpRegisterViewController()
        self.navigationController?.pushViewController(upMessageCtrl, animated: true)
        
    }
}
