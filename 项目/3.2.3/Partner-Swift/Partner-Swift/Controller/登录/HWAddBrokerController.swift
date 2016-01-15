//
//  HWAddBrokerController.swift
//  Partner-Swift
//
//  Created by hw500028 on 15/3/2.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWAddBrokerController: HWBaseViewController {

    var model:HWBrokerModel?
    var ctrlType:ControllerType?
    var storeModel:HWShopAdminHeaderModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        var addBrokerView = HWAddBrokerView(frame:self.view.bounds)
        self.view.addSubview(addBrokerView)
        if ctrlType == ControllerType.addtional
        {
            self.navigationItem.titleView = Utility.navTitleView("增加经纪人")
            addBrokerView.storeModel = storeModel

        }
        if ctrlType == ControllerType.modify
        {
            self.navigationItem.titleView = Utility.navTitleView("修改经纪人")
            addBrokerView.model = model

        }
        addBrokerView.ctrlType = ctrlType
        addBrokerView.addBrokerSuccess = {
            let addd = ""
            self.navigationController!.popViewControllerAnimated(true)
        }
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
