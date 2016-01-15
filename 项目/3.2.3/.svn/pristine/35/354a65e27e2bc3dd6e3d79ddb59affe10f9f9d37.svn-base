//
//  HWScdHouseView.swift
//  Partner-Swift
//
//  Created by niedi on 15/2/26.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：二手房首页列表 tableView
//
//  修改记录：
//      姓名         日期               修改内容
//      聂迪      2015-02-26           UI、数据请求及功能逻辑实现
//


import UIKit

//MARK: cell点击事件 跳转房源详情页面
protocol HWScdHouseViewDelegate: NSObjectProtocol
{
    func pushVC(VC: HWBaseViewController)
}

class HWScdHouseView: HWBaseRefreshView
{
    
    //MARK: 成员变量
    weak var delegate: HWScdHouseViewDelegate?
    var cityName: String! = HWUserLogin.currentUserLogin().cityName
    var scdHouCount: String! = "0"
    var _areaId: String! = ""
    var _plateId: String! = ""
    var priceIndex: String! = ""
    var roomCountIndex: String! = ""
    var orderTypeIndex: String! = ""
    
    var isSaveToCoredata: Bool = true
    var titleLab: UILabel! //"列表标题"
    
    //MARK: init
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        self.loadUI()
        
        let load_queue = dispatch_queue_create("com.bkd.org", DISPATCH_QUEUE_CONCURRENT);
        dispatch_async(load_queue, { () -> Void in
            var array: NSArray = HWCoreDataManager.readScdHouHomepageList()
            if (array.count > 0 && self.baseListArr.count == 0)
            {
                self.baseListArr = NSMutableArray(array: array)
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.baseTable.reloadData()
                    self.scdHouCount = "\(self.baseListArr.count)"
                    self.loadData()
                })
            }
            
        })
        
        self.queryListData()
    }
    

    //MARK: 筛选框代理事件
    func customerSearchView(customerSearchView: CustomSearchView!, passValue value: String!, withIndex index: String!) 
    {
        var priceIndexArr = ["", "1", "2", "3", "4", "5", "6", "7"] //(1:100万以下,2:100-150万,3:150-200万, 4:200-300万,5:300-500万,6:500-1000万,7:1000万以上)
        var roomCountIndexArr = ["", "1", "2", "3", "4", "5", "6"]//(1:一居 2:二居 3:三居 4:四居 5:五居 6:五居以上)
        var orderTypeIndexArr = ["", "1", "2", "3", "4", "5", "6"]//(1:房价降序 2:房价升序 3:均价降序 4:均价升序 5:面积降序 6:面积升序)
        if(index == "1")//价格
        {
            MobClick.event("SCDhouse-pricefilter_click")//maidian_3.0_niedi
            
            priceIndex = priceIndexArr[value.toInt()!]
        }
        else if(index == "2")//户型
        {
            MobClick.event("SCDhouse-typefilter_click")//maidian_3.0_niedi
            
            roomCountIndex = roomCountIndexArr[value.toInt()!]
        }
        else            //排序
        {
            MobClick.event("SCDhouse-sortfilter_click")//maidian_3.0_niedi
            
            orderTypeIndex = orderTypeIndexArr[value.toInt()!]
        }
        currentPage = 1
        self.queryListData()
    }
    
    func customerSearchView(customerSearchView: CustomSearchView!, passZone zoneId: String!, plateId: String!)
    {
        MobClick.event("SCDhouse-areafilter_click")//maidian_3.0_niedi
        
        _plateId = plateId
        _areaId = zoneId
        currentPage = 1
        if(customerSearchView.plateName == "区域")
        {
            self.cityName = HWUserLogin.currentUserLogin().cityName
        }
        else
        {
            self.cityName = customerSearchView.plateName
        }
        self.queryListData()
    }
    
    //MARK: 二手房筛选
    override func queryListData()
    {
        /*url:/MyHousesInfo/findScdHandHouses.do
        入参：
        pageSize
        pageNumber
        areaId:*** --区域ID
        plateId:*** --板块ID
        price:*** --价格(1:100万以下,2:100-150万,3:150-200万, 4:200-300万,5:300-500万,6:500-1000万,7:1000万以上)
        roomCount:*** --户型 (1:一居 2:二居 3:三居 4:四居 5:五居 6:五居以上)
        orderType:*** --排序(1:房价降序 2:房价升序 3:均价降序 4:均价升序 5:面积降序 6:面积升序)
        
        出参：
        {
        "detail": "请求数据成功!",
        "status": "1",
        "data": {
        "content": [
        { "areaId":"", -区域ID "areaName":"", -区域名字 "plateId":"", -板块ID "plateName":"", -板块名 "price":"", -价格 "proportion":"", -面积 "roomCount":"", -几室 "isAppoint":"", -是否已预约 0未预约 1已预约 "scdHandHousesId":"", -二手房id "brokerId":"", -经纪人id "villageId":"", -小区id "villageName":"", -小区名称 "title":"", -标题 "appointNum":"" -预约人数 "cityId":"", -城市ID "hallCount":"", -几厅 "roomType":"", -户型 "toiletCount":"", -卫生间 "picKey":"", -图片key "orderType":"", -排序 }
        
        ,
        { },
        { }
        ],
        "pageSize": ,
        "pageNumber": ,
        "totalSize": ,
        "totalPage":
        }
        */
        
        isSaveToCoredata = true
        
        Utility.hideMBProgress(self)
        
        let manager = HWHttpRequestOperationManager.baseManager()
        var param = NSMutableDictionary()
        
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param.setPObject("\(currentPage)", forKey: "pageNumber")
        param.setPObject("\(kPageCount)", forKey: "pageSize")
        if(_areaId != "")
        {
            isSaveToCoredata = false
            param.setPObject(_areaId, forKey: "areaId")
        }
        if(_plateId != "")
        {
            isSaveToCoredata = false
            param.setPObject(_plateId, forKey: "plateId")
        }
        if(priceIndex != "")
        {
            isSaveToCoredata = false
            param.setPObject(priceIndex, forKey: "price")
        }
        if(roomCountIndex != "")
        {
            isSaveToCoredata = false
            param.setPObject(roomCountIndex, forKey: "roomCount")
        }
        if(orderTypeIndex != "")
        {
            isSaveToCoredata = false
            param.setPObject(orderTypeIndex, forKey: "orderType")
        }
        
        manager.postHttpRequest(kScdHouHomePageList, parameters: param, queue: nil, success: { (responseObject) -> Void in
            
            var dataArr: NSArray = responseObject.arrayObjectForKey("data")
            var tmpArr = NSMutableArray()
            for var i = 0; i < dataArr.count; i++
            {
                var dict: NSDictionary = dataArr.pObjectAtIndex(i) as NSDictionary
                var model = HWScdHouseModel(dict: dict)
                tmpArr.addObject(model)
            }
            
            self.scdHouCount = responseObject.stringObjectForKey("totalSize")
            
            if(tmpArr.count < kPageCount)
            {
                self.isLastPage = true
            }
            else
            {
                self.isLastPage = false
            }
            
            if(self.currentPage == 1)
            {
                self.baseListArr = NSMutableArray(array: tmpArr)
            }
            else
            {
                self.baseListArr.addObjectsFromArray(tmpArr)
            }
            
            if(self.isSaveToCoredata == true && self.currentPage == 1)
            {
                let load_queue = dispatch_queue_create("com.bkd.org", DISPATCH_QUEUE_CONCURRENT);
                
                dispatch_async(load_queue, { () -> Void in
                    HWCoreDataManager.saveScdHouHomepageList(self.baseListArr)
                    return
                })
            }
            
            self.baseTable.reloadData()
            self.loadData()
            self.doneLoadingTableViewData()
            if(self.baseListArr.count == 0)
            {
                self.showEmptyView("无数据")
            }
            else
            {
                self.hideEmptyView()
            }
            
        }) { (code, error) -> Void in
            
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
    
    //MARKL: 表头数据
    func loadData()
    {
        titleLab.text = "\(HWUserLogin.currentUserLogin().cityName)二手房（\(self.scdHouCount)个）"
    }
    
    //MARK: LoadUI
    func loadUI()
    {
        var view: UIView = UIView(frame: CGRectMake(0, 0, kScreenWidth, 30 * kRate))
        view.backgroundColor = CD_BackGroundColor
        view.drawBottomLine()
        
        titleLab = UILabel(frame: CGRectMake(15 * kRate, 8 * kRate, kScreenWidth - 15 * 2 * kRate, 13 * kRate))
        titleLab.font = Define.font(TF_13)
        titleLab.textColor = CD_Txt_Color_99
        view.addSubview(titleLab)
        
        baseTable.tableHeaderView = view
    }
    
    //MARK: tableView代理
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return baseListArr.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cellId = "cellID"
        var cell: HWScdHouseCell? = tableView.dequeueReusableCellWithIdentifier(cellId) as? HWScdHouseCell
        if(cell == nil)
        {
            cell = HWScdHouseCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellId)
        }
        cell?.contentView.drawBottomLine()
        cell?.setSecondHouseInfo(baseListArr[indexPath.row] as HWScdHouseModel)
        
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return HWScdHouseCell.getCellHeight(baseListArr[indexPath.row] as? HWScdHouseModel)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        MobClick.event("SCDhousedetails_click")//maidian_3.0_niedi
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        var tmpModel = baseListArr[indexPath.row] as HWScdHouseModel
        
        var detailVC = HWScdHouseDetailVC()
        detailVC._houseId = tmpModel.scdHandHousesId
        delegate?.pushVC(detailVC)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
