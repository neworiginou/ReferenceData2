
//
//  AddMessageViewController.swift
//  家教
//
//  Created by goofygao on 15/11/4.
//  Copyright © 2015年 goofyy. All rights reserved.
//

import UIKit

class AddMessageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       // self.initView()
    }
    
    
    /**
    *  初始化view
    */
    
    func initView() {
        let rightButton = UIButton(type: .Custom)
        rightButton.tintColor = UIColor.redColor()
        rightButton.titleLabel?.text = "发布"
        rightButton.sizeToFit()
        let rightItemDone = UIBarButtonItem(customView: rightButton)
        self.navigationItem.rightBarButtonItem = rightItemDone
        
    }
}
