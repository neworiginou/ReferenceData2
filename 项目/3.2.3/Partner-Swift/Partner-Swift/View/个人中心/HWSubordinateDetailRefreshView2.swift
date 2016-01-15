//
//  HWSubordinateDetailRefreshView2.swift
//  Partner-Swift
//
//  Created by hw500029 on 15/3/18.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

protocol HWSubordinateDetailDelegate2
{
    func didSelectedCustomer2(clientInfoId:NSString,clientType:NSString) ->Void
}

class HWSubordinateDetailRefreshView2: HWBaseRefreshView,UITableViewDelegate,UITableViewDataSource,HWCustomAlertViewDelegate{

    var delegate:HWSubordinateDetailDelegate2?
    
    var topView:HWSubordinateRefreshTopView?
    var brockerID:NSString?
    var pageSize:NSInteger = 10
    var parmaUrl = kSubordinateDetailAchievement
    var topLine:UIView?
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        
        self.baseTable.frame = CGRectMake(0, 10 * kScreenRate, kScreenWidth, self.bounds.size.height - 10 * kScreenRate)
        self.baseTable.separatorStyle = UITableViewCellSeparatorStyle.None;
        
        //self.queryListData()
        
        let lineBackView = UIView.newAutoLayoutView()
        lineBackView.backgroundColor = UIColor.clearColor()
        self.addSubview(lineBackView)
        lineBackView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsMake(0, 0, 0, 0), excludingEdge: ALEdge.Bottom)
        lineBackView.autoSetDimension(ALDimension.Height, toSize: 10 * kScreenRate)
        
        topLine = UIView.newAutoLayoutView()
        topLine?.backgroundColor = CD_LineColor
        lineBackView.addSubview(topLine!)
        topLine?.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsMake(0, 0, 0, 0), excludingEdge: ALEdge.Top)
        topLine?.autoSetDimension(ALDimension.Height, toSize: 0.5)
        topLine?.hidden = true


    }
    
    //
    override func queryListData() {
        
        var parma = NSMutableDictionary()
        parma.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        parma.setPObject(brockerID, forKey: "brokerId")
        parma.setPObject("\(currentPage)", forKey: "pageNumber")
        parma.setPObject("\(kPageCount)", forKey: "pageSize")
        var manager = HWHttpRequestOperationManager.baseManager()
        manager.postHttpRequest(parmaUrl, parameters: parma, queue: nil, success:
            { (responseObject) -> Void in
                
//                println("responseObject ================= \(responseObject)")
                
                var responseDic = responseObject as NSDictionary
                var dataDic = responseDic.dictionaryObjectForKey("data") as NSDictionary
                var dataArr = responseDic.arrayObjectForKey("data")
                var subArr = NSMutableArray()
                for var i = 0; i<dataArr.count; i++
                {
                    var model = HWBrokerCumModel()
                    var dic: AnyObject? = dataArr.pObjectAtIndex(i)
                    model.fetchData(dic as NSDictionary)
                    subArr.addObject(model)
                }
                
                if (dataArr.count < kPageCount)
                {
                    self.isLastPage = true
                }
                else
                {
                    self.isLastPage = false
                }
                
                if (self.currentPage == 1)
                {
                    self.baseListArr = NSMutableArray(array: subArr)
                }
                else
                {
                    self.baseListArr.addObjectsFromArray(subArr)
                }
//                println("ArrayCount ================== \(self.baseListArr.count)")
                
                self.baseTable.reloadData()
                self.doneLoadingTableViewData()
                if(self.baseListArr.count == 0)
                {
                    self.showEmptyView("列表数据为空")
                    self.topLine?.hidden = true
                }
                else
                {
                    self.hideEmptyView()
                    self.topLine?.hidden = false
                }
            }) { (failure, error) -> Void in
                //println("请求失败")
                self.doneLoadingTableViewData()
        }
        
    }
    
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.baseListArr.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 95 * kScreenRate
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier: String = "id";
        var cell: HWSubordinateCustomerCell? = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? HWSubordinateCustomerCell
        if cell == Optional.None
        {
            cell = HWSubordinateCustomerCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
        }
        
//        if indexPath.row == 0
//        {
//            cell?.contentView.drawTopLine()
//        }

        var model:HWBrokerCumModel = self.baseListArr.pObjectAtIndex(indexPath.row) as HWBrokerCumModel
        cell?.nameLabel?.text = model.clientName
        cell?.infoLabel?.text = "\(model.houseName!)"+model.clientIntention!
        cell?.stateLabel?.text = model.status
        cell?.callBtn?.tag = 100 + indexPath.row
        cell?.callBtn?.addTarget(self, action: "call:", forControlEvents: UIControlEvents.TouchUpInside)
        cell?.timeStateLabel?.text = model.lastChangeTime
        
        return cell!
    }
    
    //跳转客户详情
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
//        println("index = \(indexPath.row)")
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        //delegate?.didSelectedCell(indexPath.row)
        
        var model:HWBrokerCumModel = self.baseListArr.pObjectAtIndex(indexPath.row) as HWBrokerCumModel
        
        delegate?.didSelectedCustomer2(model.clientInfoID!,clientType:model.clientType)
    }
    
    func call(sender:UIButton)
    {
        var model:HWBrokerCumModel = self.baseListArr.pObjectAtIndex(sender.tag - 100) as HWBrokerCumModel
        var phoneNum = model.clientPhone
//        println("phoneNum ================== \(phoneNum)")
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
