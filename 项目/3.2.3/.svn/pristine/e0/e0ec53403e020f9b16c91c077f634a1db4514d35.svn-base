//
//  HWScdHouMakeAppointVC.swift
//  Partner-Swift
//
//  Created by niedi on 15/3/9.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：二手房 预约看房页面
//
//  修改记录：
//      姓名         日期               修改内容
//      聂迪      2015-02-26           功能实现
//

import UIKit

class HWScdHouMakeAppointVC: HWBaseViewController, HWScdHouMakeAppointViewDelegate
{
    var houseId: String! = ""
    var integral: String! = "0"
    
    var mainView: HWScdHouMakeAppointView!
    
    //MARK: viewDidLoad
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.navigationItem.titleView = Utility.navTitleView("预约看房")
        
        mainView = HWScdHouMakeAppointView(frame: CGRectMake(0, 0, kScreenWidth, contentHeight), houseId: houseId, integral: integral)
        mainView.delegate = self
        self.view.addSubview(mainView)
    }
    
    
    //MARK: HWScdHouMakeAppointViewDelegate
    func pushToLinkCustomVC(vc: HWBaseViewController)
    {
        NSNotificationCenter.defaultCenter().removeObserver(mainView)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: 回跳详情页面
    func popToScdHouDetailVC()
    {
        NSNotificationCenter.defaultCenter().postNotificationName("scdHouListRefeshData", object: nil)
        NSNotificationCenter.defaultCenter().postNotificationName("scdHouDetailRefreshDataForAppoint", object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(mainView)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidAppear(animated: Bool)
    {
        NSNotificationCenter.defaultCenter().addObserver(mainView, selector: "keyboardChange:", name: UITextViewTextDidChangeNotification, object: nil)
    }
    
    override func viewDidDisappear(animated: Bool)
    {
        NSNotificationCenter.defaultCenter().removeObserver(mainView)
    }
    
    
}
