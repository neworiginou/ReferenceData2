//
//  HWDynamicView.swift
//  Partner-Swift
//
//  Created by hw500027 on 15/3/3.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：我的房店-状态列表
//
//  修改记录：
//      姓名         日期              修改内容
//    陆晓波      2015-03-03           文件创建

import UIKit

protocol HWDynamicViewDelegate:NSObjectProtocol
{    
    func didSelectedDynamicList(model:HWDynamicModel)
    func refreshRedPointStatus(houseCount:NSString)
}

class HWDynamicView: HWBaseRefreshView,HWDynamicCellDelegate,UIAlertViewDelegate
{
    var dynamicViewDelegate:HWDynamicViewDelegate?
    
    var pendingArray:NSMutableArray! = NSMutableArray()
    var _id:NSString = ""
    var _integral:NSString = ""
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        var headerView = UIView(frame: CGRectMake(0, 0, kScreenWidth, 10 * kRate))
        headerView.drawBottomLine()
        self.baseTable.tableHeaderView = headerView
        
        self.baseTable.registerClass(HWDynamicCell.self, forCellReuseIdentifier: "cell")
        self.queryListData()
    }
    
    override func queryListData()
    {
        //加载动态列表
        Utility.hideMBProgress(self)
        Utility.showMBProgress(self, _message: "请求数据")
        
        let manager = HWHttpRequestOperationManager.baseManager()
        var param = NSMutableDictionary()
        
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param.setPObject("\(currentPage)", forKey: "pageNumber")
        param.setPObject("\(kPageCount)", forKey: "pageSize")
        
        manager.postHttpRequest(kDynamicList, parameters: param, queue: nil, success:
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
                    self.pendingArray = []
                }

                for var i = 0 ; i<dataArray.count ; i++
                {
                    var arrayIndex = i + (self.currentPage - 1)*10
                    var dic: NSDictionary = dataArray.pObjectAtIndex(i) as NSDictionary
                    var model = HWDynamicModel(dict: dic as NSDictionary)
                    self.baseListArr.addObject(model)
                    //未读信息 跳转判断
                    if (model.isRead == "unread")
                    {
                        self.pendingArray.addObject(arrayIndex)
                    }
                }
                self.baseTable.reloadData()
                self.doneLoadingTableViewData()
                if (self.baseListArr.count == 0)
                {
                    self.showEmptyView("暂无状态")
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
        
        //获取title红点数量
        let manager1 = HWHttpRequestOperationManager.baseManager()
        var param1:NSMutableDictionary = NSMutableDictionary();
        param1.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key");
        manager1.postHttpRequest(kHomeAgentInfo, parameters: param1, queue: nil, success: { (responseObject) -> Void in
            var dic =  responseObject.objectForKey("data") as NSDictionary
            
            self.dynamicViewDelegate?.refreshRedPointStatus(dic.stringObjectForKey("remindHouseStoreNum"))
            }) { (code, error) -> Void in
                
        }
    }
    
    //MARK:--tableView delegate
     override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.baseListArr.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as HWDynamicCell
        cell.dynamicCellDelegate = self
        if (self.baseListArr.count > 0)
        {
            cell.fillData(self.baseListArr.pObjectAtIndex(indexPath.row) as HWDynamicModel)
        }
        cell.contentView.drawBottomLine()
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 90 * kRate
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        dynamicViewDelegate?.didSelectedDynamicList(self.baseListArr.pObjectAtIndex(indexPath.row) as HWDynamicModel)
    }
    
    //MARK:--cell代理
    func didUnlockBtn(id: NSString, integral: NSString)
    {
        _id = id
        _integral = integral
        var alert = UIAlertView(title: "积分解锁", message: "解锁经纪人联系方式\n消费：\(integral)积分", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "确认")
        alert.show()
    }
    
    //MARK:--UIAlertView代理
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int)
    {
        if(buttonIndex == 1)
        {
            self.toUnlockManager()
        }
    }
    
    //按确认解锁
    func toUnlockManager()
    {
        Utility.showMBProgress(self, _message: "请求中")
        let manager = HWHttpRequestOperationManager.baseManager()
        
        var param = NSMutableDictionary()
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param.setPObject("\(_id)", forKey: "id")
        param.setPObject("\(_integral)", forKey: "integral")
        
        manager.postHttpRequest(kUnlockManager, parameters: param, queue: nil, success:
            { (responseObject) -> Void in
                Utility.hideMBProgress(self)
                
                //解锁成功
                if (responseObject.stringObjectForKey("status") == "1")
                {
                    Utility.showToastWithMessage(responseObject.stringObjectForKey("data"), _view: self)
                    sleep(1)
                    self.currentPage = 1
                    self.baseListArr.removeAllObjects()
                    self.queryListData()
                }
                    //解锁失败
                else
                {
                    Utility.showAlertWithMessage(responseObject.stringObjectForKey("detail"))
                }
                
            }, failure:
            { (code, error) -> Void in
                Utility.hideMBProgress(self)
                Utility.showToastWithMessage(error, _view: self)
        })
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
