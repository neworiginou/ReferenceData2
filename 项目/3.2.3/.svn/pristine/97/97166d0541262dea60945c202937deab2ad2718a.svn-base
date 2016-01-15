//
//  HWMyHouseShopViewController.swift
//  Partner-Swift
//
//  Created by hw500027 on 15/3/3.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：我的房店
//
//  修改记录：
//      姓名         日期              修改内容
//    陆晓波      2015-03-03           文件创建
//    陆晓波      2015-03-04           添加动态列表代理
//    陆晓波      2015-03-06           添加实现代理
//    陆晓波      2015-03-11           添加title红点 接口调试

import UIKit

class HWMyHouseShopViewController: HWBaseViewController,CustomSegmentControlDelegate,HWDynamicViewDelegate,HWMyHouseViewDelegate,HWMyCollectionViewDelegate,HWDynamicDetailViewControllerDelegate
{
    var _segementControl:CustomSegmentControl!
    var _segmentIndex:Int32 = 0
    
    var _dynamicView:HWDynamicView!
    var _houseView:HWMyHouseView!
    var _collectionView:HWMyCollectionView!
    
    var _pendingArray:NSMutableArray!
    var Index:Int! = 0
    var _redPoint:UILabel!
    typealias selectCustomerBlock = () ->Void
    var myFunc = selectCustomerBlock?()
    var isNeedRefresh = false
    override func backMethod()
    {
        if (self.myFunc != nil)
        {
            self.myFunc!()
        }
        
        
        self.navigationController?.popViewControllerAnimated(true);
        
        
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Default
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshHouseList", name: "refreshMyHouseList", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "isToRefreshList", name: "myHouseAppointRefresh", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "isToRefreshList", name: "myHousePutDownRefresh", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "isToRefreshList", name: "myHouseCollectRefresh", object: nil)
        
        //segementControl
        _segementControl = CustomSegmentControl(titles: ["动态","我的房源","我的收藏"])
        _segementControl.delegate = self
        self.navigationItem.titleView =  _segementControl
        
        //状态 列表
        _dynamicView = HWDynamicView(frame: CGRectMake(0, 0, kScreenWidth, contentHeight))
        _dynamicView.dynamicViewDelegate = self
        _dynamicView.hidden = false
        self.view.addSubview(_dynamicView)
        
        //我的房源 列表
        _houseView = HWMyHouseView(frame: CGRectMake(0, 0, kScreenWidth, contentHeight))
        _houseView.houseViewDelegate = self
        _houseView.createWriteInBtn()
        _houseView.hidden = true
        self.view.addSubview(_houseView)
        
        //我的收藏 列表
        _collectionView = HWMyCollectionView(frame: CGRectMake(0, 0, kScreenWidth, contentHeight))
        _collectionView.collectionViewDelegate = self
        _collectionView.hidden = true
        self.view.addSubview(_collectionView)
        
        //title红点
        _redPoint = UILabel(forAutoLayout: ())
        _redPoint.backgroundColor = CD_RedDeepColor
        _redPoint.layer.masksToBounds = true
        _redPoint.layer.cornerRadius = 4
        _redPoint.hidden = true
        _segementControl.addSubview(_redPoint)
        
        _redPoint.autoSetDimension(ALDimension.Height, toSize: 8)
        _redPoint.autoSetDimension(ALDimension.Width, toSize: 8)
        _redPoint.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: _segementControl, withOffset: 6)
        _redPoint.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Left, ofView: _segementControl, withOffset: _segementControl.frame.width/3 - 6)
        
        // Do any additional setup after loading the view.
    }
    
    func isToRefreshList()
    {
        isNeedRefresh = true
    }
    
    override func viewDidAppear(animated: Bool)
    {
        if (isNeedRefresh == true)
        {
            self.refreshDynamicList()
            self.refreshHouseList()
            self.refreshCollectionList()
            isNeedRefresh = false
        }
    }
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "refreshMyHouseList", object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "myHouseAppointRefresh", object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "myHousePutDownRefresh", object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "myHouseCollectRefresh", object: nil)
    }
    
    func refreshHouseList()
    {
        _houseView.currentPage = 1
        _houseView.baseListArr.removeAllObjects()
        _houseView.queryListData()
    }
    
    func refreshCollectionList()
    {
        _collectionView.currentPage = 1
        _collectionView.baseListArr.removeAllObjects()
        _collectionView.queryListData()
    }
    
    //MARK:--segmentControl代理
    func segmentControl(sControl: CustomSegmentControl!, didSelectSegmentIndex index: Int32)
    {
        _segmentIndex = index
        
        if (_segmentIndex == 0)
        {
            _dynamicView.hidden = false
            _houseView.hidden = true
            _collectionView.hidden = true
        }
        else if (_segmentIndex == 1)
        {
            _dynamicView.hidden = true
            _houseView.hidden = false
            _collectionView.hidden = true
        }
        else if (_segmentIndex == 2)
        {
            _dynamicView.hidden = true
            _houseView.hidden = true
            _collectionView.hidden = false
        }
    }
    
    //双击title
    func doubleClickGestureRecognizer()
    {
        if (_segmentIndex == 0)
        {
            if (_dynamicView.pendingArray.count > 0)
            {
//                println(_dynamicView.pendingArray)
                _dynamicView.baseTable.scrollToRowAtIndexPath(NSIndexPath(forRow: _dynamicView.pendingArray[Index] as NSInteger, inSection: 0), atScrollPosition: UITableViewScrollPosition.Top, animated: true)
                if (Index < _dynamicView.pendingArray.count - 1)
                {
                    Index = Index + 1
                }
            }
        }
    }
    
    //MARK:--状态列表 代理
    //点击列表
    func didSelectedDynamicList(model: HWDynamicModel)
    {
        //预约看房 跳转状态详情
        if (model.operationType == "appoint")
        {
            var dynamicDetailVC = HWDynamicDetailViewController()
            dynamicDetailVC.dynamicDetailViewControllerDelegate = self
//            println("1:动态id == \(model.id)")
            dynamicDetailVC._id = model.id!
            if (model.pendingState == "pending")
            {
                dynamicDetailVC._status = pendingState.pending
            }
            else
            {
                dynamicDetailVC._status = pendingState.pended
            }
            if (model.isLock == "yes" && model.pendingState == "pended")
            {
                //灰色解锁按钮时 不做处理
            }
            else
            {
                self.navigationController?.pushViewController(dynamicDetailVC, animated: true)
            }
            
        }
        //房源编辑 跳转房源详情
        else if (model.operationType == "edit")
        {
            var scdHouseDetailVC = HWScdHouseDetailVC()
            scdHouseDetailVC._houseId = model.secHouseId
            self.navigationController?.pushViewController(scdHouseDetailVC, animated: true)
        }
        //房源下架 不做处理
        else
        {
            
        }
    }
    
    //刷新title红点状态
    func refreshRedPointStatus(houseCount: NSString)
    {
//        println("houseCount==\(houseCount)")
        if (houseCount.integerValue > 0)
        {
            _redPoint.hidden = false
        }
        else if (houseCount.integerValue == 0)
        {
            _redPoint.hidden = true
        }
    }
    
    //MARK:--我的房源代理
    //点击我的房源列表
    func didSelectedHouseList(model: HWMyHouseModel)
    {
        var scdHouseDetailVC = HWScdHouseDetailVC()
        scdHouseDetailVC._houseId = model.scdhandHousesId
        self.navigationController?.pushViewController(scdHouseDetailVC, animated: true)
    }
    
    //点击我的房源-录入按钮
    func didClickWriteInBtn()
    {
        var scdHouseCreateVC = HWScdHouseCreatEditVC()
        scdHouseCreateVC.isCreat = CreatOrEdit.Creat
        scdHouseCreateVC.isMyHouse = true
        self.navigationController?.pushViewController(scdHouseCreateVC, animated: true)
    }
    
    //MARK:--我的收藏代理
    func didSelectedCollection(model: HWMyCollectionModel)
    {
        //MYP add v3.2.1区分新房和二手房详情跳转
        if model.isNewHouse == "1"
        {
            var newHouseDetailVC = HWNewDetailVC()
            newHouseDetailVC.houseId = model.projectId
            newHouseDetailVC.hasCollected = true
            self.navigationController?.pushViewController(newHouseDetailVC, animated: true)
        }
        else
        {
            var scdHouseDetailVC = HWScdHouseDetailVC()
            //        println("model.scdHandHousesId==\(model.scdhandHousesId)")
            //        println("model.scdHandHousesId==\(model.scdhandHousesId)")
            scdHouseDetailVC._houseId = model.scdhandHousesId!
            //        println("_houseId==\(scdHouseDetailVC._houseId)")
            self.navigationController?.pushViewController(scdHouseDetailVC, animated: true)
        }
        
    }
    
    //MARK:--动态详情代理
    func refreshDynamicList()
    {
        _dynamicView.currentPage = 1
        _dynamicView.baseListArr.removeAllObjects()
        _dynamicView.queryListData()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
