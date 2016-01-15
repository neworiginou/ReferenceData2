//
//  HWServiceCustomerView.swift
//  Partner-Swift
//
//  Created by hw500027 on 15/2/12.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：服务首页-客户列表
//
//  修改记录：
//      姓名         日期              修改内容
//    陆晓波      2015-02-12           文件创建
//    陆晓波      2015-02-28           模拟数据
//    陆晓波      2015-03-13           接口调试
//    陆晓波      2015-03-17           UI调整
//    陆晓波      2015-03-18           添加缓存

import UIKit

protocol HWServiceCustomerViewDelegate:NSObjectProtocol
{
    func didSelectedServiceCustomerList(model:HWServiceCustomerModel)
}

class HWServiceCustomerView: HWBaseRefreshView {

    weak var customerListdelegate:HWServiceCustomerViewDelegate?
    var param:NSMutableDictionary = NSMutableDictionary()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        var headerView = UIView(frame: CGRectMake(0, -1, kScreenWidth, 0.5))
        headerView.drawBottomLine()
        self.baseTable.tableHeaderView = headerView
        
        self.baseTable.registerClass(HWServiceCustomerCell.self, forCellReuseIdentifier: "cell")
        self.loadCoreData()
        self.queryListData()
    }

    //读取缓存
    func loadCoreData()
    {
        var cache:NSMutableArray = NSMutableArray()
        cache = HWCoreDataManager.loadServiceCustomerList()
//        println("cache = \(cache)")
//        println("cacheCount=\(cache.count)")
        if (cache.count > 0)
        {
            for (var i = 0;i < cache.count;i++)
            {
                self.baseListArr.addObject(cache.pObjectAtIndex(i)!)
            }
            self.baseTable.reloadData()
        }
    }
    
    override func queryListData()
    {
        //加载服务-客户列表
        Utility.hideMBProgress(self)
        Utility.showMBProgress(self, _message: "请求数据")
        
        let manager = HWHttpRequestOperationManager.baseManager()
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param.setPObject("\(currentPage)", forKey: "pageNumber")
        param.setPObject("\(kPageCount)", forKey: "pageSize")
        
        manager.postHttpRequest(kChanceList, parameters: param, queue: nil, success:
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
                    //同步数据库
                    HWCoreDataManager.saveServiceCustomerList(dataArray)
                    
                    self.baseListArr.removeAllObjects()
                }
                
                for dica in dataArray
                {
                    let model = HWServiceCustomerModel(dic: dica as NSDictionary)
                    self.baseListArr.addObject(model)
                }
                
                self.baseTable.reloadData()
                self.doneLoadingTableViewData()
                if (self.baseListArr.count == 0)
                {
                    self.showEmptyView("暂无客户")
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
                    Utility.showToastWithMessage(error, _view: self)
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
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as HWServiceCustomerCell
        cell.fillWithData(self.baseListArr.pObjectAtIndex(indexPath.row) as HWServiceCustomerModel)
        
        if (indexPath.section == 0 && indexPath.row == 0)
        {
            let topLine = UIView(frame: CGRectMake(0, -0.5, kScreenWidth, 0.5))
            topLine.backgroundColor = CD_LineColor
            cell.addSubview(topLine)
        }
        
        cell.contentView.drawBottomLine()
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 80 * kRate
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        customerListdelegate?.didSelectedServiceCustomerList(self.baseListArr.pObjectAtIndex(indexPath.row) as HWServiceCustomerModel)
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
