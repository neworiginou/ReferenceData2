//
//  HWScoreFinanceTableView.swift
//  HaoWuPartner
//
//  Created by WeiYuanlin on 15/2/9.
//  Copyright (c) 2015年 WeiYuanlin. All rights reserved.
//  功能描述：我的业绩—金融tableview
//
//  魏远林    2015-02-09    创建
//
//

import UIKit

class HWScoreFinanceTableView: HWBaseRefreshView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initContentView()
    }
    
    func initContentView()
    {
        self.baseTable.separatorStyle = UITableViewCellSeparatorStyle.None
        self.currentPage = 1
        self.isNeedHeadRefresh = true
        
        self.addSubview(self.baseTable)
        self.queryListData()
    }
    
    /**
    *	@brief	加载数据
    *
    *	@param 	 N/A
    *
    *	@return	 N/A
    */
    override func queryListData()
    {
        Utility.showMBProgress(self, _message: "数据加载中")
//       var param = ["key":HWUserLogin.currentUserLogin().key, "type":"3", "pageNumber":"1", "pageSize":kPageCount] as NSDictionary
        
        var param: NSMutableDictionary! = NSMutableDictionary()
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param.setPObject("3", forKey: "type")
        param.setPObject("\(currentPage)", forKey: "pageNumber")
        param.setPObject("\(kPageCount)", forKey: "pageSize")
        
        var manager = HWHttpRequestOperationManager.baseManager()
        manager.postHttpRequest(kMyScore, parameters: param, queue: nil, success: { (responseObject) -> Void in
            Utility.hideMBProgress(self)
            if self.currentPage == 1
            {
                self.baseListArr.removeAllObjects()
            }
            var dataDic = responseObject.dictionaryObjectForKey("data") as NSDictionary
            var pageInfoDic = dataDic.dictionaryObjectForKey("pageInfo") as NSDictionary
            var contentArr = pageInfoDic.arrayObjectForKey("data") as NSArray
            if contentArr.count < kPageCount
            {
                self.isLastPage = true
            }
            else
            {
                self.isLastPage = false
            }
            for detailDic in contentArr
            {
                var scoreModel = HWScoreCFOModel(dic: detailDic as NSDictionary)
                self.baseListArr.addObject(scoreModel)
            }
            self.baseTable.reloadData()
            self.doneLoadingTableViewData()
            
            }) { (failure, error) -> Void in
                Utility.hideMBProgress(self)
                Utility.showToastWithMessage(error, _view: self)
                self.doneLoadingTableViewData()
        }
                
    }

    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.baseListArr.count

    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return HWScoreFinanceTableViewCell.setCellHeight()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cellIdentify = "cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentify) as? HWScoreFinanceTableViewCell
        if cell == Optional.None
        {
            cell = HWScoreFinanceTableViewCell.init(style:UITableViewCellStyle.Default, reuseIdentifier: cellIdentify)
        }
        cell!.setValueOfContentView(self.baseListArr.pObjectAtIndex(indexPath.row) as HWScoreCFOModel)
        cell?.contentView.drawBottomLine()
        return cell!
    }
    
    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
}
