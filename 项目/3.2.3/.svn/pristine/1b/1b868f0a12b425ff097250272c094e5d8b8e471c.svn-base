//
//  HWSubordinateDetailRefreshView.swift
//  Partner-Swift
//
//  Created by hw500029 on 15/2/26.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

protocol HWSubordinateDetailDelegate:NSObjectProtocol
{
    func didSelectedCustomer(clientInfoId:NSString, clientType:NSString) ->Void
    func fetchTopViewData(name:NSString, phoneNum:NSString, customerNum:NSString, achievement:NSString,imgUrl:NSString) ->Void
}

class HWSubordinateDetailRefreshView: HWBaseRefreshView,UITableViewDelegate,UITableViewDataSource,HWCustomAlertViewDelegate{

    var delegate:HWSubordinateDetailDelegate?
    
    var topView:HWSubordinateRefreshTopView?
    var brockerID:NSString?
    
    var parmaUrl = kSubordinateDetail
    
    var topLine:UIView?
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
//        topView = HWSubordinateRefreshTopView(frame: CGRectMake(0, 0, kScreenWidth, 140 * kScreenRate))
//        self.addSubview(topView!)
//        topView?.editBtn?.addTarget(self, action: "showNickNameEditView", forControlEvents: UIControlEvents.TouchUpInside)
        
        //self.baseTable.frame = CGRectMake(0, 140 * kScreenRate, kScreenWidth, self.bounds.size.height - 140 * kScreenRate)
        self.baseTable.frame = CGRectMake(0, 10 * kScreenRate, kScreenWidth, self.bounds.size.height - 10 * kScreenRate)
        self.baseTable.separatorStyle = UITableViewCellSeparatorStyle.None;
        
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
        
        //self.queryListData()
    }
  
    //编辑下限昵称
    func showNickNameEditView()
    {
        let al = HWCustomAlertView(type: AlertViewType.EditNickName)
        shareAppDelegate.window?.addSubview(al)
        al.delegate = self
        al.showAnimate()
    }

    //
    override func queryListData() {
        var parma = NSMutableDictionary()
        parma.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        //parma.setPObject("1000002484369", forKey: "brokerId")
        parma.setPObject("\(currentPage)", forKey: "pageNumber")
        parma.setPObject("\(kPageCount)", forKey: "pageSize")

        parma.setPObject(brockerID, forKey: "brokerId")
        var manager = HWHttpRequestOperationManager.baseManager()
        manager.postHttpRequest(parmaUrl, parameters: parma, queue: nil, success:
            { (responseObject) -> Void in
                
//                println("responseObject ================= \(responseObject)")

                var responseDic = responseObject as NSDictionary
                var dataDic = responseDic.dictionaryObjectForKey("data") as NSDictionary
            
                var brokerName = dataDic.stringObjectForKey("brokerName")
                var brokerPhone = dataDic.stringObjectForKey("brokerPhone")
                var singleResult = dataDic.stringObjectForKey("singleResult")
                var picKey = dataDic.stringObjectForKey("picKey")
                var clientNum = dataDic.stringObjectForKey("clientNum")
                //topView刷新数据
                self.delegate?.fetchTopViewData(brokerName, phoneNum: brokerPhone, customerNum: clientNum, achievement: singleResult,imgUrl:picKey)
                
                var arrDic = dataDic.dictionaryObjectForKey("pageInfo")
                var dataArr = arrDic.arrayObjectForKey("data")
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
    
    func ConfirmInPut(content: NSString) {
//        println("发送编辑下线姓名请求")
        topView?.nameLabel?.text = content
        
        var parma = NSMutableDictionary()
        parma.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        parma.setPObject(content, forKey: "nameComment")
        //parma.setPObject("1000002484369", forKey: "brokerId")
        parma.setPObject(brockerID, forKey: "brokerId")
        var manager = HWHttpRequestOperationManager.baseManager()
        manager.postHttpRequest(kSubordinateChangeNickName, parameters: parma, queue: nil, success:
            { (responseObject) -> Void in
//                println("responseObject ============== \(responseObject)")
                
               self.queryListData()
                
            }) { (failure, error) -> Void in
                
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
        
        delegate?.didSelectedCustomer(model.clientInfoID!,clientType:model.clientType)
        

    }

    func call(sender:UIButton)
    {
        
        var model:HWBrokerCumModel = self.baseListArr.pObjectAtIndex(sender.tag - 100) as HWBrokerCumModel
        
        var phoneNum:NSString = ""
        phoneNum = model.clientPhone!
        if phoneNum.isEqualToString("") || phoneNum == Optional.None
        {
            Utility.showAlertWithMessage("电话号码无效")
        }
        else
        {
            var callWebView = UIWebView()
            self.addSubview(callWebView)
            var telUrl = NSURL(string: "tel:\(phoneNum)")
            callWebView.loadRequest(NSURLRequest(URL: telUrl!))
        }

        
        
        
//        var model:HWBrokerCumModel = self.baseListArr.pObjectAtIndex(sender.tag - 100) as HWBrokerCumModel
//        var phoneNum = model.clientPhone
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
