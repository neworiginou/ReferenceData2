//
//  HWScdHouAppointListView.swift
//  Partner-Swift
//
//  Created by niedi on 15/3/10.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：二手房房源方 预约人次列表 mainview
//
//  修改记录：
//      姓名         日期               修改内容
//      聂迪      2015-02-26           UI、数据请求及功能逻辑实现
//

import UIKit

class HWScdHouAppointListView: HWBaseRefreshView, scdHouAppointListCellDelegate, UIAlertViewDelegate
{
    //MARK: 成员变量
    var _houseId: String! = ""
    var isPutDown: Bool! = false
    
    var countLab: UILabel!
    var unLockModel: HWScdHouAppointListModel!
    
    //MARK: init
    init(frame: CGRect, houseId: String, putDownStatus: Bool)
    {
        super.init(frame: frame)
        
        _houseId = houseId
        isPutDown = putDownStatus
        
        self.initTableViewHeaderView()
        self.initTableViewFootView()
        
        self.queryListData()
    }
    
    //MARK: 数据请求
    override func queryListData()
    {
        /*URL：/myStore/appointList.do
        入参：
        key:*** --用户key
        id：*** --二手房ID，
        pageSize：*** --每页条数,
        pageNumber：*** --页数
        出参：
        {
        "detail": "请求数据成功!",
        "status": "1",
        "data": [
        { "id": null, "brokerId": null, "villageName": null, "doorNum": null, "secHouseId": null, "operationType": null, "pendingState": null, "appointmentTime": null, "brokerName": "15851067818", "brokerPhone": "15851067818", "message": null, "appointmentContent": "2015年02月09日 17:24 hello", "createTime": null, "isLock": "no", "integral": 10 }
        
        ],
        "pageSize": 20,
        "pageNumber": 1,
        "totalSize": 2,
        "totalPage": 1
        }*/
        
        Utility.hideMBProgress(self)
        Utility.showMBProgress(self, _message: "请求数据")
        
        let manager = HWHttpRequestOperationManager.baseManager()
        var param = NSMutableDictionary()
        
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param.setPObject("\(currentPage)", forKey: "pageNumber")
        param.setPObject("\(kPageCount)", forKey: "pageSize")
        param.setPObject(_houseId, forKey: "id")
        
        manager.postHttpRequest(kScdHouAppointList, parameters: param, queue: nil, success: { (responseObject) -> Void in
            
            Utility.hideMBProgress(self)
            var dataArr: NSArray = responseObject.arrayObjectForKey("data")
            var tmpArr = NSMutableArray()
            for var i = 0; i < dataArr.count; i++
            {
                var dict: NSDictionary = dataArr.pObjectAtIndex(i) as NSDictionary
                var model = HWScdHouAppointListModel()
                model.initWitDict(dict)
                tmpArr.addObject(model)
            }
            
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
            
            self.baseTable.reloadData()
            self.doneLoadingTableViewData()
            if(self.baseListArr.count == 0)
            {
                self.showEmptyView("当前预约列表为空")
            }
            else
            {
                
                self.hideEmptyView()
            }
            
            if(self.isLastPage == true && self.baseListArr.count != 0)
            {
                self.countLab.text = "共 \(self.baseListArr.count) 人次预约"
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
    
    
    //MARK: scdHouAppointListCellDelegate
    func unLockClick(model: HWScdHouAppointListModel)
    {
        unLockModel = model
        var alertView = UIAlertView(title: "积分预约", message: "解锁经纪人联系方式\n消费：\(unLockModel.integral)个积分", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "确认")
        alertView.show()
    }
    
    //MARK: UIAlertViewDelegate
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int)
    {
        if(buttonIndex == 1)
        {
            /*URL:myStore/unLock.do
            入参：
            key:*** --用户key
            id：*** --动态id
            integral:*** --解锁应扣积分
            出参：
            { "detail": "请求数据成功!", "status": "1", "data": "操作成功" } */
            
            Utility.hideMBProgress(self)
            Utility.showMBProgress(self, _message: "请求数据")
            
            let manager = HWHttpRequestOperationManager.baseManager()
            var param = NSMutableDictionary()
            
            param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
            param.setPObject(unLockModel.modelId, forKey: "id")
            param.setPObject(unLockModel.integral, forKey: "integral")
            
            manager.postHttpRequest(kScdHouAppointListUnLockCustom, parameters: param, queue: nil, success: { (responseObject) -> Void in
                
                Utility.hideMBProgress(self)
                Utility.showToastWithMessage("解锁成功", _view: self)
                self.refreshData()
                
                }) { (code, error) -> Void in
                    
                    Utility.hideMBProgress(self)
                    Utility.showToastWithMessage(error, _view: self)
            }
        }
    }
    
    //MARK: tableView Header/Footer
    func initTableViewHeaderView()
    {
        var headerView = UIView(frame: CGRectMake(0, 0, kScreenWidth, 10))
        headerView.addSubview(Utility.drawLine(CGPointMake(0, 10 - lineHeight), width: kScreenWidth))
        baseTable.tableHeaderView = headerView
    }
    
    /**
    *	@brief	添加tableView footView
    *
    *	@return
    */
    
    func initTableViewFootView()
    {
        var footView = UIView(frame: CGRectMake(0, 0, kScreenWidth, 30))
        
        countLab = UILabel(frame: CGRectMake(0, 0, kScreenWidth, 25))
        countLab.font = Define.font(TF_14)
        countLab.textColor = CD_Txt_Color_99
        countLab.textAlignment = NSTextAlignment.Center
        footView.addSubview(countLab)
        
        baseTable.tableFooterView = footView
    }
    
    //MARK: tableView Delegate
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return baseListArr.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cellId = "cellID"
        var cell: HWScdHouAppointListCell? = tableView.dequeueReusableCellWithIdentifier(cellId) as? HWScdHouAppointListCell
        if(cell == nil)
        {
            cell = HWScdHouAppointListCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellId)
        }
        cell?.delegate = self
        var tmpModel = baseListArr[indexPath.row] as HWScdHouAppointListModel
        cell?.setContent(tmpModel, isPutDown: isPutDown)
        
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        var tmpModel = baseListArr[indexPath.row] as HWScdHouAppointListModel
        return HWScdHouAppointListCell.getCellHeight(tmpModel)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


