//
//  HWBaseViewController.swift
//  Partner-Swift
//
//  Created by caijingpeng.haowu on 15/2/10.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：viewcontroller 基类 项目所有viewcontroller均集成此类
//
//  修改记录：
//      姓名         日期               修改内容
//     蔡景鹏      2015-02-11           创建文件
//

import UIKit

class HWBaseViewController: UIViewController,UINavigationControllerDelegate {
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        if (iOS7)
        {
            self.edgesForExtendedLayout = UIRectEdge.None
        }
        self.view.backgroundColor = CD_BackGroundColor
        self.navigationItem.hidesBackButton = true;
        
        let leftButton = UIButton()
        leftButton.frame = CGRectMake(0, 0, 30, 20);
        leftButton.addTarget(self, action: "backMethod", forControlEvents: .TouchUpInside)
        leftButton.setImage(UIImage(named: "arrow_return"), forState: .Normal)
        leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -16, 0, 0)
        let releaseButtonItem = UIBarButtonItem(customView: leftButton)
        self.navigationItem.leftBarButtonItem = releaseButtonItem;
    }
    
    func backMethod() -> Void
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}
