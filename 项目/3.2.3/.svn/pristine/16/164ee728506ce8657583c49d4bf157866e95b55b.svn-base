//
//  HWSelectCustomerView.swift
//  Partner-Swift
//
//  Created by gusheng on 15/3/2.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit
protocol selectCustomerNumDelegate
{
    func selectCustomerNum(customerNum:NSString,customerArry:NSMutableArray)->Void;
}
class HWSelectCustomerView:HWBaseRefreshView,UITableViewDataSource,UITableViewDelegate
{
    var dataTable:UITableView! = nil;
    var selectedCustomerArry:NSMutableArray! = nil;
    var dataListArry:NSMutableArray! = nil;
    var delegate:selectCustomerNumDelegate?;
    var totalSelectedFlag:Bool!;
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder);
    }
    override init(frame: CGRect)
    {
        super.init(frame: frame);
        totalSelectedFlag = false;
        selectedCustomerArry = NSMutableArray();
        dataListArry = NSMutableArray();
         self.queryListData();
        self.setUpView(frame);
    }
    func setUpView(frame:CGRect)->Void
    {
        self.userInteractionEnabled = true;
       
    }
    override func queryListData()
    {
        /*
        key: ***   --用户key
        clientType: *** --客户类别(0默认，11已报备，12已到访，13已下定，14已成交，21下线客户，22分享客户，23合作客户，24抢到客户，31无意向客户)
        searchKeyword: *** --搜索关键字
        page: ***   --请求页码,从0开始
        size: ***   --请求条数
*/
        Utility.showMBProgress(self, _message: "加载中")
        
        var param: NSMutableDictionary = NSMutableDictionary()
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param.setPObject("\(currentPage)", forKey: "pageNumber")
        param.setPObject("\(kPageCount)", forKey: "pageSize")
        
        let manager = HWHttpRequestOperationManager.baseManager()
        manager.postHttpRequest(kClientList, parameters: param, queue: nil, success: { (responseObject) -> Void in
            
            Utility.hideMBProgress(self)
//            println(responseObject)
            
            let resultArray: NSArray = responseObject.arrayObjectForKey("data") as NSArray
            if (resultArray.count == 0 && self.currentPage == 1)
            {
                self.baseListArr.removeAllObjects()
                self.showEmptyView("暂无客户")
            }
            else
            {
                self.hideEmptyView()
            }
            
            if (resultArray.count < kPageCount)
            {
                self.isLastPage = true
            }
            else
            {
                self.isLastPage = false
            }
            if(self.currentPage == 1)
            {
                self.baseListArr = NSMutableArray()
                self.selectedCustomerArry  = NSMutableArray();
            }
            else
            {
                
            }
            if(self.totalSelectedFlag == false)
            {
                for (var i = 0; i < resultArray.count; i++)
                {
                    let dic: NSDictionary! = resultArray.pObjectAtIndex(i) as NSDictionary
                    let model: HWClientModel = HWClientModel(clientInfo: dic)
                     model.selectedFlag = false;
                    self.baseListArr.addObject(model)
                }

            }
            if(self.totalSelectedFlag == true)
            {
                for (var i = 0; i < resultArray.count; i++)
                {
                    let dic: NSDictionary! = resultArray.pObjectAtIndex(i) as NSDictionary
                    let model: HWClientModel = HWClientModel(clientInfo: dic)
                    model.selectedFlag = true;
                    self.selectedCustomerArry.addObject(model);
                    self.baseListArr.addObject(model)
                }
              
               self.delegate?.selectCustomerNum("\(self.selectedCustomerArry.count)",customerArry:self.selectedCustomerArry);
            }
            
            else
            {
             self.delegate?.selectCustomerNum("\(self.selectedCustomerArry.count)",customerArry:self.selectedCustomerArry);
            }
            self.baseTable.reloadData()
            self.doneLoadingTableViewData()
            
            
            }) { (code, error) -> Void in
                println("code : \(code) error: \(error)")
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
    //MARK:-UITableViewDelegate方法
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 60.0;
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.baseListArr.count;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        var detailText:NSString;
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        return 0;
    }
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        return nil;
        
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 0.0;
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1;
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell:HWSelectCustomerTableViewCell! = nil;
        let identifyThree = "identifyOne";
        let row:Int = indexPath.row;
        var customerModel:HWClientModel = self.baseListArr.objectAtIndex(indexPath.row)as HWClientModel;
        cell = HWSelectCustomerTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identifyThree);
        cell.didMakeData(customerModel)
        cell.myFunc = {
            (selectFlag:Bool)->Void in
            print(selectFlag);
            var selectedCustomer:HWClientModel = self.baseListArr.objectAtIndex(indexPath.row) as HWClientModel;
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
            self.delegate?.selectCustomerNum("\(rows)",customerArry:self.selectedCustomerArry);
           
        };
        if(customerModel.selectedFlag == true)
        {
            cell.selectImageV .setImage(UIImage(named: "choose_3_2-"), forState: UIControlState.Normal);
        }
        else
        {
             cell.selectImageV .setImage(nil, forState: UIControlState.Normal);
        }
        cell.contentView.drawBottomLine();
        cell.selectionStyle = UITableViewCellSelectionStyle.None;
        return cell;
    }
    func didMakeAll()
    { 
        self.selectedCustomerArry.removeAllObjects()

        self.totalSelectedFlag = true;
              for var i = 0;i < self.baseListArr.count;i++
        {
            var customerModel:HWClientModel = self.baseListArr.objectAtIndex(i)as HWClientModel;
            customerModel.selectedFlag = true
            self.selectedCustomerArry.addObject(customerModel);
        }
        self.baseTable.reloadData()
        self.delegate?.selectCustomerNum("\(self.selectedCustomerArry.count)",customerArry:self.selectedCustomerArry);
        
    }
    func disMakeAll()
    {
        
        self.totalSelectedFlag = false;
        for var i = 0;i < self.baseListArr.count;i++
        {
            var customerModel:HWClientModel = self.baseListArr.objectAtIndex(i)as HWClientModel;
            customerModel.selectedFlag = false
           self.selectedCustomerArry.addObject(customerModel);
        }
        self.baseTable.reloadData()
        self.selectedCustomerArry.removeAllObjects()
        self.delegate?.selectCustomerNum("\(0)",customerArry:self.selectedCustomerArry);
        
    }
    


}
