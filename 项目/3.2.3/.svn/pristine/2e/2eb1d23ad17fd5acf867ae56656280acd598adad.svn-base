//
//  HWMyDisCountRefreshView.swift
//  Partner-Swift
//
//  Created by hw500029 on 15/5/22.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

protocol HWMyDisCountRefreshViewDelegate
{
    func shareCouponByIndex(model:HWMyDisCountModel)
    func pushDetailViewByModel(model:HWMyDisCountModel)
}

class HWMyDisCountRefreshView: HWBaseRefreshView {

    let pageSize = 20
    var delegate:HWMyDisCountRefreshViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.baseTable.frame = self.frame
        self.baseTable.separatorStyle = UITableViewCellSeparatorStyle.None;
        self.baseTable.delegate = self
        self.baseTable.dataSource = self
        
        var headView:UIView = UIView(frame: CGRectMake(0, 0, kScreenWidth, 16))
        headView.backgroundColor = CD_BackGroundColor
        self.baseTable.tableHeaderView = headView
        
        self.queryListData()
        
        
    }
    
    
    
    override func queryListData() {
        
        Utility.showMBProgress(self, _message: "请求中")
        
        var parma = NSMutableDictionary()
        parma.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        parma.setPObject(currentPage, forKey: "pageNumber")
        parma.setPObject(pageSize, forKey: "pageSize")
        var manager = HWHttpRequestOperationManager.baseManager()
        manager.postHttpRequest(kMyDisCountCouponList, parameters: parma, queue: nil, success:
            { (responseObject) -> Void in
                println("responseObject ================ \(responseObject)")
                var responseDic = responseObject as NSDictionary
                var dataArr = responseDic.arrayObjectForKey("data") as NSArray
                
                var subArr = NSMutableArray()
                for var i = 0; i<dataArr.count; i++
                {
                    var model = HWMyDisCountModel()
                    var dic: AnyObject? = dataArr.pObjectAtIndex(i)
                    model.fetchData(dic as NSDictionary)
                    subArr.addObject(model)
                }
                
                if (dataArr.count < self.pageSize)
                {
                    self.isLastPage = true
                }
                else
                {
                    self.isLastPage = false
                }
                
                if (self.currentPage == 1)
                {
                    //self.baseListArr.removeAllObjects()
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
                }
                else
                {
                    self.hideEmptyView()
                }
                
                Utility.hideMBProgress(self)
            }) { (failure, error) -> Void in
                //println("请求失败")
                self.doneLoadingTableViewData()
                self.showNetworkErrorView("请求失败")
                Utility.hideMBProgress(self)
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.baseListArr.count
        //return 10
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellID: String = "id";
        var cell: HWMyDisCountCell? = tableView.dequeueReusableCellWithIdentifier(cellID) as? HWMyDisCountCell
        
        if cell == Optional.None
        {
            cell = HWMyDisCountCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellID)
        }
        
        var model:HWMyDisCountModel = baseListArr.pObjectAtIndex(indexPath.row) as HWMyDisCountModel
        
        cell?.nameLabel.text = model.title
        cell?.numberLabel.text = "编号：" + model.couponNum
        cell?.discountLabel.attributedText = model.couponAttriNum
        cell?.validityPeriod.text = model.validityTime
        cell?.picImgView.setImageWithURL(NSURL(string:model.picKey), placeholderImage: Utility.getPlaceHolderImage(CGSizeMake(95, 75), imageName: placeHolderSmallImage))
        if model.status == "可使用"
        {
            cell?.shareBtn.hidden = false
            cell?.stateLabel.text = nil
            cell?.shareBtn.tag = 100 + indexPath.row
            cell?.shareBtn.addTarget(self, action: "shareAction:", forControlEvents: UIControlEvents.TouchUpInside)
            cell?.nameLabel.textColor = CD_Txt_Color_33
            cell?.numberLabel.textColor = CD_Txt_Color_33
        }
        else if model.status == "已使用"
        {
            cell?.shareBtn.hidden = true
            cell?.stateLabel.text = nil
            cell?.stateLabel.text = model.status
            cell?.stateLabel.textColor = CD_MainColor
            cell?.nameLabel.textColor = CD_Txt_Color_33
            cell?.numberLabel.textColor = CD_Txt_Color_99
        }
        else
        {
            cell?.shareBtn.hidden = true
            cell?.stateLabel.text = nil
            cell?.stateLabel.text = model.status
            cell?.stateLabel.textColor = CD_Txt_Color_99
            cell?.nameLabel.textColor = CD_Txt_Color_99
            cell?.numberLabel.textColor = CD_Txt_Color_99
        }
        
        let urlStr = model.picKey
        //cell?.picImgView.setImageWithURL(NSURL(string: urlStr))
        cell?.selectionStyle = UITableViewCellSelectionStyle.None
        return cell!
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        var model:HWMyDisCountModel = baseListArr.pObjectAtIndex(indexPath.row) as HWMyDisCountModel
        self.delegate?.pushDetailViewByModel(model)

    }
    
    func shareAction(sender:UIButton)
    {
        println("button.tag ================= \(sender.tag)")
         var model:HWMyDisCountModel = baseListArr.pObjectAtIndex(sender.tag - 100) as HWMyDisCountModel
        self.delegate?.shareCouponByIndex(model)
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
