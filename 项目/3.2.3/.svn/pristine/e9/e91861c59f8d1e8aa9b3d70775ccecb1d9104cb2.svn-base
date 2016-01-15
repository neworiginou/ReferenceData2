//
//  HWServiceViewController.swift
//  Partner-Swift
//
//  Created by caijingpeng.haowu on 15/2/11.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：服务首页
//
//  修改记录：
//      姓名         日期              修改内容
//    陆晓波      2015-02-11           文件创建
//    陆晓波      2015-02-28           模拟数据
//    陆晓波      2015-03-02           搜索栏蒙版修改
//    陆晓波      2015-03-07           添加服务产品列表红点
//    陆晓波      2015-03-16           修改添加红点逻辑
//    陆晓波      2015-03-18           新增埋点
//    陆晓波      2015-03-20           搜索时，键盘按搜索按钮闪退修正

import Foundation

let service_tabbar_height:CGFloat = 49

class HWServiceViewController: HWBaseViewController,HWServiceCustomerViewDelegate,CustomSegmentControlDelegate,HWSearchViewModelDelegate,HWServiceCustomerSearchViewDelegate,CustomSearchViewDelegate,HWServiceProductViewDelegate,HWNewChanceViewControllerDelegate
{
    
    var _customerView:HWServiceCustomerView!
    var _productView:HWServiceProductView!
    var _segementControl:CustomSegmentControl!
    var _searchBar:HWSearchViewModel!
    var _searchView:HWServiceCustomerSearchView!
    var _chooseView:CustomSearchView!
    var _currentIndex:Int32 = 0
    let keyBoardHeight:CGFloat = 216
    let kLocalProductCount:NSString = "localProductCount"
    var _redPoint:UILabel!
    var _backgroundView:UIView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        _segementControl = CustomSegmentControl(titles: ["客户","服务产品"])
        _segementControl.delegate = self
        
        //搜索栏
        _searchBar = HWSearchViewModel(delegate: self,type:"0")
        _searchBar.frame = CGRectMake(_searchBar.frame.origin.x, 0, _searchBar.frame.size.width, _searchBar.frame.size.height)
        _searchBar.hidden = false
        self.view.addSubview(_searchBar)
        
        //筛选栏
        _chooseView = CustomSearchView(items: [["不限","权证","金融"],["不限","无意向","待处理","已签单"]], andDefaultTitles: ["需求","状态"], hasSubTitles: false)
        _chooseView.frame = CGRectMake(_chooseView.frame.origin.x, CGRectGetMaxY(_searchBar.frame), _chooseView.frame.size.width, _chooseView.frame.size.height)
        _chooseView.delegate = self
        _chooseView.hidden = false
        self.view.addSubview(_chooseView)
        
        //客户列表
        _customerView = HWServiceCustomerView(frame: CGRectMake(0, CGRectGetMaxY(_chooseView.frame) - 1, kScreenWidth, contentHeight - service_tabbar_height - CGRectGetMaxY(_chooseView.frame) + 1))
        _customerView.hidden = false
        _customerView.customerListdelegate = self
        self.view.addSubview(_customerView)

        //服务产品列表
        _productView = HWServiceProductView(frame: CGRectMake(0, 0, kScreenWidth, contentHeight - service_tabbar_height))
        _productView.hidden = true
        _productView.serviceProductViewDelegate = self
        self.view.addSubview(_productView)
        
        //将视图移到顶层
        self.view.bringSubviewToFront(_searchBar)
        self.view.bringSubviewToFront(_chooseView)
    }
        
    override func viewDidAppear(animated: Bool)
    {
        if (_searchBar != nil)
        {
            NSNotificationCenter.defaultCenter().addObserver(_searchBar, selector: "lianXiangCiShuRu", name: UITextFieldTextDidChangeNotification, object: nil)
        }
        
        self.tabBarController?.navigationItem.titleView = _segementControl
        if (_currentIndex == 0)
        {
            self.tabBarController?.navigationItem.rightBarButtonItem = Utility.navButton(self, _selector: "addItem", _image: UIImage(named: "add_icon1")!)
        }
    }
    
    override func viewDidDisappear(animated: Bool)
    {
        self.tabBarController?.navigationItem.titleView = nil
        self.tabBarController?.navigationItem.rightBarButtonItem = nil
        NSNotificationCenter.defaultCenter().removeObserver(_searchBar, name: UITextFieldTextDidChangeNotification, object: nil)
    }
    
    //MARK:--筛选栏 代理
    
    func customerSearchView(customerSearchView: CustomSearchView!, passZone zoneId: String!, plateId: String!) {
        
    }
    
    func customerSearchView(customerSearchView: CustomSearchView!, passValue value: String!, withIndex index: String!) {
        var valueIndex = value.toInt()!
        let chanceType:NSArray = ["","warrant","financial"]
        let chanceStatus:NSArray = ["","nointention","wait","signed"]
        
        //筛选需求
        if (index == "0")
        {
            //筛选需求 不为 不限
            if(valueIndex != 0)
            {
                _customerView.baseListArr.removeAllObjects()
                _customerView.param.setPObject(chanceType.pObjectAtIndex(valueIndex), forKey: "chanceType")
                _customerView.currentPage = 1
                _customerView.queryListData()
            }
            else
            {
                _customerView.baseListArr.removeAllObjects()
                _customerView.param.removeObjectForKey("chanceType")
                _customerView.queryListData()
            }
        }
            //筛选状态
        else if (index == "1")
        {
            //筛选状态 不为 不限
            if(valueIndex != 0)
            {
                _customerView.baseListArr.removeAllObjects()
                _customerView.param.setPObject(chanceStatus.pObjectAtIndex(valueIndex), forKey: "chanceStatus")
                _customerView.currentPage = 1
                _customerView.queryListData()
            }
            else
            {
                _customerView.baseListArr.removeAllObjects()
                _customerView.param.removeObjectForKey("chanceStatus")
                _customerView.queryListData()
            }
        }
    }
    
    //MARK:--搜索栏 代理
    //输入搜索关键字
    func didSelectedSearchTitle(title: String!)
    {
        if (_searchView == nil)
        {
            _searchView = HWServiceCustomerSearchView(frame: CGRectMake(0, CGRectGetMaxY(_searchBar.frame), kScreenWidth, contentHeight - _chooseView.frame.origin.y - service_tabbar_height))
            _searchView.customerSearchViewDelegate = self
            self.view.addSubview(_searchView)
            _searchView.baseTable.frame = CGRectMake(_searchView.baseTable.frame.origin.x, _searchView.baseTable.frame.origin.y, _searchView.baseTable.frame.size.width, _searchView.frame.height - keyBoardHeight)
        }
//        else
//        {
//            _searchView.baseTable.frame = CGRectMake(_searchView.baseTable.frame.origin.x, _searchView.baseTable.frame.origin.y, _searchView.baseTable.frame.size.width, _searchView.frame.height - keyBoardHeight)
//        }
        _searchView._searchKey = title
        _searchView.currentPage = 1
        if (_searchView._searchKey.length > 0)
        {
            _searchView.baseListArr.removeAllObjects()
            _searchView.queryListData()
        }
        else
        {
            _searchView.baseListArr.removeAllObjects()
            _searchView.showEmptyView("请输入搜索内容")
            _searchView.baseTable.reloadData()
        }
        
    }
    
    //进入编辑状态，添加蒙版
    func didBeginEditing()
    {
        if (_backgroundView == nil)
        {
            _backgroundView = UIView(frame: CGRectMake(0, CGRectGetMaxY(_searchBar.frame), kScreenWidth, 0))
            _backgroundView.backgroundColor = UIColor.grayColor()
            _backgroundView.alpha = 0.5
            _backgroundView.layer.masksToBounds = true
        
            self.view.addSubview(_backgroundView)
            self.view.bringSubviewToFront(_backgroundView)
        
            weak var weakSelf: HWServiceViewController? = self
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                var originY: CGFloat? = weakSelf?._backgroundView.frame.origin.y
                weakSelf?._backgroundView.frame = CGRectMake(0, originY!, kScreenWidth, contentHeight)
            })
            { (finished) -> Void in
            }
        }
    }
    
    //结束编辑状态，移除蒙版
    func didEndEditing()
    {
        if (_backgroundView != nil)
        {
            weak var weakSelf:HWServiceViewController? = self
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                var originY:CGFloat? = weakSelf?._backgroundView.frame.origin.y
                weakSelf?._backgroundView.frame = CGRectMake(0, originY!, kScreenWidth, 0)
            }, completion: { (finished) -> Void in
                self._backgroundView.removeFromSuperview()
                self._backgroundView = nil
            })
        }
        
        if (_searchView != nil)
        {
            _searchView.removeFromSuperview()
            _searchView = nil
        }
    }
    
    //点击search按钮
    func didSelectedSearchBtn()
    {
        if(_searchView != nil)
        {
           _searchView.baseTable.frame = CGRectMake(_searchView.baseTable.frame.origin.x, _searchView.baseTable.frame.origin.y, _searchView.baseTable.frame.size.width, _searchView.frame.height)
        }
    }
    
    //MARK:--客户列表点击代理
    func didSelectedServiceCustomerList(model: HWServiceCustomerModel)
    {
        var chanceDetailVC = HWChanceDetailViewController()
        chanceDetailVC._model = model
        self.navigationController?.pushViewController(chanceDetailVC, animated: true)
    }
    
    //MARK:--服务产品列表 点击代理
    func didSelectedServiceProductList(model: HWServiceProductModel)
    {
        var productIntroductionVC = HWProductIntroductionViewController()
        productIntroductionVC._urlStr = model.detailsURL
        self.navigationController?.pushViewController(productIntroductionVC, animated: true)
    }
    
    //服务产品列表 加载完成 返回列表数量 判断增加小红点
    func passProductListCount(productListCount: NSInteger)
    {
        //创建红点
        _redPoint = UILabel(forAutoLayout: ())
        _redPoint.backgroundColor = CD_RedDeepColor
        _redPoint.layer.masksToBounds = true
        _redPoint.layer.cornerRadius = 4
        _redPoint.hidden = true
        _segementControl.addSubview(_redPoint)
        
        _redPoint.autoSetDimension(ALDimension.Height, toSize: 8)
        _redPoint.autoSetDimension(ALDimension.Width, toSize: 8)
        _redPoint.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: _segementControl, withOffset: 6)
        _redPoint.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Right, ofView: _segementControl, withOffset: -6)
        
        var userDefaults = NSUserDefaults.standardUserDefaults()
        let count = userDefaults.integerForKey(kLocalProductCount)
        
        //取得服务产品数 大于 本地存储数，显示红点并记录
        if (productListCount > count)
        {
            _redPoint.hidden = false
            userDefaults.setInteger(productListCount, forKey: kLocalProductCount)
            userDefaults.synchronize()
        }
        else
        {
            _redPoint.hidden = true
        }
    }
    
    //MARK:--搜索列表点击代理
    func didSelectedSearchView(model: HWServiceCustomerModel)
    {
        println("跳转详情 同客户列表")
        var chanceDetailVC = HWChanceDetailViewController()
        chanceDetailVC._model = model
        self.navigationController?.pushViewController(chanceDetailVC, animated: true)
    }
    
    //MARK:--跳转 新建机会
    func addItem()
    {
        //埋点：服务 新建服务客户
        MobClick.event("Createserveclient_click")
        
        var newChanceVC = HWNewChanceViewController()
        newChanceVC.newChanceViewDelegate = self
        self.navigationController?.pushViewController(newChanceVC, animated: true)
    }
    
    //MARK:--segmentControl代理方法
    func segmentControl(sControl: CustomSegmentControl!, didSelectSegmentIndex index: Int32)
    {
        _currentIndex = index
        if _currentIndex == 0
        {
            _customerView.hidden = false
            _productView.hidden = true
            _searchBar.hidden = false
            _chooseView.hidden = false
            if (_searchView != nil)
            {
                _searchView.hidden = false
            }
            if (_backgroundView != nil)
            {
                _backgroundView.hidden = false
            }
            
            if self.tabBarController?.navigationItem.rightBarButtonItem == nil
            {
                self.tabBarController?.navigationItem.rightBarButtonItem = Utility.navButton(self, _selector: "addItem", _image: UIImage(named: "add_icon1")!)
            }
        }
        else
        {
            _customerView.hidden = true
            _productView.hidden = false
            _searchBar.hidden = true
            self._chooseView.hidden = true
//            if (_chooseView.searchBackView != nil)
//            {
//                _chooseView?.removeBackView()
//            }
            _chooseView?.removeBackView()
            if (_redPoint != nil)
            {
                _redPoint.hidden = true
            }
            if (_searchView != nil)
            {
                _searchView.hidden = true
            }
            if (_backgroundView != nil)
            {
                _backgroundView.hidden = true
            }
            
            self.tabBarController?.navigationItem.rightBarButtonItem = nil
        }
    }
    
    //MARK:--新建机会代理
    //新建机会成功，返回服务-客户列表，刷新数据
    func refreshServiceCustomerList()
    {
//        if (_searchView != nil)
//        {
//            _searchView.removeFromSuperview()
//            _searchView = nil
//        }
        
        _customerView.currentPage = 1
        _customerView.baseListArr.removeAllObjects()
        _customerView.queryListData()
        
    }
}
