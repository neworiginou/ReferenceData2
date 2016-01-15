//
//  HWPersonRegisterViewController.swift
//  Partner-Swift
//
//  Created by hw500028 on 15/2/26.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWPersonRegisterViewController: HWBaseViewController,UIActionSheetDelegate,HWPersonRegisterDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()

        var personregisterView = HWPersonRegisterView(frame: self.view.bounds)
        self.view.addSubview(personregisterView)
        personregisterView.delegate = self
        self.navigationItem.titleView = Utility.navTitleView("注册")
    }
 
 
    func hwPersonRegisterViewPushController(dic:NSDictionary)
    {
            let nextStepCtrl = HWPersonRegisterNextStepViewController()
             nextStepCtrl.dic = dic
            self.navigationController?.pushViewController(nextStepCtrl, animated: true)
    }
    
    func hwPersonRegisterViewUpmessageBtnClick() {
        let messageRegisterCtrl = HWUpRegisterViewController()
        self.navigationController?.pushViewController(messageRegisterCtrl, animated: true)
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
