//
//  HWScdHouseCreatStep2VC.swift
//  Partner-Swift
//
//  Created by niedi on 15/3/4.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：二手房房源发布图片选择及发布提交 或 二手房房源编辑图片编辑
//
//  修改记录：
//      姓名         日期               修改内容
//      聂迪      2015-02-26           功能实现
//

import UIKit


class HWScdHouseCreatStep2VC: HWBaseViewController, HWScdHouseCreatStep2ViewDelegate
{
    var _isCreat: CreatOrEdit!      //发布房源添加图片、编辑房源修改图片
    var isMyHouse: Bool = false     //是否从我的房店进入
    var _model: HWScdHouseDetailModel! = HWScdHouseDetailModel()
    
    var indoorArr: NSArray! = []
    var houseStyleArr: NSArray! = []
    var houseId: NSString! = ""
    var permission: NSString! = ""
    override func viewDidLoad()
    {
        super.viewDidLoad()
              //由于swift编译文件没有_iscreat变量 所以用houseid判断
        if(houseId != "")
        {
            _isCreat = CreatOrEdit.EditPicture
        }
        
        if(_isCreat == CreatOrEdit.Creat)
        {
            self.navigationItem.titleView = Utility.navTitleView("发布房源")
            
        }
        else
        {
            self.navigationItem.titleView = Utility.navTitleView("房源编辑")
        }
        var mainView: HWScdHouseCreatStep2View = HWScdHouseCreatStep2View(frame: CGRectMake(0, 0, kScreenWidth, contentHeight), isCreat: _isCreat, model: _model, indoorArr: indoorArr, houseStyleArr: houseStyleArr, houseId: houseId)
        mainView.delegate = self
        self.view.addSubview(mainView)
    }
    
    //MARK: HWScdHouseCreatStep2ViewDelegate
    func delegatePresentVC(vc: UIViewController)
    {
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    //MARK: 跳转到二手房列表或我的房店列表
    func delegatePopToRootVC()
    {
        if(isMyHouse == true)
        {
            NSNotificationCenter.defaultCenter().postNotificationName("refreshMyHouseList", object: nil)
            self.navigationController?.popToViewController(self.navigationController?.viewControllers[1] as UIViewController, animated: true)
        }
        else
        {
            NSNotificationCenter.defaultCenter().postNotificationName("scdHouListRefeshData", object: nil)
            self.navigationController?.popToRootViewControllerAnimated(true)
        }
        
    }
    
    //MARK: 回跳到详情页面
    func delegatePopToScdHouDetailVC()
    {
        NSNotificationCenter.defaultCenter().postNotificationName("scdHouListRefeshData", object: nil)
        NSNotificationCenter.defaultCenter().postNotificationName("scdHouDetailRefreshData", object: nil)
        self.navigationController?.popToViewController(self.navigationController?.viewControllers[1] as UIViewController, animated: true)
    }
    
    //MARK: pushVC
    func delegatePushVC(vc: UIViewController)
    {
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    override func backMethod()
    {
        if(_isCreat == CreatOrEdit.EditConfig)
        {
            NSNotificationCenter.defaultCenter().postNotificationName("scdHouListRefeshData", object: nil)
            NSNotificationCenter.defaultCenter().postNotificationName("scdHouDetailRefreshData", object: nil)
            self.navigationController?.popToViewController(self.navigationController?.viewControllers[1] as UIViewController, animated: true)
        }
        else
        {
            super.backMethod()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
