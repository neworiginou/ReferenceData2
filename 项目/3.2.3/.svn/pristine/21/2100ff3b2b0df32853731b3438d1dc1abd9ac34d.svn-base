//
//  HWFlightHouseView.swift
//  Partner-Swift
//
//  Created by gusheng on 15/3/6.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit
protocol selectFlightHouseDelegat
{
    func selectedFlightHouseS(arry:NSMutableArray)->Void;
}



class HWFlightHouseView: HWBaseRefreshView
{

    var selectedCustomerArry:NSMutableArray!;
    var delegate:selectFlightHouseDelegat!;
    var clientInfoid :NSString = NSString()
    var areaId = NSString()
    init(frame: CGRect,clientInfoId:NSString)
    {
        super.init(frame: frame);
        clientInfoid = clientInfoId
        var headerView = UIView(frame: CGRectMake(0, 0, kScreenWidth, 10 * kRate))
        headerView.drawBottomLine()
        self.baseTable.tableHeaderView = headerView
        selectedCustomerArry = NSMutableArray();
        self.baseTable.frame = CGRectMake(0, 0, kScreenWidth, contentHeight-44-35)
        self.baseTable.registerClass(HWFlightHouseTableViewCell.self, forCellReuseIdentifier: "cell");
        self .queryListData()
    }
    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    

    //MARK-:获取报备新房列表
    override func queryListData()
    {
        
        /*
        请求
        key: ***              --用户key
        clientInfoId: ***     --经纪人客户ID
        regionId: ***         --区域ID
        page: ***   --请求页码,从0开始
        size: ***   --请求条数
        /////响应
        {
        "detail": "",
        "status": "",
        "data": {
        "content": [
        {
        "houseId":"",       --房源ID
        "houseName":"",     --房源名称
        "houseAddress":"",  --房源位置([区域-板块])
        "housesStatus":""   --状态（0未报备，1已报备）
        },
        { },
        { }
        ],
        "firstPage": "",
        "lastPage": "",
        "totalPages": "",
        "numberOfElements": "",
        "totalElements": "",
        "sort": "",
        "size": "", 
        "number": ""
        }
        }
        
        */
        
        Utility.showMBProgress(self, _message: "加载中")
        let manager = HWHttpRequestOperationManager.baseManager()
        var param: NSMutableDictionary! = NSMutableDictionary()
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param.setPObject(clientInfoid, forKey: "clientInfoId")
        param.setPObject(areaId, forKey: "regionId");
        param.setPObject("\(currentPage)", forKey:"pageNumber")
        param.setPObject("\(kPageCount)", forKey: "pageSize")
        
        manager.postHttpRequest(kFlightHouseList, parameters: param, queue: nil, success: { (responseObject) -> Void in
            
            Utility.hideMBProgress(self)
            var arry: NSArray = responseObject .arrayObjectForKey("data") as NSArray
            
            if arry.count == 0 && self.currentPage == 1
                
            {
                self.baseListArr .removeAllObjects()
                self.showEmptyView("暂无楼盘")
                
            }
                
            else
            {
                self.hideEmptyView()
            }

            var dic = NSDictionary()
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
                self.baseListArr = NSMutableArray()
            }
            
            else
            {
                
            }
            for var i = 0;i < arry.count;i++
            {
                dic = arry .objectAtIndex(i) as NSDictionary
                var houseModel:HWFlightHouseMoel = HWFlightHouseMoel(dic: dic)
                self.baseListArr .addObject(houseModel)
                
            }
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
    //MARK:搜索
     func customerSearchView(customerSearchView: CustomSearchView!, passZone zoneId: String!, plateId: String!)
     {
        areaId = zoneId
        currentPage = 1
        self .queryListData()
     }
    //创建测试数据
    func createTestData()->Void
        {
            //            "houseId":"",       --房源ID
            //            "houseName":"",     --房源名称
            //            "houseAddress":"",  --房源位置([区域-板块])
            //            "housesStatus":""   --状态（0未报备，1已报备）
            var houseModel1:HWFlightHouseMoel = HWFlightHouseMoel();
            houseModel1.houseId = "";
            houseModel1.houseName = "z红海的劳动力的到来";
            houseModel1.houseAddress = "宝山万达";
            houseModel1.housesStatus = "1";
            var houseModel2:HWFlightHouseMoel = HWFlightHouseMoel();
            houseModel2.houseId = "";
            houseModel2.houseName = "z红海的劳动力的到来2";
            houseModel2.houseAddress = "宝山万达2";
            houseModel2.housesStatus = "0";
            var houseModel3:HWFlightHouseMoel = HWFlightHouseMoel();
            houseModel3.houseId = "";
            houseModel3.houseName = "z红海的劳动力的到来3";
            houseModel3.houseAddress = "宝山万达3";
            houseModel3.housesStatus = "0";
            var houseModel4:HWFlightHouseMoel = HWFlightHouseMoel();
            houseModel4.houseId = "";
            houseModel4.houseName = "z红海的劳动力的到来4";
            houseModel4.houseAddress = "宝山万达4";
            houseModel4.housesStatus = "1";
            self.baseListArr.addObject(houseModel1);
            self.baseListArr.addObject(houseModel2);
            self.baseListArr.addObject(houseModel3);
            self.baseListArr.addObject(houseModel4);
            self.baseTable .reloadData();

    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
            let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as HWFlightHouseTableViewCell 
            cell.setFlightHouseInfo(self.baseListArr.objectAtIndex(indexPath.row) as HWFlightHouseMoel);
            var selectedCustomer:HWFlightHouseMoel = self.baseListArr.objectAtIndex(indexPath.row) as HWFlightHouseMoel;
                cell.selectFlightFunc = {
            (selectFlag:Bool)->Void in
            print(selectFlag);
            var selectedCustomer:HWFlightHouseMoel = self.baseListArr.objectAtIndex(indexPath.row) as HWFlightHouseMoel;
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
            self.delegate?.selectedFlightHouseS(self.selectedCustomerArry);
           
        };
        cell.contentView.drawBottomLine();
        
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
            return 60 * kRate
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        
          self.flightHouseSQuest(self.baseListArr.pObjectAtIndex(indexPath.row) as HWFlightHouseMoel, index: indexPath.row)
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.baseListArr.count;
    }
    //MARK:-报备楼盘
    func flightHouseSQuest(houseModel:HWFlightHouseMoel,index:NSNumber)->Void
    {
        
    }

}
