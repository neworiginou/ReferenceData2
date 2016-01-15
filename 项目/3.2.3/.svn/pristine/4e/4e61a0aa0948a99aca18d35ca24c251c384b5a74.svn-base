//
//  HWRedPaperRefreshView.swift
//  Partner-Swift
//
//  Created by gusheng on 15/5/21.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

protocol HWRedPaperRefreshViewDelegate
{
    func cellIsSelected(model:HWRedPaperModel)
}
class HWRedPaperRefreshView: HWBaseRefreshView {

    var clikedDelegate:HWRedPaperRefreshViewDelegate?
     override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.baseTable.separatorStyle = UITableViewCellSeparatorStyle.None
        self.baseTable.backgroundColor = UIColor.clearColor()
        self.setIsNeedHeadRefresh(false)
        self.currentPage = 1
        self.addSubview(self.baseTable)
    
        self.queryListData()
    }
    
//    override func queryListData()
//    {
//        var arr = [["title":"外滩","type":"0","money":"3","time":"5月1日"],["title":"外滩","type":"0","money":"10","time":"5月3日"],["title":"外滩","type":"0","money":"1","time":"5月10日"],["title":"外滩","type":"1","money":"2","time":"3月3日"],["title":"外滩","type":"1","money":"3","time":"5月1日"],["title":"外滩","type":"1","money":"10","time":"5月6日"]];
//        for dic:Dictionary in arr
//        {
//            var model = HWRedPaperModel(dic: dic)
//            self.baseListArr.addObject(model)
//        }
//        
//    }
    override func queryListData()
    {
        Utility.hideMBProgress(self);
        Utility.showMBProgress(self, _message: "加载中")
        
        var param: NSMutableDictionary = NSMutableDictionary()
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param.setPObject("\(currentPage)", forKey: "pageNumber")
        param.setPObject("\(kPageCount)", forKey: "pageSize")
        
        let manager = HWHttpRequestOperationManager.baseManager()
        manager.postHttpRequest(kGetRedList, parameters: param, queue: nil, success: { (responseObject) -> Void in
            
            Utility.hideMBProgress(self)
            //println(responseObject)
            let resultDic:NSDictionary = responseObject.objectForKey("data") as NSDictionary;
            let resultArray: NSArray = resultDic.arrayObjectForKey("content") as NSArray
            if (self.currentPage == 1)
            {
                self.baseListArr.removeAllObjects()
            }
            
            if (resultArray.count < kPageCount)
            {
                self.isLastPage = true
            }
            else
            {
                self.isLastPage = false
            }
            
            let modelArray: NSMutableArray = NSMutableArray()
            for (var i = 0; i < resultArray.count; i++)
            {
                let dic: NSDictionary! = resultArray.pObjectAtIndex(i) as NSDictionary
                let model: HWRedPaperModel = HWRedPaperModel(dic: dic)
                modelArray.addObject(model)
            }
            
            self.baseListArr.addObjectsFromArray(modelArray)
            
            self.baseTable.reloadData()
            self.doneLoadingTableViewData()
            
            if(self.baseListArr.count == 0)
            {
                self.showEmptyRedView("暂无红包哦")
            }
            else
            {
                self.hideEmptyView()
            }
            
            
            }) { (code, error) -> Void in
                //                println("code : \(code) error: \(error)")
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
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.baseListArr.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 80;
    }
    
     override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentify = "cell"
        var cell : HWRedPaperTableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellIdentify) as? HWRedPaperTableViewCell
        if cell == Optional.None
        {
            cell = HWRedPaperTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentify)
        }
        cell?.selectionStyle = UITableViewCellSelectionStyle.None;
        cell?.setValueForContentView(self.baseListArr.pObjectAtIndex(indexPath.row) as HWRedPaperModel)
        cell?.contentView.drawBottomLine()
        return cell!
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        self.clikedDelegate?.cellIsSelected(self.baseListArr.pObjectAtIndex(indexPath.row) as HWRedPaperModel)
    }
     required init(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }

}
