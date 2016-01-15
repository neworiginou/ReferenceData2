//
//  HWOrganizationAuditedViewController.swift
//  Partner-Swift
//
//  Created by hw500028 on 15/2/28.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWOrganizationViewController: HWBaseViewController,HWOrganizationViewDelegate,UIAlertViewDelegate{
    var ctrlType:ControllerType?
    override func viewDidLoad() {
        super.viewDidLoad()
        if ctrlType == ControllerType.addShop
        {
            let addshop = HWAddShopController()
            self.navigationController?.pushViewController(addshop, animated: true)
            ctrlType = ControllerType.typeNone
        }
        self.navigationItem.titleView = Utility.navTitleView("首页")
        var organizationView = HWOrganizationView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: contentHeight))
        self.view.addSubview(organizationView)
        organizationView.delegate = self
        organizationView.myfunc = {
            (model:HWBrokerModel) in
            let addbrokerCtrl = HWAddBrokerController()
            self.navigationController?.pushViewController(addbrokerCtrl, animated: true)
            addbrokerCtrl.model = model
            addbrokerCtrl.ctrlType = ControllerType.modify
        }
    }

    func addshopBtnClick() {
        let addshopCtrl = HWAddShopController()
        self.navigationController?.pushViewController(addshopCtrl, animated: true)
        
    }

    func addBrokerClik(model: HWShopAdminHeaderModel) {
        let addbrokerCtrl = HWAddBrokerController()
        addbrokerCtrl.ctrlType = ControllerType.addtional
        addbrokerCtrl.storeModel = model
        self.navigationController?.pushViewController(addbrokerCtrl, animated: true)
    }
    override func backMethod() {
        let alert = UIAlertView(title: "", message: "是否需要退出登录", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "确定")
        alert.show()
    }
    
    // MARK:---alertViewDelegate
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 1
        {
            Utility.showMBProgress(view, _message: "退出中")
            var manager = HWHttpRequestOperationManager.baseManager()
            manager.postHttpRequest(kLoginOut, parameters: nil, queue: nil, success: { (responseObject) -> Void in
                Utility.hideMBProgress(self.view)
                HWUserLogin.currentUserLogin().logout()
                self.navigationController?.popToViewController(shareAppDelegate.loginCtrl!, animated: true)
                }, failure: { (code, error) -> Void in
                    Utility.hideMBProgress(self.view)
                    Utility.showToastWithMessage(error, _view: self.view)
            })

            
        }
    }
    
}
