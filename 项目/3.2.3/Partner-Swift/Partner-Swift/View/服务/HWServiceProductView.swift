//
//  HWServiceProductView.swift
//  Partner-Swift
//
//  Created by hw500027 on 15/2/3.
//  Copyright (c) 2015年 luxiaobo. All rights reserved.
//
//  功能描述：服务首页-服务产品列表
//
//  修改记录：
//      姓名         日期              修改内容
//    陆晓波      2015-02-12           文件创建
//

import UIKit

protocol HWServiceProductViewDelegate:NSObjectProtocol
{
    func didSelectedServiceProductList(model:HWServiceProductModel)
    func passProductListCount(productListCount:NSInteger)
}

class HWServiceProductView: HWBaseRefreshView
{
    weak var serviceProductViewDelegate:HWServiceProductViewDelegate?
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        //self.setIsNeedHeadRefresh(false)
        
        var headerView = UIView(frame: CGRectMake(0, 0, kScreenWidth, 10 * kRate))
        headerView.drawBottomLine()
        self.baseTable.tableHeaderView = headerView

        self.baseTable.registerClass(HWServiewProductCell.self, forCellReuseIdentifier: "cell")
        self.queryListData()
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
        
        manager.postHttpRequest(kServiceProductList, parameters: param, queue: nil, success:
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
                    let model = HWServiceProductModel(dic: dica as NSDictionary)
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
                self.serviceProductViewDelegate?.passProductListCount(self.baseListArr.count)
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
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 80 * kRate
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.baseListArr.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as HWServiewProductCell
        cell.fillWithData(self.baseListArr.pObjectAtIndex(indexPath.row) as HWServiceProductModel)
        cell.contentView.drawBottomLine()
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        serviceProductViewDelegate?.didSelectedServiceProductList(self.baseListArr.pObjectAtIndex(indexPath.row) as HWServiceProductModel)
    }
    
    required init(coder aDecoder: NSCoder) {
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
