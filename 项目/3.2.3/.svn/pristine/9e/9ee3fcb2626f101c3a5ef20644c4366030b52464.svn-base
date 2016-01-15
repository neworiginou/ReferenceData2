//
//  HWDiscountRefreshView.swift
//  Partner-Swift
//
//  Created by hw500029 on 15/5/21.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

@objc protocol HWDiscountRefreshViewDelegate
{
    optional func didSelectdAtIndex(couponID:String,urlStr:String,brokerId:String) -> Void
}


class HWDiscountRefreshView: HWBaseRefreshView {

    let pageSize = 20
    var delegate:HWDiscountRefreshViewDelegate?
    
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
//        self.showEmptyV("暂无可抢的优惠券～")
    }

    func reloadList()
    {
        self.currentPage = 1
        self.queryListData()
    }
    
    override func queryListData()
    {
        Utility.showMBProgress(self, _message: "请求中")
        
        var parma = NSMutableDictionary()
        parma.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        parma.setPObject(currentPage, forKey: "pageNumber")
        parma.setPObject(pageSize, forKey: "pageSize")
        var manager = HWHttpRequestOperationManager.baseManager()
        manager.postHttpRequest(kDisCountCouponList, parameters: parma, queue: nil, success:
            { (responseObject) -> Void in

                var responseDic = responseObject as NSDictionary
                var dataArr = responseDic.arrayObjectForKey("data") as NSArray
                
                var subArr = NSMutableArray()
                for var i = 0; i<dataArr.count; i++
                {
                    var model = HWDisCountListModel()
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
                    self.showEmptyV("暂无可抢的优惠券～")
                }
                else
                {
                    self.hideEmptyV()
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
        return 120
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier: String = "id";
        var cell: HWDiscountListCell? = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? HWDiscountListCell
        if cell == Optional.None
        {
            cell = HWDiscountListCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
        }
        
        var model:HWDisCountListModel = baseListArr.pObjectAtIndex(indexPath.row) as HWDisCountListModel
        
        cell?.nameLabel.text = model.couponTitle
        //cell?.preferentialLabel.text = model.couponMoney
        cell?.preferentialLabel.attributedText = model.couponAttriNum
        cell?.validityPeriodLabel.text = model.validityTime
        if countElements(model.residueNum) >= 3
        {
            cell?.leftNumLabel.attributedText = self.getAttributString(model.residueNum)
        }
        else
        {
            cell?.leftNumLabel.text = model.residueNum
        }
        //cell?.leftNumLabel.text = model.residueNum
        cell?.showImgView.setImageWithURL(NSURL(string:model.imageId), placeholderImage: Utility.getPlaceHolderImage(CGSizeMake(95, 75), imageName: placeHolderSmallImage))
        
        return cell!
    }

    func getAttributString(str:String) ->NSMutableAttributedString
    {
        var attriStr = NSMutableAttributedString(string: str)
        attriStr.addAttributes([NSForegroundColorAttributeName: CD_txt_Red], range: NSMakeRange(2, countElements(str) - 3))
        return attriStr
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        var model:HWDisCountListModel = baseListArr.pObjectAtIndex(indexPath.row) as HWDisCountListModel
        self.delegate?.didSelectdAtIndex!(model.couponId,urlStr: model.webUrl,brokerId:model.brokerId)
    }
    
    func showEmptyV(message:NSString) -> Void
    {
        var emptyView: UIView? = self.viewWithTag(1112)
        if (emptyView != nil)
        {
            emptyView?.removeFromSuperview()
        }
        
        weak var weakSelf: HWBaseRefreshView? = self;
        
        //        empty
        
        let emptyV: HWEmptyControl = HWEmptyControl(frame: self.frame, titleStr: message, imageName: "no_coupon") { () -> Void in
            self.queryListData()
        }
        emptyV.tag = 1112
        self.addSubview(emptyV)
    }

    func hideEmptyV() -> Void
    {
        var emptyView: UIView? = self.viewWithTag(1112)
        if (emptyView != nil)
        {
            emptyView?.removeFromSuperview()
        }
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
