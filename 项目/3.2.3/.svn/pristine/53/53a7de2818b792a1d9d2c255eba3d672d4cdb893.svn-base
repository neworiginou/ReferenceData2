//
//  HWNewHouseViewController.swift
//  Partner-Swift
//
//  Created by caijingpeng.haowu on 15/2/11.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import Foundation

class HWNewHouseViewController: HWBaseViewController,HWNewViewDelegate {
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
//        self.view.backgroundColor = UIColor.greenColor()
        
        self.tabBarController?.navigationItem.titleView = Utility.navTitleView("新房")
     
        var newView : HWNewView = HWNewView(frame: CGRectMake(0, 0, kScreenWidth, contentHeight - 49))
        newView.delegate = self
        newView.houseVC = self
        self.view.addSubview(newView)
    }
    
    func push(viewController: UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    //MARK: 更改navigationItem
    override func viewDidAppear(animated: Bool)
    {
        self.tabBarController?.navigationItem.titleView = Utility.navTitleView("新房")
    }
    
    //MARK: 更改navigationItem
    override func viewWillDisappear(animated: Bool)
    {
        self.tabBarController?.navigationItem.titleView = nil
    }
}
