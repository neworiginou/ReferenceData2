//
//  HWHasBaoBeiView.swift
//  Partner-Swift
//
//  Created by niedi on 15/3/28.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWHasBaoBeiView: HWBaseRefreshView
{
    var _houseId : NSString! = ""
    
    init(frame: CGRect, houseId: NSString)
    {
        super.init(frame: frame)
        
        _houseId = houseId
        self.queryListData()
    }
    
    override func queryListData() {
        
        Utility.hideMBProgress(self)
        Utility.showMBProgress(self, _message: "数据请求中")
        
        let manager = HWHttpRequestOperationManager.baseManager()
        var param = NSMutableDictionary()
        
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param.setPObject("\(currentPage)", forKey: "pageNumber")
        param.setPObject("\(kPageCount)", forKey: "pageSize")
        param.setPObject("\(_houseId)", forKey: "projectId")
        
        manager.postHttpRequest(kGetBaoBei, parameters: param, queue: nil, success: { (responseObject) -> Void in
            
            Utility.hideMBProgress(self)
            
            var dataArr: NSArray = responseObject.arrayObjectForKey("data")
            var tmpArr = NSMutableArray()
            for var i = 0; i < dataArr.count; i++
            {
                let dict = dataArr[i] as NSDictionary
                var model: HasBaoBeiModel = HasBaoBeiModel(dict: dict)
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
                self.showEmptyView("无数据")
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
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return  self.baseListArr.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 80.0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cellIdentifier : String = "cell"
        var cell : HasBaoBeiCell? = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? HasBaoBeiCell
        if cell == nil
        {
            cell = HasBaoBeiCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
        }
        cell?.fill(self.baseListArr[indexPath.row] as HasBaoBeiModel)
        cell?.contentView.drawBottomLine()
        return cell!
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
