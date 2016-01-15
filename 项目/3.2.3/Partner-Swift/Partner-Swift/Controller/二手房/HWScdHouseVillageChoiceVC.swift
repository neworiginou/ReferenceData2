//
//  HWScdHouseVillageChoiceVC.swift
//  Partner-Swift
//
//  Created by niedi on 15/2/28.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：二手房 房源发布 - 选择小区页面
//
//  修改记录：
//      姓名         日期               修改内容
//      聂迪      2015-02-26           功能实现
//

import UIKit

//选择小区view代理
protocol HWScdHouVillageChoiceDelegate: NSObjectProtocol
{
    func clickedModel(model: HWScdHouVillageChoiceModel)
}

class HWScdHouseVillageChoiceVC: HWBaseViewController, HWVillageChoiceDelegate
{
    weak var delegate: HWScdHouVillageChoiceDelegate!
    var villageChoiceView: HWScdHouVillageChoiceView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.titleView = Utility.navTitleView("选择小区")
        
        villageChoiceView = HWScdHouVillageChoiceView(frame: CGRectMake(0, 0, kScreenWidth, contentHeight))
        villageChoiceView.delegate = self
        self.view.addSubview(villageChoiceView)
        
    }
    
    //MARK: cell点击 选择小区 pop
    func cellClickForChoiceVillage(model: HWScdHouVillageChoiceModel)
    {
        delegate.clickedModel(model)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    override func backMethod()
    {
        NSNotificationCenter.defaultCenter().removeObserver(villageChoiceView.searchBar)
        super.backMethod()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
