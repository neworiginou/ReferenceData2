//
//  HWRelativeSecondHouseView.swift
//  Partner-Swift
//
//  Created by gusheng on 15/3/4.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit
protocol relativeSecondHouseDelegate
{
    func relativeSecondHouseSelected(arry:NSMutableArray)->Void;
    func lookAllSecondHouse()->Void;
}

class HWRelativeSecondHouseView: HWBaseRefreshView
{

    var totalSecHouseNum: String?
    var cityName: String?
    var selectedCustomerArry:NSMutableArray!;
    var delegate:relativeSecondHouseDelegate!;
    var clientInfoId:NSString = NSString()
    var areaId = NSString()
    var plateIds = NSString()
    var roomCount = NSString()
    var orderType = NSString()
    var price = NSString()
    var lookAllSecondFlag = NSString();
    
    //MARK: init
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        //
        selectedCustomerArry = NSMutableArray();
        self.baseTable.tableFooterView = self.createTableViewFooterView();
    }
    override func queryListData()
    {
//        self.creatTestData()
//        baseTable.reloadData()
        var dict = NSMutableDictionary()
        Utility.showMBProgress(self, _message: "加载中")
        let manager = HWHttpRequestOperationManager.baseManager()
        var param: NSMutableDictionary! = NSMutableDictionary()
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param .setObject(clientInfoId, forKey: "clientInfoId")
        param.setPObject("\(currentPage)", forKey:"pageNumber")
        param.setPObject("\(kPageCount)", forKey: "pageSize")
        param .setObject(price, forKey: "price")
        param .setObject(areaId, forKey: "areaId")
        param .setObject(roomCount, forKey: "roomCount")
        param .setObject(orderType, forKey: "orderType")
        param .setObject(plateIds, forKey: "plateId")
        var requestStr:NSString;
        if(lookAllSecondFlag == "lookAll")
        {
            requestStr = kScdHouHomePageList
        }
        else
        {
            requestStr = kmateScdHouseList;
        }
        manager.postHttpRequest(requestStr, parameters: param, queue: nil, success: { (responseObject) -> Void in
            
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
            for var i = 0;i < arry.count;i++
            {
                dic = arry .objectAtIndex(i) as NSDictionary
                var houseModel:HWScdHouseModel = HWScdHouseModel(dict: dic)
                
                self.baseListArr .addObject(houseModel)
                
            }
             UITableViewStyle.Grouped;
            self.baseTable .reloadData();
            self.doneLoadingTableViewData()

            }) { (code, error) -> Void in
                
                self.baseTable.reloadData()
                self.doneLoadingTableViewData()
                Utility.hideMBProgress(self)
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
    //MARK: 筛选框方法
     func customerSearchView(customerSearchView: CustomSearchView!, passValue value: String!, withIndex index: String!)
     {
        var priceIndexArr = ["", "1", "2", "3", "4", "5", "6", "7"] //(1:100万以下,2:100-150万,3:150-200万, 4:200-300万,5:300-500万,6:500-1000万,7:1000万以上)
        var roomCountIndexArr = ["", "1", "2", "3", "4", "5", "6"]//(1:一居 2:二居 3:三居 4:四居 5:五居 6:五居以上)
        var orderTypeIndexArr = ["", "1", "2", "3", "4", "5", "6"]//(1:房价降序 2:房价升序 3:均价降序 4:均价升序 5:面积降序 6:面积升序)
        if(index == "1")//价格
        {
            price = priceIndexArr[value.toInt()!]
        }
        else if(index == "2")//户型
        {
            roomCount = roomCountIndexArr[value.toInt()!]
        }
        else            //排序
        {
            orderType = orderTypeIndexArr[value.toInt()!]
        }
        currentPage = 1
        self.queryListData()

     }
     func customerSearchView(customerSearchView: CustomSearchView!, passZone zoneId: String!, plateId: String!)
     {
        areaId = zoneId
        plateIds = plateId
        currentPage = 1
        self .queryListData()
     }
    //MARK: tableView代理
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return baseListArr.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cellId = "cellID"
        var cell: HWRelativeHouseTableViewCell! = tableView.dequeueReusableCellWithIdentifier(cellId) as? HWRelativeHouseTableViewCell
        if(cell == nil)
        {
            cell = HWRelativeHouseTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellId)
        }
        cell?.contentView.drawBottomLine()
        
        cell?.setSecondHouseInfo(baseListArr[indexPath.row] as HWScdHouseModel,selectedArry:selectedCustomerArry)
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
                self.delegate?.relativeSecondHouseSelected(self.selectedCustomerArry);
                
        };
        
        //
        return cell!
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return HWRelativeHouseTableViewCell.getCellHeight(baseListArr[indexPath.row] as HWScdHouseModel)
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        return nil;
    }
//    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
//    {
//        return 30.0;
//    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 0.0
    }
//    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
//    {
//        var moreView:UIView = UIView(frame: CGRectMake(0, 0, kScreenWidth, 30))
//        var moreBtn:UIButton = UIButton(frame: CGRectMake(kScreenWidth/2-240/2, 5, 240, 20));
//        moreBtn.layer.cornerRadius = 5.0;
//        moreBtn.layer.masksToBounds = true;
//        moreBtn.setTitle("查看全部二手房", forState: UIControlState.Normal);
//        moreBtn.addTarget(self, action: "showMoreSecondHouse", forControlEvents: UIControlEvents.TouchUpInside);
//        moreBtn.setTitleColor(CD_Txt_Color_66, forState: UIControlState.Normal)
//        moreBtn.backgroundColor = CD_Txt_Color_99;
//        moreView.addSubview(moreBtn);
//        return moreView;
//        
//    }
    
    func createTableViewFooterView() -> UIView
    {
        var moreView:UIView = UIView(frame: CGRectMake(0, 0, kScreenWidth, 30))
        var moreBtn:UIButton = UIButton(frame: CGRectMake(kScreenWidth/2-120/2, 5, 120, 20));
        moreBtn.layer.cornerRadius = 5.0;
        moreBtn.layer.masksToBounds = true;
        moreBtn.setTitle("查看全部二手房", forState: UIControlState.Normal);
        moreBtn.titleLabel?.font = UIFont(name: FONTNAME, size: TF_13)
        moreBtn.layer.borderColor = CD_Txt_Color_99.CGColor;
        moreBtn.layer.borderWidth = 0.5;
        moreBtn.addTarget(self, action: "showMoreSecondHouse", forControlEvents: UIControlEvents.TouchUpInside);
        moreBtn.setTitleColor(CD_Txt_Color_99, forState: UIControlState.Normal)
        moreBtn.backgroundColor = CD_BackGroundColor;
        moreView.addSubview(moreBtn);
        return moreView;
        
    }
    func showMoreSecondHouse()->Void
    {
        self.baseTable.tableFooterView = nil;
        lookAllSecondFlag = "lookAll"
        self.queryListData();
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
//        var detailVC = HWScdHouseDetailViewController()
//        delegate?.pushVC(detailVC)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
