//
//  HWMessageListRefreshView.swift
//  Partner-Swift
//
//  Created by caijingpeng.haowu on 15/3/4.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

protocol HWMessageListRefreshViewDelegate: NSObjectProtocol
{
    func didSelectMessageList(message: HWMessageListModel)
}

class HWMessageListRefreshView: HWBaseRefreshView {
    
    var delegate: HWMessageListRefreshViewDelegate?
    //MYP add v3.2.3
    var url = "" //数据请求的url
    
    init(frame: CGRect,urlString: String)
    {
        super.init(frame: frame)
        self.setIsNeedHeadRefresh(true)
        //MYP add v3.2.3
        self.url = urlString
        
        self.baseTable.registerClass(HWMessageListCell.self, forCellReuseIdentifier: HWMessageListCell.getIdentify())
        //self.baseTable.reloadData()
        NSNotificationCenter .defaultCenter() .addObserver(self, selector: "queryListData", name: "refershMessageList", object: nil);
        
        //MYP add v3.2.3
        self.queryListData()
    }
    
//    override func drawRect(rect: CGRect)
//    {
//        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//        dispatch_after(1, queue) { () -> Void in
//            self.queryListData()
//        }
//    }

    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func queryListData() {
        
        /*
            login/getMsgList.do
        */
        
        Utility.showMBProgress(self, _message: "加载中")

        let manager = HWHttpRequestOperationManager.baseManager()
        var param: NSMutableDictionary = NSMutableDictionary()
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param.setPObject("\(currentPage)", forKey: "pageNumber")
        param.setPObject("\(kPageCount)", forKey: "pageSize")
        
//        println(param)
        
        manager.postHttpRequest(url, parameters: param, queue: nil, success: { (responseObject) -> Void in
        
            Utility.hideMBProgress(self)
            var dict: NSDictionary = responseObject as NSDictionary
            var dataArr: NSArray = dict.arrayObjectForKey("data")
            
            if dataArr.count < kPageCount
            {
                self.isLastPage = true
            } 
            else
            {
                self.isLastPage = false
            }
            
            if self.currentPage == 1
            {
                self.baseListArr.removeAllObjects()
            }
            
            if (dataArr.count == 0 && self.currentPage == 1)
            {
                self.baseListArr.removeAllObjects()
                self.showEmptyView("无消息")
            }
            else
            {
                self.hideEmptyView()
            }
            
            for var i = 0; i < dataArr.count; i++
            {
                var message = HWMessageListModel(messageInfo: dataArr.objectAtIndex(i) as NSDictionary)
                self.baseListArr.addObject(message)
            }
            
            self.baseTable.reloadData()
            self.doneLoadingTableViewData()
            
            
            }) { (code, error) -> Void in
//                println(code + error)
                Utility.hideMBProgress(self)
                if (code.integerValue == kStatusFailure && self.baseListArr.count == 0)
                {
                    self.showNetworkErrorView("网络未连接")
                }
                else
                {
                    Utility.showToastWithMessage(error, _view: self)
                }
        }
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return HWMessageListCell.getCellHeight()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.baseListArr.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let message: HWMessageListModel = self.baseListArr.pObjectAtIndex(indexPath.row) as HWMessageListModel
        
        let cell = tableView.dequeueReusableCellWithIdentifier(HWMessageListCell.getIdentify(), forIndexPath: indexPath) as HWMessageListCell
        cell.setMessageModel(message)
        
        cell.contentView.drawBottomLine()
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let message: HWMessageListModel = self.baseListArr.pObjectAtIndex(indexPath.row) as HWMessageListModel
        
        // 设置为已读
        message.readed = "1"
        self.baseTable.reloadData()
        
        if (delegate != nil && delegate?.respondsToSelector("didSelectMessageList:") == true)
        {
            delegate?.didSelectMessageList(message)
        }
    }
}
