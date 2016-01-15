//
//  HWMainMsgListView.swift
//  Partner-Swift
//
//  Created by hw500029 on 15/8/15.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

protocol HWMainMsgListViewDelegate: NSObjectProtocol
{
    func didSelectMessageList(message: HWMainMsgListModel)
}

class HWMainMsgListView: HWBaseRefreshView {

    var delegate: HWMainMsgListViewDelegate?
    
    override init(frame: CGRect)
    {
        super.init(frame:frame)
        self.setIsNeedHeadRefresh(true)
        self.isLastPage = true
        self.baseTable.registerClass(HWMessageListCell.self, forCellReuseIdentifier: HWMessageListCell.getIdentify())
        self.queryListData()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "queryListData", name:"reloadMsgListView", object: nil)
    }
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "reloadMsgListView", object: nil)
    }
    
    override func queryListData()
    {
        Utility.showMBProgress(self, _message: "加载中")
        
        let manager = HWHttpRequestOperationManager.baseManager()
        var param: NSMutableDictionary = NSMutableDictionary()
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
//        param.setPObject("\(currentPage)", forKey: "pageNumber")
//        param.setPObject("\(kPageCount)", forKey: "pageSize")
        
        //        println(param)
        
        manager.postHttpRequest(kMainMsgList, parameters: param, queue: nil, success: { (responseObject) -> Void in
            
            Utility.hideMBProgress(self)
            
            var dict: NSDictionary = responseObject as NSDictionary
            var dataArr: NSArray = dict.arrayObjectForKey("data")
            
            self.baseListArr.removeAllObjects()
            
            if (dataArr.count == 0)
            {
                self.showEmptyView("无消息")
            }
            else
            {
                self.hideEmptyView()
            }
            
            for var i = 0; i < dataArr.count; i++
            {
                var message = HWMainMsgListModel(msgInfoDic: dataArr.objectAtIndex(i) as NSDictionary)
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
                    self.showNetworkErrorView("网络未连接")
                    Utility.showToastWithMessage(error, _view: self)
                }
        }

    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        //return HWMessageListCell.getCellHeight()
        return 85
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.baseListArr.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let message: HWMainMsgListModel = self.baseListArr.pObjectAtIndex(indexPath.row) as HWMainMsgListModel
        
        let cell = tableView.dequeueReusableCellWithIdentifier(HWMessageListCell.getIdentify(), forIndexPath: indexPath) as HWMessageListCell

        cell.setMessageWithModel(message)
        
        cell.contentView.drawBottomLine()
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let message: HWMainMsgListModel = self.baseListArr.pObjectAtIndex(indexPath.row) as HWMainMsgListModel
        
        // 设置为已读
        //message.read = "1"
        self.baseTable.reloadData()
        
        if (delegate != nil && delegate?.respondsToSelector("didSelectMessageList:") == true)
        {
            delegate?.didSelectMessageList(message)
        }
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    
    
}
