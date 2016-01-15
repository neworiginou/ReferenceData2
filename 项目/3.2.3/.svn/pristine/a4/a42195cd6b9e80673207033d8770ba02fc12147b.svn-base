//
//  HWScdHouseDetailVC.swift
//  Partner-Swift
//
//  Created by niedi on 15/2/27.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：二手房 房源详情页面
//
//  修改记录：
//      姓名         日期               修改内容
//      聂迪      2015-02-26           功能实现
//

import UIKit

enum ScdHouRightNavItemType : Int
{
    case Mine   //我的房源
    case Collected      //已收藏
    case Collecting     //未收藏
    case PutDown        //已下架
}

class HWScdHouseDetailVC: HWBaseViewController, HWScdHouseDetailViewDelegate, HWCustomSiftViewDelegate, UIAlertViewDelegate
{
    //MARK: 成员变量
    var _houseId: String!
    var _type: ScdHouRightNavItemType!
    var _model: HWScdHouseDetailModel!
    var _modelDict: NSDictionary! = NSDictionary()
    var _mainView: HWScdHouseDetailView!
    var isNeedRefresh: Bool = false
    var isNeedRefreshForAppoint: Bool = false
    
    //MARK: viewDidLoad
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.navigationItem.titleView = Utility.navTitleView("楼盘详情")
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshData", name: "scdHouDetailRefreshData", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshDataForAppoint", name: "scdHouDetailRefreshDataForAppoint", object: nil)
        
        _mainView = HWScdHouseDetailView(frame: CGRectMake(0, 0, kScreenWidth, contentHeight), houseId: _houseId, delegate: self)
        self.view.addSubview(_mainView)
    }
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "scdHouDetailRefreshData", object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "scdHouDetailRefreshDataForAppoint", object: nil)
    }
    
    
    //MARK: 导航栏右BarItem点击事件
    func rightNavBarClick()
    {
        if(_type == ScdHouRightNavItemType.Mine)
        {
            if(_mainView._model.status == "putdown")//已下架
            {
                var alertView = UIAlertView(title: "", message: "该房源已下架,不能进行下架或编辑操作", delegate: self, cancelButtonTitle: nil, otherButtonTitles: "确定")
                alertView.show()
            }
                
            else
            {
                self.toShowMore()
            }
        }
        else if(_type == ScdHouRightNavItemType.Collected)//已收藏
        {
            self.rightNavClickForCancleCollect()
        }
        else//未收藏
        {
            MobClick.event("SCDhousefavorite_click")//maidian_3.0_niedi
            
            self.rightNavClickForCollect()
        }
    }
    
    //点击收藏
    func rightNavClickForCollect()
    {
        /*url:/MyHousesInfo/collect.do
        入参：houseId 房源Id
        出参：
        { "detail": "请求数据成功!", "status": "1", "data": "操作成功" } */
        Utility.hideMBProgress(self.view)
        Utility.showMBProgress(self.view, _message: "上传中")
        
        let manager = HWHttpRequestOperationManager.baseManager()
        var param = NSMutableDictionary()
        
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param.setPObject(_houseId, forKey: "houseId")
        
        manager.postHttpRequest(KScdHouCollect, parameters: param, queue: nil, success: { (responseObject) -> Void in
            
            Utility.hideMBProgress(self.view)
            Utility.showToastWithMessage("收藏成功", _view: self.view)
            
            self._type = ScdHouRightNavItemType.Collected
            self.navigationItem.rightBarButtonItem = Utility.navButton(self, _selector: "rightNavBarClick", _image: UIImage(named: "collect2")!)
            NSNotificationCenter.defaultCenter().postNotificationName("myHouseCollectRefresh", object: nil)
            
            }) { (code, error) -> Void in
                
                Utility.hideMBProgress(self.view)
                Utility.showToastWithMessage(error, _view: self.view)
        }
    }
    
    //点击取消收藏
    func rightNavClickForCancleCollect()
    {
        /*url:/MyHousesInfo/noCollect.do
        入参：houseId
        出参：
        { "detail": "请求数据成功!", "status": "1", "data": "操作成功" } */
        Utility.hideMBProgress(self.view)
        Utility.showMBProgress(self.view, _message: "上传中")
        
        let manager = HWHttpRequestOperationManager.baseManager()
        var param = NSMutableDictionary()
        
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param.setPObject(_houseId, forKey: "houseId")
        
        manager.postHttpRequest(kScdHouCancleCollect, parameters: param, queue: nil, success: { (responseObject) -> Void in
            
            Utility.hideMBProgress(self.view)
            Utility.showToastWithMessage("取消收藏成功", _view: self.view)
            
            self._type = ScdHouRightNavItemType.Collecting
            self.navigationItem.rightBarButtonItem = Utility.navButton(self, _selector: "rightNavBarClick", _image: UIImage(named: "collect1")!)
            NSNotificationCenter.defaultCenter().postNotificationName("myHouseCollectRefresh", object: nil)
            
            }) { (code, error) -> Void in
                
                Utility.hideMBProgress(self.view)
                Utility.showToastWithMessage(error, _view: self.view)
        }
    }
    
    //MARK: 房源编辑或下架 操作框
    func toShowMore() -> Void
    {
        let titleArr = NSArray(objects: "房源编辑", "房源下架")
        let imageArr = NSArray(objects: "editor_icon1", "editor_icon2")
        let selectView = HWCustomSiftView(title: titleArr, image:imageArr, andDependView: self.navigationItem.rightBarButtonItem?.customView)
        selectView.delegate = self
        selectView.showInView(shareAppDelegate.window)
    }
    
    //MARK: HWCustomSiftViewDelegate 操作框代理
    func siftView(siftView: HWCustomSiftView!, didSelectedIndex index: Int)
    {
        if(index == 0)
        {
            var scdHEditVC = HWScdHouseCreatEditVC()
            scdHEditVC.isCreat = CreatOrEdit.EditConfig
            _model = HWScdHouseDetailModel()    //为起到复制作用新建
            _model.initWithDict(_modelDict)
            scdHEditVC._model = _model
            NSNotificationCenter.defaultCenter().postNotificationName("myHousePutDownRefresh", object: nil)
            self.delegatePushVC(scdHEditVC)
        }
        else
        {
            var alertView = UIAlertView(title: "", message: "下架后其他人将无法看到该房源\n是否确认", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "确认")
            alertView.show()
        }
    }
    
    //MARK: UIAlertViewDelegate 下架房源
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int)
    {
        if(buttonIndex == 1)
        {
            self.putDownScdHouse()
        }
    }
    
    //房源下架
    func putDownScdHouse()
    {
        /*URL：myStore/putDown.do
        入参：
        key:*** --用户key
        id：*** --二手房ID
        出参：
        { "detail": "请求数据成功!", "status": "1", "data": "操作成功" } */
        Utility.hideMBProgress(self.view)
        Utility.showMBProgress(self.view, _message: "上传中")
        
        let manager = HWHttpRequestOperationManager.baseManager()
        var param = NSMutableDictionary()
        
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param.setPObject(_houseId, forKey: "id")
        
        manager.postHttpRequest(kScdHouPutDown, parameters: param, queue: nil, success: { (responseObject) -> Void in
            
            Utility.hideMBProgress(self.view)
            Utility.showToastWithMessage("下架成功", _view: self.view)
            
            self._mainView.refreshData()
            NSNotificationCenter.defaultCenter().postNotificationName("myHousePutDownRefresh", object: nil)
            
            }) { (code, error) -> Void in
                
                Utility.hideMBProgress(self.view)
                Utility.showToastWithMessage(error, _view: self.view)
        }
        
    }
    
    //HWScdHouseDetailViewDelegate Method
    func delegateChangeNavItemImg(type: ScdHouRightNavItemType, modelDict: NSDictionary)
    {
        _type = type
        _modelDict = modelDict
        
        if(_type == ScdHouRightNavItemType.Mine)
        {
            self.navigationItem.rightBarButtonItem = Utility.navButton(self, _selector: "rightNavBarClick", _image: UIImage(named: "more_icon")!)
        }
        else if(_type == ScdHouRightNavItemType.Collected)
        {
            self.navigationItem.rightBarButtonItem = Utility.navButton(self, _selector: "rightNavBarClick", _image: UIImage(named: "collect2")!)
        }
        else if(_type == ScdHouRightNavItemType.Collecting)
        {
            self.navigationItem.rightBarButtonItem = Utility.navButton(self, _selector: "rightNavBarClick", _image: UIImage(named: "collect1")!)
        }
        else if(_type == ScdHouRightNavItemType.PutDown)
        {
            self.navigationItem.rightBarButtonItem = nil
        }
    }
    
    //MARK: 预约看房、房源编辑、下架 刷新数据
    func refreshData()
    {
        isNeedRefresh = true
    }
    
    func refreshDataForAppoint()
    {
        self.refreshData()
        isNeedRefreshForAppoint = true
    }
    
    func delegatePushVC(vc: UIViewController)
    {
       
        if vc .isKindOfClass(HWWebViewController)
        {
             self.navigationController?.pushViewController(vc, animated: false)
        }
        else
        {
              self.navigationController?.pushViewController(vc, animated: true)
        }
//  self.navigationController?.pushViewController(vc, animated: true)
      
    }
    
    override func backMethod()
    {
        if(isNeedRefreshForAppoint == true)
        {
            NSNotificationCenter.defaultCenter().postNotificationName("myHouseAppointRefresh", object: nil)
            isNeedRefreshForAppoint = false
        }
        super.backMethod()
    }
    
    //MARK: 刷新数据
    override func viewDidAppear(animated: Bool)
    {
        if(isNeedRefresh == true)
        {
            _mainView.refreshData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
