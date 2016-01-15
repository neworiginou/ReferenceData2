//
//  HWSecondHouseViewController.swift
//  Partner-Swift
//
//  Created by caijingpeng.haowu on 15/2/11.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：二手房首页列表 页面
//
//  修改记录：
//      姓名         日期               修改内容
//      聂迪      2015-02-26           功能实现
//

import Foundation


class HWSecondHouseViewController: HWBaseViewController,HWScdHouseViewDelegate,CustomSearchViewDelegate
{
    var mainView : HWScdHouseView!
    var isNeedRefresh: Bool = false
    
    //MARK: viewDidLoad
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.tabBarController?.navigationItem.titleView = Utility.navTitleView("二手房")
//        self.tabBarController?.navigationItem.rightBarButtonItem = Utility.navButton(self, _title: "发布", _selector: "pushToCreatSecHouseVC")
       self.tabBarController?.navigationItem.rightBarButtonItem = Utility.navButton(self, _selector: "pushToCreatSecHouseVC", _image: UIImage(named: "add_icon1")!)
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshData", name: "scdHouListRefeshData", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "queryListData", name: kUpdateUserInfo, object: nil)
         
        //筛选框
        var documentsDirectory = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as NSString
        var filePath = documentsDirectory.stringByAppendingPathComponent("city.plist")
        var cities : NSArray = NSArray(contentsOfFile: filePath)!
        
        var cityClass : HWCityClass = HWCityClass(dic: cities[0] as NSDictionary)
        
        for var i = 0; i < cities.count; i++
        {
            var cityCl = HWCityClass(dic: cities[i] as NSDictionary)
            if (cityCl.cityId! == HWUserLogin.currentUserLogin().cityId)
            {
                cityClass = cityCl
            }
        }
        var choiceSectionView: CustomSearchView = CustomSearchView(items: [cityClass.areas!,["不限", "100万以下", "100-150万", "150-200万", "200-300万", "300-500万", "500-1000万", "1000万以上"], ["不限","一居","二居","三居","四居","五居","五居以上"], ["默认排序","总价倒序","总价正序","楼盘均价倒序","楼盘均价正序","面积倒序","面积正序"]], andDefaultTitles: ["区域","价格","户型","默认排序"], hasSubTitles: true);
        choiceSectionView.delegate = self
        self.view.addSubview(choiceSectionView)
        
        //二手房列表talbeView
        mainView = HWScdHouseView(frame: CGRectMake(0, 35, kScreenWidth, contentHeight - 35 - 49))
        mainView.delegate = self
        self.view.addSubview(mainView)
        
    }
    func queryListData()
    {
        var documentsDirectory = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as NSString
        var filePath = documentsDirectory.stringByAppendingPathComponent("city.plist")
        var cities : NSArray = NSArray(contentsOfFile: filePath)!
        
        var cityClass : HWCityClass = HWCityClass(dic: cities[0] as NSDictionary)

        for var i = 0; i < cities.count; i++
        {
            var cityCl = HWCityClass(dic: cities[i] as NSDictionary)
            if (cityCl.cityId! == HWUserLogin.currentUserLogin().cityId)
            {
                cityClass = cityCl
            }
        }
        var choiceSectionView: CustomSearchView = CustomSearchView(items: [cityClass.areas!,["不限", "100万以下", "100-150万", "150-200万", "200-300万", "300-500万", "500-1000万", "1000万以上"], ["不限","一居","二居","三居","四居","五居","五居以上"], ["默认排序","总价倒序","总价正序","楼盘均价倒序","楼盘均价正序","面积倒序","面积正序"]], andDefaultTitles: ["区域","价格","户型","默认排序"], hasSubTitles: true);
        choiceSectionView.delegate = self
        self.view.addSubview(choiceSectionView)
        mainView.currentPage = 1
        mainView._areaId = ""
        mainView._plateId = ""
        mainView.priceIndex = ""
        mainView.roomCountIndex = ""
        mainView.orderTypeIndex = ""
        mainView.queryListData()
        mainView.loadData()
    }
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "scdHouListRefeshData", object: nil)
    }
    
    //MARK: 筛选框代理方法
    func customerSearchView(customerSearchView: CustomSearchView!, passValue value: String!, withIndex index: String!)
    {
        mainView.customerSearchView(customerSearchView, passValue: value, withIndex: index)
    }
    
    func customerSearchView(customerSearchView: CustomSearchView!, passZone zoneId: String!, plateId: String!)
    {
        mainView.customerSearchView(customerSearchView, passZone: zoneId, plateId: plateId)
    }
    
    //MARK: 房源发布按钮点击事件
    func pushToCreatSecHouseVC()
    {
        var scdHCreatVC = HWScdHouseCreatEditVC()
        scdHCreatVC.isCreat = CreatOrEdit.Creat
        self.pushVC(scdHCreatVC)
    }
    
    //MARK: cell点击代理事件 跳转详情页面
    func pushVC(VC: HWBaseViewController)
    {
        self.navigationController!.pushViewController(VC, animated: true)
    }
    
    //MARK: 发布房源或编辑房源后 刷新数据
    func refreshData()
    {
        isNeedRefresh = true
    }
    
    //MARK: 更改navigationItem
    override func viewDidAppear(animated: Bool)
    {
        self.tabBarController?.navigationItem.titleView = Utility.navTitleView("二手房")
//        self.tabBarController?.navigationItem.rightBarButtonItem = Utility.navButton(self, _title: "发布", _selector: "pushToCreatSecHouseVC")
         self.tabBarController?.navigationItem.rightBarButtonItem = Utility.navButton(self, _selector: "pushToCreatSecHouseVC", _image: UIImage(named: "add_icon1")!)
        
        //二手房 系统配置 更新 niedi
        HWScdHouConfigCenter.defaultCenter().updateConfig()
        
        if(isNeedRefresh == true)
        {
            mainView.currentPage = 1
            mainView.refreshData()
            isNeedRefresh = false
        }
    }
    
    //MARK: 更改navigationItem
    override func viewWillDisappear(animated: Bool)
    {
        self.tabBarController?.navigationItem.titleView = nil
        self.tabBarController?.navigationItem.rightBarButtonItem = nil
    }
    
    //MARK: 进入二手房列表发起定位-发布房源 定位小区
    override func viewWillAppear(animated: Bool)
    {
        var l = HWLocationManager.shareManager().startLoacting()
    }
    
}
