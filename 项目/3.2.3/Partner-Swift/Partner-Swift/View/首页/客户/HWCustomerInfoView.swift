//
//  HWCustomerInfoView.swift
//  Partner-Swift
//
//  Created by gusheng on 15/2/21.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

enum ClientSelectMode : Int
{
    case Single             // 单选
    case Multiplicity       // 多选
    case None               // 不能选择
}

enum ClientSource : Int
{
    case Normal            // 正常客户列表
    case NewHouseRelate     // 新房关联 客户
    case SecondHouseRelate  // 二手房关联客户
    case Schedule           // 新建日程 关联客户
}

@objc protocol HWCustomerInfoViewDelegate: NSObjectProtocol
{
    func didSelectedCustomer(customerArr: NSArray?) -> Void
    optional func didClickNewScheduleByClient(client: HWClientModel) -> Void
}
class HWCustomerInfoView: HWBaseRefreshView,HWCustomerInfoDelegate,SWTableViewCellDelegate
{
    weak var delegate: HWCustomerInfoViewDelegate?
    var selectMode: ClientSelectMode = ClientSelectMode.None
    var sourceMode: ClientSource = ClientSource.Normal
    var selectedArray: NSMutableArray? = NSMutableArray()
    
    // 筛选参数
    var searchKey: NSString?
    var searchFilterIndex: NSString?
    var searchFilterSecond:NSString?
    var houseId: NSString?      //  新房已报备客户 需要传参 二手房也用到
    
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.setIsNeedHeadRefresh(true)
        
        /*  二手房 关联客户
        "clientInfoId":"",            - 经纪人客户ID
        "clientName":"",                - 客户姓名
        "clientPhone":"",               - 客户电话
        "clientSourceWay":"",           - 客户来源
        "clientIntention":"",           - 客户意向
        "houseName":"",                 - 房源名称
        "houseState":"",                - 房源状态
        "houseType":"",                 - 房源类型（newHouse 新房,secondHouse 二手房）
        "lastChangeTime":"",            - 最后状态发生变化的时间(yyyy-MM-dd HH:mm:ss)
        "visitedProtectDaysRemind":"",  - 到访保护期剩余天数(默认为-1，为-1不提醒,等于0为过到访保护期，大于0为剩余保护期天数)
        "isUp":""                       - 是否置顶(0不置顶，1置顶)
        */
        /*
        let house1 = HWClientModel(clientInfo: NSDictionary(objectsAndKeys:
            "33","clientInfoId",
            "客户姓名","clientName",
            "客户电话","clientPhone",
            "客户来源","clientSourceWay",
            "客户意向","clientIntention",
            "房源名称","houseName",
            "0","houseState",
            "newHouse","houseType",
            "最后状态发生变化的时间", "lastChangeTime",
            "3", "visitedProtectDaysRemind",
            "0","isUp"))
        
        let house2 = HWClientModel(clientInfo: NSDictionary(objectsAndKeys:
                "33","clientInfoId",
                "客户姓名","clientName",
                "客户电话","clientPhone",
                "客户来源","clientSourceWay",
                "客户意向","clientIntention",
                "房源名称","houseName",
                "21","houseState",
                "secondHouse","houseType",
                "最后状态发生变化的时间", "lastChangeTime",
                "到访保护期剩余天数","visitedProtectDaysRemind",
                "1","isUp"))
        
        self.baseListArr = NSMutableArray(objects: house1, house2)
        self.baseTable.reloadData()
        */
        //self.showEmptyView("无网络无网络无网络无网络无网络")
        
    }
    
    override func drawRect(rect: CGRect)
    {
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_after(1, queue) { () -> Void in
            self.queryListData()
        }
        
    }
    
    func setSearchKey(key: NSString) -> Void
    {
        self.searchKey = key
        self.searchFilterIndex = ""
        searchFilterSecond = ""
        self.queryListData()
    }
    
    func setSearchFilterIndex(index: NSInteger) -> Void
    {
        self.searchFilterIndex = "\(index)"
        self.searchKey = ""
        self.queryListData()
    }
    func setSearchFilterFirstAndSecond(firstId:NSString,secondId:NSString)
    {
        self.searchFilterIndex = secondId;
        self.searchFilterSecond = firstId;
        self.searchKey = ""
        self.queryListData()
    }
    
    override func queryListData()
    {
        if (sourceMode == ClientSource.Normal || sourceMode == ClientSource.Schedule)
        {
            self.normalQueryListData()
        }
        else if (sourceMode == ClientSource.NewHouseRelate)
        {
            self.newHouseQueryListData()
        }
        else if (sourceMode == ClientSource.SecondHouseRelate)
        {
            self.secondHouseQueryListData()
        }
//        else if (sourceMode == ClientSource.Schedule)
//        {
//            self.scheduleNormalQueryListData()
//        }
    }
    
    func normalQueryListData()
    {
        /*
        key: ***   --用户key
        clientType: *** --客户类别(0默认，11已报备，12已到访，13已下定，14已成交，21下线客户，22分享客户，23合作客户，24抢到客户，31无意向客户)
        searchKeyword: *** --搜索关键字
        page: ***   --请求页码,从0开始
        size: ***   --请求条数
*/
        Utility.hideMBProgress(self);
        Utility.showMBProgress(self, _message: "加载中")
        
        var param: NSMutableDictionary = NSMutableDictionary()
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param.setPObject(searchFilterIndex, forKey: "clientType")
        param.setPObject(searchFilterSecond, forKey: "clientBigType");
        param.setPObject(searchKey, forKey: "searchKeyword")
        param.setPObject("\(currentPage)", forKey: "pageNumber")
        param.setPObject("\(kPageCount)", forKey: "pageSize")
        
        let manager = HWHttpRequestOperationManager.baseManager()
        manager.postHttpRequest(kClientList, parameters: param, queue: nil, success: { (responseObject) -> Void in
            
            Utility.hideMBProgress(self)
//            println(responseObject)
            
            let resultArray: NSArray = responseObject.arrayObjectForKey("data") as NSArray
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
                let model: HWClientModel = HWClientModel(clientInfo: dic)
                modelArray.addObject(model)
            }
            
            self.baseListArr.addObjectsFromArray(modelArray)
            
            self.baseTable.reloadData()
            self.doneLoadingTableViewData()
            
            if(self.baseListArr.count == 0)
            {
                self.showEmptyView("暂无客户")
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
    
    func newHouseQueryListData()
    {
        /*
        /newHouse/clientList.do
            key: ***   --用户key
            clientType: *** --客户类别(0默认，11已报备，12已到访，13已下定，14已成交，21下线客户，22分享客户，23合作客户，24抢到客户，31无意向客户)
            searchKeyword: *** --搜索关键字
            houseId: ***  --房源ID
            page: ***   --请求页码,从0开始
            size: ***   --请求条数
            */
        Utility.showMBProgress(self, _message: "加载中")
            
        var param: NSMutableDictionary = NSMutableDictionary()
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param.setPObject(searchFilterIndex, forKey: "clientType")
        param.setPObject(searchFilterSecond, forKey: "clientBigType")
        param.setPObject(searchKey, forKey: "searchKeyword")
        param.setPObject(houseId, forKey: "projectId")
        param.setPObject("\(currentPage)", forKey: "pageNumber")
        param.setPObject("\(kPageCount)", forKey: "pageSize")
        
        let manager = HWHttpRequestOperationManager.baseManager()
        manager.postHttpRequest(kClinetNewList, parameters: param, queue: nil, success: { (responseObject) -> Void in
                
            Utility.hideMBProgress(self)
//            println(responseObject)
            
            let resultArray: NSArray = responseObject.arrayObjectForKey("data") as NSArray
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
                let model: HWClientModel = HWClientModel(clientInfo: dic)
                modelArray.addObject(model)
            }
            
            self.baseListArr.addObjectsFromArray(modelArray)
            
            self.baseTable.reloadData()
            self.doneLoadingTableViewData()
            
            if(self.baseListArr.count == 0)
            {
                self.showEmptyView("暂无客户")
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
    
    func secondHouseQueryListData()
    {
        /*
        scdHandHouse/clientInfoList.do
        key:*** --用户key
        id:*** --二手房ID
        clientType: *** --客户类别(0默认，11已报备，12已到访，13已下定，14已成交，21下线客户，22分享客户，23合作客户，24抢到客户，31无意向客户)
        searchKeyword: *** --搜索关键字
        page: **** --请求页
        size: **** --请求条数*/
        Utility.showMBProgress(self, _message: "加载中")
                    
        var param: NSMutableDictionary = NSMutableDictionary()
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param.setPObject(searchFilterIndex, forKey: "clientType")
        param.setPObject(searchFilterSecond, forKey: "clientBigType")
        param.setPObject(searchKey, forKey: "searchKeyword")
        if(self.selectMode == ClientSelectMode.Multiplicity)
        {
            param.setPObject(houseId, forKey: "secondHouseId")
        }
        param.setPObject("\(currentPage)", forKey: "pageNumber")
        param.setPObject("\(kPageCount)", forKey: "pageSize")
        param.setPObject("secondHouseList", forKey: "useWay")
        
        let manager = HWHttpRequestOperationManager.baseManager()
        manager.postHttpRequest(kClientList, parameters: param, queue: nil, success: { (responseObject) -> Void in
            
            Utility.hideMBProgress(self)
            let resultArray: NSArray = responseObject.arrayObjectForKey("data") as NSArray
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
                let model: HWClientModel = HWClientModel(clientInfo: dic)
                modelArray.addObject(model)
            }
            
            self.baseListArr.addObjectsFromArray(modelArray)
            
            self.baseTable.reloadData()
            self.doneLoadingTableViewData()
            
            if(self.baseListArr.count == 0)
            {
                self.showEmptyView("暂无客户")
            }
            else
            { 
                self.hideEmptyView()
            }
            
        }) { (code, error) -> Void in
                        
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
    
//    func scheduleNormalQueryListData()
//    {
//        Utility.showMBProgress(self, _message: "加载中")
//            
//        var param: NSMutableDictionary = NSMutableDictionary()
//        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
//        param.setPObject(searchFilterIndex, forKey: "clientType")
//        param.setPObject(searchKey, forKey: "searchKeyword")
//        param.setPObject("\(currentPage)", forKey: "page")
//        param.setPObject("\(kPageCount)", forKey: "size")
//            
//        let manager = HWHttpRequestOperationManager.baseManager()
//        manager.postHttpRequest(kClientList, parameters: param, queue: nil, success: { (responseObject) -> Void in
//                
//            Utility.hideMBProgress(self)
//                
//            }) { (code, error) -> Void in
//                
//            Utility.hideMBProgress(self)
//        }
//    }
    
    //MARK:--tableView delegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return HWCutomerTableViewCell.getCellHeight()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.baseListArr.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let model: HWClientModel = self.baseListArr.pObjectAtIndex(indexPath.row) as HWClientModel
        tableView.registerClass(HWCutomerTableViewCell.self, forCellReuseIdentifier: HWCutomerTableViewCell.getIdentify())
        
        var cell: HWCutomerTableViewCell = tableView.dequeueReusableCellWithIdentifier(HWCutomerTableViewCell.getIdentify(), forIndexPath: indexPath) as HWCutomerTableViewCell
        
        cell.setClientModel(model, sourceType: self.sourceMode)
        cell.delegate = self
        cell.customerDelegate = self
        cell.contentView.drawBottomLine()
        
        if (selectMode != ClientSelectMode.None)
        {
            if (self.isContain(model, inArray: selectedArray!) == true)
            {
                cell.chosenImg.image = UIImage(named: "choose_3_2-")
            }
            else
            {
                cell.chosenImg.image = UIImage(named: "choose_3_1")
            }
        }
        else
        {
            cell.chosenImg.hidden = true
        }
        
        return cell;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let client: HWClientModel = self.baseListArr.pObjectAtIndex(indexPath.row) as HWClientModel
        var cell = self.baseTable.cellForRowAtIndexPath(indexPath) as HWCutomerTableViewCell
        
        if (selectMode != ClientSelectMode.None)
        {
            if (self.selectMode == ClientSelectMode.Multiplicity)
            {
                // 多选
                if (self.isContain(client, inArray: selectedArray!) == true)
                {
                    cell.chosenImg.image = UIImage(named: "choose_3_1")
                    self.delModel(client)
                }
                else
                {
                    cell.chosenImg.image = UIImage(named: "choose_3_2-")
                    selectedArray?.addObject(client)
                }
            }
            else
            {
                selectedArray?.removeAllObjects()
                selectedArray?.addObject(client)
            }
        }
        else
        {
            cell.chosenImg.hidden = true
            selectedArray?.removeAllObjects()
            selectedArray?.addObject(client)
        }
        
        if (delegate != nil && delegate?.respondsToSelector("didSelectedCustomer:") == true)
        {
            delegate?.didSelectedCustomer(selectedArray)
        }
    }
    
    func swipeableTableViewCell(cell: SWTableViewCell!, didTriggerRightUtilityButtonWithIndex index: Int)
    {
        var indexPath: NSIndexPath? = self.baseTable.indexPathForCell(cell)
        
        if (indexPath == nil)
        {
            return
        }
        
        var client: HWClientModel? = self.baseListArr.pObjectAtIndex(indexPath!.row) as? HWClientModel
        
        if (client == nil)
        {
            return
        }
        
        if index == 0
        {
            // 日程
            
            if (delegate != nil && delegate?.respondsToSelector("didClickNewScheduleByClient:") == true)
            {
                delegate?.didClickNewScheduleByClient!(client!)
            }
        }
        else
        {
            // 置顶
            MobClick .event("Top_click")
            
            Utility.showMBProgress(self, _message: "加载中")
            
            let manager = HWHttpRequestOperationManager.baseManager()
            var param: NSMutableDictionary = NSMutableDictionary()
            param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
            param.setPObject(client?.clientInfoId, forKey: "clientInfoId")
            
            if (client?.isUp.isEqualToString("1") == true)
            {
                param.setPObject("0", forKey: "isUp")
            }
            else
            {
                param.setPObject("1", forKey: "isUp")
            }
            
            manager.postHttpRequest(kClientUp, parameters: param, queue: nil, success: { (responseObject) -> Void in
                
                Utility.hideMBProgress(self)
                self.refreshData()
                
            }, failure: { (code, error) -> Void in
                
                Utility.hideMBProgress(self)
                Utility.showToastWithMessage(error, _view: self)
            })
        }
    }
    
    func phoneClick(phoneNum: NSString)
    {
        
    }
    
    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews()
    {
        super.layoutSubviews();
    }
    
    func isContain(model: HWClientModel, inArray array: NSArray) -> Bool
    {
        for (var i = 0; i < array.count; i++)
        {
            var tempModel: HWClientModel = array.pObjectAtIndex(i) as HWClientModel
            if (model.clientInfoId.isEqualToString(tempModel.clientInfoId))
            {
                return true
            }
        }
        return false
    }
    
    func delModel(model: HWClientModel)
    {
        for (var i = 0; i < selectedArray?.count; i++)
        {
            var tempModel: HWClientModel = selectedArray?.pObjectAtIndex(i) as HWClientModel
            if (model.clientInfoId.isEqualToString(tempModel.clientInfoId))
            {
                selectedArray?.removeObject(tempModel)
                i--;
            }
        }
    }

}
