//
//  HWScdHouseCreatEditVC.swift
//  Partner-Swift
//
//  Created by niedi on 15/2/27.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：二手房 房源发布 或 二手房房源编辑-详情编辑 页面
//
//  修改记录：
//      姓名         日期               修改内容
//      聂迪      2015-02-26           功能实现
//

import UIKit

//房源发布或编辑
enum CreatOrEdit : Int
{
    case Creat
    case EditPicture    //二手房编辑图片
    case EditConfig     //二手房编辑详情
}

class HWScdHouseCreatEditVC: HWBaseViewController, HWScdHouseCreatEditViewDelegate
{
    //MARK: 成员变量
    var isCreat: CreatOrEdit!
    var isMyHouse: Bool = false //是否是我的房店页面进的发布（pop的页面不一样）
    var _model: HWScdHouseDetailModel = HWScdHouseDetailModel()
    var mainView: HWScdHouseCreatEditView!
    var modelDict: NSDictionary = NSDictionary()
    
    override func viewWillAppear(animated: Bool)
    {
        if(isCreat == CreatOrEdit.Creat)
        {
            self.navigationItem.titleView = Utility.navTitleView("发布房源")
        }
        else
        {
            self.navigationItem.titleView = Utility.navTitleView("房源编辑")
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if(isMyHouse == true)//发布房源埋点
        {
            MobClick.event("SubmitSCDhouse_click1")//maidian_3.0_niedi //从我的房店进
        }
        else
        {
            MobClick.event("SubmitSCDhouse_click2")//maidian_3.0_niedi //从二手房首页进
        }
        
        mainView = HWScdHouseCreatEditView(frame: CGRectMake(0, 0, kScreenWidth, contentHeight), isCreat: isCreat, model: _model)
        mainView.delegate = self
        mainView.isMyHouse = isMyHouse
        self.view.addSubview(mainView)
    }
    
    
    //MARK: HWScdHouseCreatEditViewDelegate
    func delegatePushVC(VC: HWBaseViewController)
    {
      self.navigationController?.pushViewController(VC, animated: true)
            
    
    }
    
    //MARK: 房源编辑返回到详情页
    func delegatePopToDetailVC()
    {
        NSNotificationCenter.defaultCenter().postNotificationName("scdHouDetailRefreshData", object: nil)
        NSNotificationCenter.defaultCenter().postNotificationName("scdHouListRefeshData", object: nil)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
