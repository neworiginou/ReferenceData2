//
//  HWScdHouVillageChoiceView.swift
//  Partner-Swift
//
//  Created by niedi on 15/3/4.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：二手房房源发布-选择小区 mainview
//
//  修改记录：
//      姓名         日期               修改内容
//      聂迪      2015-02-26           UI、数据请求及功能逻辑实现
//

import UIKit

protocol HWVillageChoiceDelegate: NSObjectProtocol
{
    func cellClickForChoiceVillage(model: HWScdHouVillageChoiceModel)
}


class HWScdHouVillageChoiceView: HWBaseRefreshView, HWSearchViewModelDelegate
{
    var searchBar: HWSearchViewModel!
    weak var delegate: HWVillageChoiceDelegate!
    
    var _model: HWScdHouVillageChoiceModel!
    var _isSearching: Bool! = false
    var SearchingStr: String! = ""
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        self.initTableHeadView()
        
        self.queryListData()
    }
    
    //MARK: 请求小区列表
    override func queryListData()
    {
        Utility.hideMBProgress(self)
        Utility.showMBProgress(self, _message: "请求数据")
        
        let manager = HWHttpRequestOperationManager.baseManager()
        var param = NSMutableDictionary()
        var url: NSString! = ""
        
        if(_isSearching == false)   //根据定位确定小区
        {
            /*url：/sys/searchByLngLat.do
            入参：
            private Double longitude;//经度
            private Double latitude; //纬度
            
            返回参数：
            {
            "detail": "",
            "status": "",
            "data": {
            "content": [
            { "villageId":"", -小区ID "villageName":"", - 小区名称 "villageAddress":"", - 小区地址 "distance":"", - 距离(米) "longitude":"", - 位置经度 "latitude":"" - 位置纬度 "cityId":"" - 城市ID } */
            
            param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
            if(DebugFlagForNieDi == true)
            {
                param.setPObject("\(121.440388)", forKey: "longitude")
                param.setPObject("\(31.344043)", forKey: "latitude")
            }
            else
            {
                var location: CLLocationCoordinate2D? = HWLocationManager.shareManager().coordinate
                if(location == nil)
                {
                    Utility.hideMBProgress(self)
                    Utility.showToastWithMessage("定位失败，稍后重试", _view: self)
                    return
                }
                param.setPObject("\(location!.longitude)", forKey: "longitude")
                param.setPObject("\(location!.latitude)", forKey: "latitude")
            }
            url = kScdHouVillageChoiceListForLocation
        }
        else        //根据搜索内容确定小区
        {
            /*url：/sys/getVillageList.do
            入参：
            villageName; //小区名称
            
            返回参数：
            {
            "detail": "",
            "status": "",
            "data": {
            "content": [
            { "villageId":"", -小区ID "villageName":"", - 小区名称 "villageAddress":"", - 小区地址 "distance":"", - 距离(米) "longitude":"", - 位置经度 "latitude":"" - 位置纬度 "cityId":"" - 城市ID } */
            
            param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
            param.setPObject("\(SearchingStr)", forKey: "villageName")
            url = kScdHouVillageChoiceListForSearch
        }
        
        manager.postHttpRequest(url, parameters: param, queue: nil, success: { (responseObject) -> Void in
            
            Utility.hideMBProgress(self)
            var dataArr: NSArray = responseObject.arrayObjectForKey("data")
            var tmpArr = NSMutableArray()
            for var i = 0; i < dataArr.count; i++
            {
                var dict: NSDictionary = dataArr.pObjectAtIndex(i) as NSDictionary
                var model = HWScdHouVillageChoiceModel(dict: dict)
                tmpArr.addObject(model)
            }
            
//            if(tmpArr.count < kPageCount)
//            {
//                self.isLastPage = true
//            }
//            else
//            {
//                self.isLastPage = false
//            }
//            
//            if(self.currentPage == 1)
//            {
//                self.baseListArr = NSMutableArray(array: tmpArr)
//            }
//            else
//            {
//                self.baseListArr.addObjectsFromArray(tmpArr)
//            }
            self.baseListArr = NSMutableArray(array: tmpArr)
            
            self.baseTable.reloadData()
            self.doneLoadingTableViewData()
            if(self.baseListArr.count == 0)
            {
                self.showEmptyView("没找到小区", offset: 70)
            }
            else
            {
                self.hideEmptyView()
            }
            
            }) { (code, error) -> Void in
                
                Utility.hideMBProgress(self)
                self.doneLoadingTableViewData()
                
                if(self.baseListArr.count == 0 && code.integerValue == kStatusFailure)
                {
                    self.showNetworkErrorView(kFailureDetail)
                }
                else
                {
                    Utility.showToastWithMessage(error, _view: self)
                }
        }
    }
    
    private func initTableHeadView()
    {
        var headBackView: UIView! = UIView(frame: CGRectMake(0, 0, kScreenWidth, 70))
        headBackView.backgroundColor = CD_BackGroundColor
        headBackView.drawBottomLine()
        
        //搜索栏
        searchBar = HWSearchViewModel(delegate: self,type:"0")
        searchBar.hidden = false
        headBackView.addSubview(searchBar)
        
        var titleLab: UILabel! = UILabel(frame: CGRectMake(15, searchBar.frame.maxY + 5, kScreenWidth - 2 * 15, 15))
        titleLab.font = Define.font(TF_13)
        titleLab.textColor = CD_Txt_Color_99
        titleLab.text = "附近小区"
        headBackView.addSubview(titleLab)
        
        baseTable.tableHeaderView = headBackView
    }
    
    //MARK: HWSearchViewModelDelegate
    func didSelectedSearchTitle(title: String!)
    {
        SearchingStr = title
        if(countElements(title) == 0)
        {
            _isSearching = false
        }
        else
        {
            _isSearching = true
        }
        self.queryListData()
    }
    
    func didBeginEditing()
    {
        
    }
    
    func didEndEditing()
    {
        
    }
    
    func didSelectedSearchBtn()
    {
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return baseListArr.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cellID = "cellId"
        var cell: HWScdHouVillageChoiceCell? = tableView.dequeueReusableCellWithIdentifier(cellID) as? HWScdHouVillageChoiceCell
        if(cell == nil)
        {
            cell = HWScdHouVillageChoiceCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellID)
        }
        
        var model: HWScdHouVillageChoiceModel = baseListArr[indexPath.row] as HWScdHouVillageChoiceModel
//        if _isSearching == false
//        {
//            cell?.distanceLab.text = "\(model.distance!)m"
//        }
//        else
//        {
//              //cell?.distanceLab.text = "\(model.distance!)"
//        }
        cell?.setContentForModel(model)
        cell?.contentView.drawBottomLine()
        
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return HWScdHouVillageChoiceCell.getCellHeight()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        NSNotificationCenter.defaultCenter().removeObserver(searchBar)
        
        var model: HWScdHouVillageChoiceModel = baseListArr[indexPath.row] as HWScdHouVillageChoiceModel
        delegate.cellClickForChoiceVillage(model)
    }
    
    
    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    

}
