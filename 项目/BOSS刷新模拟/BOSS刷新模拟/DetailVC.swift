//
//  DetailVC.swift
//  BOSS刷新模拟
//
//  Created by lizhongqiang on 16/1/11.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

import UIKit

class DetailVC: UIViewController,CenterLoadingDelegate {
    var centerLoading:CenterLoading!
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.whiteColor();
        centerLoading = CenterLoading(size: CGSizeMake(150,50))
        self.view.addSubview(centerLoading)
    }
    
}
