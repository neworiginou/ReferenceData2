//
//  HWMyCollectionView.swift
//  Partner-Swift
//
//  Created by hw500027 on 15/3/3.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：我的房店-我的收藏列表
//
//  修改记录：
//      姓名         日期              修改内容
//    陆晓波      2015-03-03           文件创建
//    陆晓波      2015-03-06           添加代理

import UIKit

protocol HWMyCollectionViewDelegate:NSObjectProtocol
{
    func didSelectedCollection(model:HWMyCollectionModel)
}

class HWMyCollectionView: HWBaseRefreshView
{
    weak var collectionViewDelegate:HWMyCollectionViewDelegate?
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        var headerView = UIView(frame: CGRectMake(0, 0, kScreenWidth, 10 * kRate))
        headerView.drawBottomLine()
        self.baseTable.tableHeaderView = headerView
        
        self.baseTable.registerClass(HWScdHouseCell.self, forCellReuseIdentifier: "cell")
        self.queryListData()
    }

    override func queryListData()
    {
        //加载列表
        var dict = NSMutableDictionary()
        
        for i in 0...4
        {
            dict.setPObject("title\(i)", forKey: "title")
            dict.setPObject("区域名字\(i)", forKey: "areaName")
            dict.setPObject("板块名\(i)", forKey: "plateName")
            dict.setPObject("\(i+100)", forKey: "price")
            dict.setPObject("\(i+90)", forKey: "proportion")
            dict.setPObject("3", forKey: "roomCount")
            dict.setPObject("\(i+1)", forKey: "hallCount")
            dict.setPObject("\(i+10)", forKey: "collectNum")
            dict.setPObject("", forKey: "picKey")
            
            //let model = HWMyCollectionModel(dict: dict as NSDictionary)
            //self.baseListArr.addObject(model)
        }
        /*
        "areaId":"" -区域ID
        "areaName":"" -区域名字
        "plateId":"" -板块ID
        "plateName":"" -板块名
        "price":"" -价格
        "proportion":"" -面积
        "roomCount":"" -几室
        "scdHandHousesId ":"" -二手房id
        "brokerId":"" -经纪人id
        "villageId":"" -小区id
        "villageName":"" -小区名称
        "title":"" -标题
        "cityId":"" -城市ID
        "hallCount":"" -几厅
        "roomType":"" -户型
        "toiletCount":"" -卫生间
        "picKey":"" -图片key
        "collectNum":"" -关注人数
        */
        
        Utility.hideMBProgress(self)
        Utility.showMBProgress(self, _message: "请求数据")
        
        //加载收藏列表
        let manager = HWHttpRequestOperationManager.baseManager()
        var param = NSMutableDictionary()
        
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param.setPObject("\(currentPage)", forKey: "pageNumber")
        param.setPObject("\(kPageCount)", forKey: "pageSize")
        
        //MYP add v3.2.1收藏列表接口Url由kMyCollection改为kMyCollectionList（包含新房和二手房）
        manager.postHttpRequest(kMyCollectionList, parameters: param, queue: nil, success:
            { (responseObject) -> Void in
                Utility.hideMBProgress(self)
                var dataArray : NSArray = responseObject.arrayObjectForKey("data")
                if (dataArray.count < kPageCount)
                {
                    self.isLastPage = true
                }
                else
                {
                    self.isLastPage = false
                }
                if (self.currentPage == 1)
                {
                    self.baseListArr.removeAllObjects()
                }
                for dica in dataArray
                {
                    let model = HWMyCollectionModel(dict: dica as NSDictionary)
                    self.baseListArr.addObject(model)
                }
                self.baseTable.reloadData()
                self.doneLoadingTableViewData()
                if (self.baseListArr.count == 0)
                {
                    self.showEmptyView("暂无收藏")
                }
                else
                {
                    self.hideEmptyView()
                }
            })
            { (code, error) -> Void in
                Utility.hideMBProgress(self)
                self.doneLoadingTableViewData()
                if (self.baseListArr.count == 0 && code.integerValue == kStatusFailure)
                {
                    self.showNetworkErrorView(kFailureDetail)
                }
                else
                {
                    self.showEmptyView(error)
                }
        }
    }
    
    //MARK:--tableView delegate
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.baseListArr.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
            var model:HWMyCollectionModel = self.baseListArr.pObjectAtIndex(indexPath.row) as HWMyCollectionModel
            let newCellId = "cellNew"
            let scdCellId = "cellScd"
            if model.isNewHouse == "1"
            {
                
                var cell:HWNewCell? = tableView.dequeueReusableCellWithIdentifier(newCellId) as? HWNewCell
                //var cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as HWNewCell
                if cell == Optional.None
                {
                    cell = HWNewCell(style: UITableViewCellStyle.Default, reuseIdentifier: newCellId,cellType:"1")
                }
                cell?.setMyCollectionInfo(model)
                cell?.contentView.drawBottomLine()
                return cell!
            }
            else
            {
                var cell:HWScdHouseCell? = tableView.dequeueReusableCellWithIdentifier(scdCellId) as? HWScdHouseCell
                //var cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as HWScdHouseCell
                if cell == Optional.None
                {
                    cell = HWScdHouseCell(style: UITableViewCellStyle.Default, reuseIdentifier: scdCellId)
                }
                cell?.setMyCollectionInfo(model)
                cell?.contentView.drawBottomLine()
                return cell!
            }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 95 * kRate
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        collectionViewDelegate?.didSelectedCollection(self.baseListArr.pObjectAtIndex(indexPath.row) as HWMyCollectionModel)
    }
    
    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
