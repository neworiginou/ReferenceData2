//
//  HWRelativeCollectHouseView.swift
//  Partner-Swift
//
//  Created by gusheng on 15/3/4.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit
protocol relativeCollectHouseDelegate
{
    func returnSelectedCollectionHouse(arry:NSMutableArray)->Void;
}
class HWRelativeCollectHouseView: HWBaseRefreshView
{
    var selectedCustomerArry:NSMutableArray!;
    var selectFrontArry:NSMutableArray!;
    var delegate:relativeCollectHouseDelegate!;
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        var headerView = UIView(frame: CGRectMake(0, 0, kScreenWidth, 10 * kRate))
        headerView.drawBottomLine()
        self.baseTable.tableHeaderView = headerView
        selectedCustomerArry = NSMutableArray();
        selectFrontArry = NSMutableArray();
        self.baseTable.registerClass(HWRelativeHouseTableViewCell.self, forCellReuseIdentifier: "cell")
    }


    override func queryListData()
    {
        //加载列表
        var dict = NSMutableDictionary()
        Utility.showMBProgress(self, _message: "加载中")
        let manager = HWHttpRequestOperationManager.baseManager()
        var param: NSMutableDictionary! = NSMutableDictionary()
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param.setPObject("\(currentPage)", forKey:"pageNumber")
        param.setPObject("\(kPageCount)", forKey: "pageSize")
        
        manager.postHttpRequest(kMyCollection, parameters: param, queue: nil, success: { (responseObject) -> Void in
            
            Utility.hideMBProgress(self)
            var arry: NSArray = responseObject .arrayObjectForKey("data") as NSArray
            var dic = NSDictionary()
            if arry.count == 0 && self.currentPage == 1
            {
                self.baseListArr .removeAllObjects()
                self.showEmptyView("暂无数据")
                
            }
            else
            {
                self.hideEmptyView()
            }
            if arry.count < kPageCount
            {
                self.isLastPage = true
            }
            else
            {
                self.isLastPage = false
            }
            if self.currentPage == 1
            {
                self.baseListArr  = NSMutableArray()
            }
            else
            {
                
            }
            for var i = 0;i < arry.count;i++
            {
                dic = arry .objectAtIndex(i) as NSDictionary
                var houseModel:HWScdHouseModel = HWScdHouseModel(dict: dic)
                self.baseListArr.addObject(houseModel)
               
            }
            
             self.baseTable .reloadData()
             self.doneLoadingTableViewData()
            }) { (code, error) -> Void in
                
                Utility.hideMBProgress(self)
                self.baseTable .reloadData()
                self.doneLoadingTableViewData()
                if (code.integerValue == kStatusFailure && self.baseListArr.count == 0)
                {
                    self.showNetworkErrorView("无网络")
                }
                else
                {
                    Utility.showToastWithMessage(error, _view: self)
                }

}
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 95 * kRate
    }
    
//       for(var i:Int = 0;i < 5; i++)
//        {
//            dict.setPObject("title\(i)", forKey: "title")
//            dict.setPObject("title\(i)", forKey: "villageName");
//            dict.setPObject("区域名字\(i)", forKey: "areaName")
//            dict.setPObject("板块名\(i)", forKey: "plateName")
//            dict.setPObject("\(i+100)", forKey: "price")
//            dict.setPObject("\(i+90)", forKey: "proportion")
//            dict.setPObject("3", forKey: "roomCount")
//            dict.setPObject("\(i+1)", forKey: "hallCount")
//            dict.setPObject("\(i+10)", forKey: "collectNum")
//            dict.setPObject("", forKey: "picKey")
//            var model = HWSecondHouseModel()
//            model.initWithData(dict);
//            self.baseListArr.addObject(model)
//        }
       
   
    
    //MARK:--tableView delegate
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.baseListArr.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as HWRelativeHouseTableViewCell
        cell.setRelativeHouseCollectionInfo(self.baseListArr.pObjectAtIndex(indexPath.row) as HWScdHouseModel)
        cell.contentView.drawBottomLine()
        cell.setCollectionHouseInfo(baseListArr[indexPath.row] as HWScdHouseModel,selectedArry:selectedCustomerArry)
        //
        cell.selectSecondHouseFunc = {
                (selectFlag:Bool)->Void in
                print(selectFlag);
                var selectedCustomer:HWScdHouseModel = self.baseListArr.objectAtIndex(indexPath.row) as HWScdHouseModel;
                if(selectFlag == true)
                {
                    self.selectedCustomerArry.addObject(selectedCustomer);
                    selectedCustomer.selectedFlag = true;
                }
                else
                {
                    self.selectedCustomerArry.removeObject(selectedCustomer);
                    selectedCustomer.selectedFlag = false;
                }
                var rows:Int = self.selectedCustomerArry.count;
                self.delegate?.returnSelectedCollectionHouse(self.selectedCustomerArry);
                
        };

        return cell
    }
    required init(coder aDecoder: NSCoder)
    {
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
