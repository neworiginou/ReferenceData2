//
//  HWServiceCustomerSearchView.swift
//  Partner-Swift
//
//  Created by hw500027 on 15/2/25.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：服务首页-搜索栏蒙版
//
//  修改记录：
//      姓名         日期              修改内容
//    陆晓波      2015-02-25           文件创建
//    陆晓波      2015-03-12           接口调试
//    陆晓波      2015-03-17           UI调整
//

import UIKit

protocol HWServiceCustomerSearchViewDelegate:NSObjectProtocol
{
    func didSelectedSearchView(model:HWServiceCustomerModel)
}

class HWServiceCustomerSearchView: HWBaseRefreshView {

    var _searchKey:NSString = ""
    weak var customerSearchViewDelegate:HWServiceCustomerSearchViewDelegate?
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.baseTable.registerClass(HWServiceCustomerCell.self, forCellReuseIdentifier: "cell")

        self.baseTable.tableHeaderView = Utility.drawLine(CGPointMake(0, -0.5), width: kScreenWidth)
    }

    override func queryListData()
    {
        //加载服务-客户列表
        Utility.hideMBProgress(self)
        Utility.showMBProgress(self, _message: "请求数据")
        
        let manager = HWHttpRequestOperationManager.baseManager()
        var param = NSMutableDictionary()
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param.setPObject("\(currentPage)", forKey: "pageNumber")
        param.setPObject("\(kPageCount)", forKey: "pageSize")
        param.setPObject("\(_searchKey)", forKey: "searchKeyword")
        
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
        if (self.baseListArr.count > 0)
        {
            cell.fillWithData(self.baseListArr.pObjectAtIndex(indexPath.row) as HWServiceCustomerModel)
        }
        cell.contentView.drawBottomLine()
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 80
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        customerSearchViewDelegate?.didSelectedSearchView(self.baseListArr.pObjectAtIndex(indexPath.row) as HWServiceCustomerModel)
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
