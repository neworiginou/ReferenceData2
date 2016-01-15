//
//  HWMyIntegrationTableView.swift
//  Partner-Swift
//
//  Created by WeiYuanlin on 15/2/27.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：我的积分tableView
//
//  魏远林  2015-02-27    创建
//
//

import UIKit

protocol HWMyIntegrationTableViewDelegate
{
    func passIntegrationValue(arr:NSArray)
}
class HWMyIntegrationTableView: HWBaseRefreshView
{
    var delegate:HWMyIntegrationTableViewDelegate?
    var directIntegration:Int?
    var recordCountLabel: UILabel = UILabel()
    
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.baseTable.separatorStyle = UITableViewCellSeparatorStyle.None
        self.baseTable.backgroundColor = UIColor.whiteColor()
//        self.isLastPage = true
//        self.isNeedHeadRefresh = false
        
        var footView = UIView(frame: CGRectMake(0, 0, kScreenWidth, 45))
        footView.backgroundColor = UIColor.clearColor()
        self.baseTable.tableFooterView = footView
        
        recordCountLabel = UILabel(frame: CGRectMake(0, 0, kScreenWidth, 45))
        recordCountLabel.backgroundColor = UIColor.clearColor()
        recordCountLabel.textAlignment = NSTextAlignment.Center
        recordCountLabel.textColor = CD_Txt_Color_66
        recordCountLabel.text = "共0个积分记录"
        recordCountLabel.font = Define.font(TF_14)
        footView.addSubview(recordCountLabel)
        
        let line = UIView(frame: CGRectMake(0, 44.5, kScreenWidth, 0.5))
        line.backgroundColor = CD_LineColor
        footView.addSubview(line)
        
//        self.queryListData()
        
    }

    //MARK: UITableView Delegate
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
        return HWMyIntegrationTableViewCell.setCellHeight()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cellIdentify = "cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentify) as? HWMyIntegrationTableViewCell
        if cell == Optional.None
        {
            cell = HWMyIntegrationTableViewCell.init(style:UITableViewCellStyle.Default, reuseIdentifier: cellIdentify)
        }
        cell?.contentView.drawBottomLine()
        cell?.rewriteViewFrame(self.baseListArr.pObjectAtIndex(indexPath.row) as HWIntegrationListModel)
        return cell!
    }
    
    
    //MARK: 请求数据
    override func queryListData()
    {
        Utility.showMBProgress(self, _message: "数据加载中")
        var param: NSMutableDictionary = NSMutableDictionary()
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param.setPObject("\(currentPage)", forKey: "pageNumber")
        param.setPObject("\(kPageCount)", forKey: "pageSize")
        
        //产品要求是一页20条数据//direct: *** 积分方向, in流入、out流出,全部传""
        if directIntegration == 0
        {
            param.setPObject("", forKey: "direct")
        }
        else if directIntegration == 1
        {
            param.setPObject("in", forKey: "direct")
//            param = ["direct":"in", "pageNumber":"1", "pageSize":"20","key":HWUserLogin.currentUserLogin().key]
        }
        else if directIntegration == 2
        {
            param.setPObject("out", forKey: "direct")
//            param = ["direct":"out", "pageNumber":"1", "pageSize":"20","key":HWUserLogin.currentUserLogin().key]
        }
        var manager = HWHttpRequestOperationManager.baseManager()
        manager.postHttpRequest(kIntegrationList, parameters: param, queue: nil, success: { (responseObject) -> Void in
            Utility.hideMBProgress(self)
        
            var dataDic = responseObject.dictionaryObjectForKey("data") as NSDictionary
            //积分的值
            var integralArr = [dataDic.stringObjectForKey("integralSum") as String, dataDic.stringObjectForKey("listIntegralSum") as String] as NSArray
            self.delegate?.passIntegrationValue(integralArr)
            
            
            if self.currentPage == 1
            {
                self.baseListArr.removeAllObjects()
            }
            
            var pageInfoDic = dataDic.dictionaryObjectForKey("pageInfo") as NSDictionary
            var dataArr = pageInfoDic.arrayObjectForKey("data")
            
            if dataArr.count < kPageCount
            {
                self.isLastPage = true
            }
            else
            {
                self.isLastPage = false
            }
            
            var detailDic:NSDictionary?
            for detailDic in dataArr
            {
                var integralModel = HWIntegrationListModel(dic: detailDic as NSDictionary)
                self.baseListArr.addObject(integralModel)
            }
            
            self.baseTable.reloadData()
            self.doneLoadingTableViewData()
            
            let dataNum = pageInfoDic.stringObjectForKey("totalSize")
            
            self.recordCountLabel.text = "共\(dataNum)个积分记录"
            
        }) { (failure, error) -> Void in
            println(error)
            Utility.hideMBProgress(self)
            Utility.showToastWithMessage(error, _view: self)
            self.doneLoadingTableViewData()
//            self.baseTable.reloadData()
        }
        
    }

    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}
