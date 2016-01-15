//
//  HWScdHouAppointListVC.swift
//  Partner-Swift
//
//  Created by niedi on 15/3/9.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：二手房 房源经纪人 预约人次页面
//
//  修改记录：
//      姓名         日期               修改内容
//      聂迪      2015-02-26           功能实现
//

import UIKit


class HWScdHouAppointListVC: HWBaseViewController
{
    var houseId: String! = ""
    var isPutDown: Bool! = false    //下架时要置灰解锁图片 且不可解锁
    
    //MARK: viewDidLoad
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.navigationItem.titleView = Utility.navTitleView("预约")
        self.navigationItem.leftBarButtonItem = Utility.navLeftBackBtn(self, _selector: "backMethod")
        
        var mainView = HWScdHouAppointListView(frame: CGRectMake(0, 0, kScreenWidth, contentHeight), houseId: houseId, putDownStatus: isPutDown)
        self.view.addSubview(mainView)
    }
    
    
}
