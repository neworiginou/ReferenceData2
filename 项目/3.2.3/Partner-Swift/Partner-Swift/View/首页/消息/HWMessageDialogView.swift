//
//  HWMessageDialogView.swift
//  Partner-Swift
//
//  Created by caijingpeng.haowu on 15/3/4.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

enum DialogType : Int
{
    case Admin
    case System
    case Hi
}

class HWMessageDialogView: HWBaseRefreshView {
    
    var type: DialogType = DialogType.Admin
    
    var msgListModel: HWMessageListModel?
    var addressStr: String = "地址加载中..."
    var tempMsgModel: HWMessageDialogModel?
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        /*
        "messageId":"" --消息ID
        "brokerId":""  --经纪人ID
        "picKey":""    --头像
        "publisher":"" --发布人
        "publishTime":"" --时间[yyyy-MM-dd HH:mm:ss]
        "title":""   --标题[仅限集结号]
        "content":"" --消息内容
        "msgType":"" 消息类型[hi,admin,system]
        "reply":""  --0发布，1回复(默认0)
        */
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reverseGeocodeNotification:", name: kReverseGeocodeNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "locationSuccess:", name: kLocationSuccessNotification, object: nil)
        
        self.backgroundColor = UIColor.whiteColor()
        self.baseTable.registerClass(HWMessageDialogRightCell.self, forCellReuseIdentifier: HWMessageDialogRightCell.getIdentify())
        self.baseTable.registerClass(HWMessageDialogLeftCell.self, forCellReuseIdentifier: HWMessageDialogLeftCell.getIdentify())
        
        self.isLastPage = true
        self.setIsNeedHeadRefresh(false)
//        self.initialTableViewHeader()
        
    }
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: kReverseGeocodeNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: kLocationSuccessNotification, object: nil)
    }
    
    func locationSuccess(notification: NSNotification) -> Void
    {
        self.baseTable.reloadData()
    }
    
    
    
    func reverseGeocodeNotification(notification: NSNotification) -> Void
    {
//        println(notification.userInfo)
        let userInfo: NSDictionary = notification.userInfo!
        addressStr = userInfo.stringObjectForKey("address")
        
        self.baseTable.reloadData()
    }
    
    override func beginToReloadData(aRefreshPos: EGORefreshPos)
    {
        isHeadLoading = true;
        
        if (aRefreshPos.value == EGORefreshHeader.value)
        {
            // pull down to refresh data
            currentPage++
        }
        
        self.reloadTableViewDataSource()
    }
    
    override func queryListData()
    {
        /*
            /login/getMsgDetail.do
        
        */
        
        Utility.showMBProgress(self, _message: "发送中")
        
        let manager = HWHttpRequestOperationManager.baseManager()
        var param: NSMutableDictionary = NSMutableDictionary()
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param.setPObject(msgListModel?.messageId, forKey: "messageId")
        param.setPObject(msgListModel?.source, forKey: "source")
//        param.setPObject("\(currentPage)", forKey: "pageNumber")
//        param.setPObject("\(kPageCount)", forKey: "pageSize")
        // 无分页
        manager.postHttpRequest(kMessageDetail, parameters: param, queue: nil, success: { (responseObject) -> Void in
//            println(responseObject)
            Utility.hideMBProgress(self)
            let dict: NSDictionary = responseObject as NSDictionary
            let dataArr: NSArray = dict.arrayObjectForKey("data")
            
//            if (self.currentPage == 1)
//            {
                self.baseListArr.removeAllObjects()
//            }
            
            
            
            for var i = 0; i < dataArr.count; i++
            {
                let message = HWMessageDialogModel(messageInfo: dataArr.objectAtIndex(i) as NSDictionary)
                self.baseListArr.insertObject(message, atIndex: 0)
                
                if (message.brokerId.isEqualToString(HWUserLogin.currentUserLogin().brokerId) == false)
                {
                    self.tempMsgModel = message
                }
                
            }

            self.baseTable.reloadData()
            self.doneLoadingTableViewData()
//            self.initialTableViewHeader()
            
            if (self.baseTable.contentSize.height - self.baseTable.frame.size.height > 0)
            {
                self.baseTable.contentOffset = CGPointMake(0, self.baseTable.contentSize.height - self.baseTable.frame.size.height)
            }
            
            
        }) { (code, error) -> Void in
//            println(code + error)
            Utility.hideMBProgress(self)
            Utility.showToastWithMessage(error, _view: self)
        }
        
    }

    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func sendHi() -> Void
    {
        /*
        /personalCenter/hiBroker.do
        
        key,
        brokerId:*** - 被Hi的经纪人id
        */
        
        Utility.showMBProgress(self, _message: "发送中")
        
        var location: CLLocationCoordinate2D? = HWLocationManager.shareManager().coordinate
        
        if (location == nil)
        {
            Utility.hideMBProgress(self)
            Utility.showToastWithMessage("定位失败, 不能发送", _view: self)
            return
        }
        
        let manager = HWHttpRequestOperationManager.baseManager()
        var param: NSMutableDictionary = NSMutableDictionary()
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param.setPObject("\(location!.latitude)", forKey: "latitude")
        param.setPObject("\(location!.longitude)", forKey: "longitude")
        param.setPObject(msgListModel?.messageId, forKey: "messageId")
        param.setPObject("HI", forKey: "message")
        param.setPObject("hi", forKey: "source")
        
        
        manager.postHttpRequest(kMessageReply, parameters: param, queue: nil, success: { (responseObject) -> Void in
    
            Utility.hideMBProgress(self)
            self.queryListData()
    
        }) { (code, error) -> Void in
        
            Utility.hideMBProgress(self)
            Utility.showToastWithMessage(error, _view: self)
        }
        
    }
    
    func toCallPhone()
    {
        if (self.msgListModel?.brokerPhone.length > 0)
        {
            Utility.callPhone(self.msgListModel?.brokerPhone)
        }
        else
        {
            Utility.showToastWithMessage("无电话号码", _view: self)
        }
    }
    
    override func drawRect(rect: CGRect)
    {
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_after(1, queue) { () -> Void in
            self.queryListData()
        }
    }
    
    func initialTableViewSectionHeader() -> UIView?
    {
        if (type != DialogType.Hi)
        {
            return nil
        }
        let headerView = UIView(frame: CGRectMake(0, 0, kScreenWidth, 70))
        headerView.backgroundColor = UIColor.whiteColor()
//        self.baseTable.tableHeaderView = headerView
        
        var flag = false
        for (var i = 0; i < self.baseListArr.count; i++)
        {
            let message: HWMessageDialogModel = self.baseListArr.pObjectAtIndex(i) as HWMessageDialogModel
            if (message.brokerId.isEqualToString(HWUserLogin.currentUserLogin().brokerId))
            {
                flag = true
                break
            }
        }
        
        let topView: UIView = UIView(frame: CGRectMake(0, 0, kScreenWidth, 45))
        topView.drawBottomLine()
        headerView.addSubview(topView)
        if (flag)
        {
            //  有回复 显示电话
            let nameLabel = UILabel(frame: CGRectMake(15, 0, CGRectGetWidth(topView.frame) - 15 - 60, CGRectGetHeight(topView.frame)))
            nameLabel.textColor = CD_Txt_Color_00
            nameLabel.text = "\(msgListModel?.publisher as String) \(msgListModel?.brokerPhone as String)" // 问题 消息无电话
            nameLabel.font = Define.font(TF_Text_15)
            topView.addSubview(nameLabel)
            
            let button: UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
            button.frame = CGRectMake(kScreenWidth - 60, 0, 60, 45)
            button.setImage(UIImage(named: "phone2"), forState: UIControlState.Normal)
            button.addTarget(self, action: "toCallPhone", forControlEvents: UIControlEvents.TouchUpInside)
            topView.addSubview(button)
        }
        else
        {
            // 不显示电话
            let nameLabel = UILabel(frame: CGRectMake(0, 0, CGRectGetWidth(topView.frame), CGRectGetHeight(topView.frame)))
            nameLabel.textColor = CD_Txt_Color_66
            nameLabel.textAlignment = NSTextAlignment.Center
            nameLabel.text = "HI一下可以看到对方手机号"
            nameLabel.font = Define.font(TF_Text_15)
            topView.addSubview(nameLabel)
        }
        
        let bottomView = UIView(frame: CGRectMake(0, 45, kScreenWidth, 30))
        bottomView.drawBottomLine()
        headerView.addSubview(bottomView)
        
        let imgV: UIImageView = UIImageView(frame: CGRectMake(15, 15 / 2.0, 10, 15))
        imgV.image = UIImage(named: "map_2")
        bottomView.addSubview(imgV)
        
        let addressLabel: UILabel = UILabel(frame: CGRectMake(CGRectGetMaxX(imgV.frame) + 8, 0, kScreenWidth - (CGRectGetMaxX(imgV.frame) + 8) - 15, 30))
        addressLabel.textColor = CD_Txt_Color_66
        
        
        
        var targetCoor: CLLocationCoordinate2D = CLLocationCoordinate2DMake(0, 0)
        if (tempMsgModel != nil)
        {
            let latitude: NSString = tempMsgModel!.latitude
            let longitude: NSString = tempMsgModel!.longitude
            targetCoor = CLLocationCoordinate2DMake(latitude.doubleValue, longitude.doubleValue)
        }
        
//        println("model \(msgListModel!.latitude) \(msgListModel!.longitude)")
//        println("target \(targetCoor.latitude) \(targetCoor.longitude)")
        
        if (addressStr == "地址加载中...")
        {
            Utility.reverseGeocodeLocation(targetCoor)
        }
        
        var distance: String = Utility.calculateDistanceCoordinateFrom(targetCoor, to: HWLocationManager.shareManager().coordinate)
        
        if (HWLocationManager.shareManager().coordinate == nil)
        {
            addressStr = "定位失败"
            distance = "0"
        }
        
        addressLabel.text = "\(addressStr) 距：\(distance)"
        addressLabel.font = Define.font(TF_14)
        bottomView.addSubview(addressLabel)
        
        return headerView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        if (type != DialogType.Hi)
        {
            return 0;
        }
        return 75;
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        return self.initialTableViewSectionHeader()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        let message: HWMessageDialogModel = self.baseListArr.pObjectAtIndex(indexPath.row) as HWMessageDialogModel
        if (message.brokerId.isEqualToString(HWUserLogin.currentUserLogin().brokerId))
        {
            // 用户发送
            return HWMessageDialogRightCell.getCellHeight(message)
        }
        else
        {
            //
            return HWMessageDialogLeftCell.getCellHeight(message)
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.baseListArr.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let message: HWMessageDialogModel = self.baseListArr.pObjectAtIndex(indexPath.row) as HWMessageDialogModel
        
        if (message.brokerId.isEqualToString(HWUserLogin.currentUserLogin().brokerId))
        {
            // 发布
            let cell = tableView.dequeueReusableCellWithIdentifier(HWMessageDialogRightCell.getIdentify(), forIndexPath: indexPath) as HWMessageDialogRightCell
            cell.setMessageDialogRight(message)
            
//            cell.contentView.drawBottomLine()
            return cell
        }
        else
        {
            // 回复
            let cell = tableView.dequeueReusableCellWithIdentifier(HWMessageDialogLeftCell.getIdentify(), forIndexPath: indexPath) as HWMessageDialogLeftCell
            cell.setMessageDialogLeft(message)
//            cell.contentView.drawBottomLine()
            return cell
        }
        
    }

}
