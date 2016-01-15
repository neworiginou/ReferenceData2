//
//  HWDynamicDetailView.swift
//  Partner-Swift
//
//  Created by hw500027 on 15/3/4.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

protocol HWDynamicDetailViewDelegate:NSObjectProtocol
{
    func toPopVC()
}

class HWDynamicDetailView: HWBaseRefreshView,HWDynamicDetailCellDelegate,UIAlertViewDelegate
{
    weak var dynamicDetailViewDelegate:HWDynamicDetailViewDelegate?
    
    var _footerView:UIView!
    var _dynamicId:NSString? = ""
    var _dic:NSDictionary?
    var _pendingState:pendingState!
    
    init(frame:CGRect,id:NSString,status:pendingState)
    {
        super.init(frame: frame)
        self._dynamicId = id
        self._pendingState = status
        self.setIsNeedHeadRefresh(false)
        
        var headerView = UIView(frame: CGRectMake(0, 0, kScreenWidth, 10 * kRate))
        headerView.drawBottomLine()
        self.baseTable.tableHeaderView = headerView
        
        self.baseTable.registerClass(HWChanceDetailCell.self, forCellReuseIdentifier: "cell")
    
        self.baseTable.registerClass(HWDynamicDetailCell.self, forCellReuseIdentifier: "cell1")

        self.queryListData()
    }

    //加载动态详情
    override func queryListData()
    {
        Utility.showMBProgress(self, _message: "请求中")
        let manager = HWHttpRequestOperationManager.baseManager()
        
        self._dic = NSDictionary()
        var param = NSMutableDictionary()
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param.setPObject("\(self._dynamicId!)", forKey: "id")
        
        manager.postHttpRequest(kDynamicDetail, parameters: param, queue: nil, success:
            { (responseObject) -> Void in
                Utility.hideMBProgress(self)
                self._dic = responseObject.dictionaryObjectForKey("data")
                self.baseTable.reloadData()
            }, failure:
            { (code, error) -> Void in
                Utility.hideMBProgress(self)
                Utility.showToastWithMessage(error, _view: self)
        })
    }
    
    //MARK:--tableView delegate
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if (section == 0)
        {
            return 2
        }
        return 1
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        
        if(_dic == nil)
        {
            return 2;
        }
        else
        {
            var sourceStr:NSString = self._dic?.stringObjectForKey("sourcesWay") as NSString!;
            if(sourceStr.isEqualToString("haowu"))
            {
                return 2;
            }
        }
        
        return 2
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        if (indexPath.section == 0)
        {
            var cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as HWChanceDetailCell
            if (indexPath.row == 0)
            {
                cell._titleLabel.text = "房源"
                cell._detailLabel.text = _dic?.stringObjectForKey("villageName")
            }
            else
            {
                cell._titleLabel.text = "看房时间"
//                println(_dic?.stringObjectForKey("appointmentTime"))
                let time:NSString! = _dic?.stringObjectForKey("appointmentTime")
                cell._detailLabel.text = Utility.getTimeFormattWithTimeStamp(time)  //_dic?.stringObjectForKey("appointmentTime")
            }
            cell.contentView.drawBottomLine()
            return cell
        }
        else
        {
            var cell1 = tableView.dequeueReusableCellWithIdentifier("cell1", forIndexPath: indexPath) as HWDynamicDetailCell
            cell1.dynamicDetailCellDelegate = self
            if (indexPath.row == 0)
            {
//                if (_dic?.stringObjectForKey("isLock") == "yes" && _pendingState == pendingState.pended)
//                {
//                    cell1._phoneLabel.text = "预约时间已过期"
//                    cell1.phoneCantToUnlock()
//                }
//                else 
                //modify by gusheng
//                if (_dic?.stringObjectForKey("isLock") == "yes" && _pendingState == pendingState.pending)
//                {
//                    cell1._phoneLabel.text = "积分解锁"
//                    cell1.phoneBtnToUnlock()
//                }
//                else
//                {
                    cell1._nameLabel.text = _dic?.stringObjectForKey("brokerName")
                    cell1._phoneLabel.text = _dic?.stringObjectForKey("brokerPhone")
                    cell1.phoneBtnFillNumber(_dic?.stringObjectForKey("brokerPhone"))
//                }
                //end by gusheng
                cell1.drawBottomLine()
                //cell1.drawTopLine()
            }
            return cell1
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 45 * kRate
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        if (section == 0)
        {
            if (_dic?.stringObjectForKey("isLock") == "yes")
            {
                return 75
            }
            else
            {
                if (_dic?.stringObjectForKey("message") == nil || _dic?.stringObjectForKey("message") == "")
                {
                    return 75
                }
                else
                {
                    var size = Utility.calculateStringSize(_dic?.stringObjectForKey("message") as NSString!, textFont: Define.font(TF_15), constrainedSize: CGSizeMake(kScreenWidth - 30, 1000))
                    //var size = Utility.calculateStringSize("我的房店动态，留言内容出现省略号.我的房店动态，留言内容出现省略号.我的房店动态，留言内容出现省略号.我的房店动态，留言内容出现省略号.我的房店动态，留言内容出现省略号.我的房店动态，留言内容出现省略号.", textFont: Define.font(TF_15), constrainedSize: CGSizeMake(kScreenWidth - 30, 1000))
                    return 75 + size.height - 15
                }
            }
        }
        else if (section == 1)
        {
            //modify  by gusheng
//            //已处理状态 不显示 同意/拒绝按钮
            if(self._dic?.stringObjectForKey("sourcesWay") != "")
            {
                return 0;
            }
            else
            {
                if (self._dic?.stringObjectForKey("pendingState") == "pended")
                {
                    return 0
                }
                else
                {
                    return 65
                }

            }
                        //end by gusheng
        }
        else
        {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        if (section == 0)
        {
            if (_dic?.stringObjectForKey("isLock") == "yes")
            {
                var view:UIView = UIView(frame: CGRectMake(0, 0, kScreenWidth, 30))
                view.drawBottomLine()
                view.backgroundColor = CD_BackGroundColor
                
                var messageTitle = UILabel(forAutoLayout: ())
                messageTitle.text = "经纪人留言"
                messageTitle.font = Define.font(TF_15)
                view.addSubview(messageTitle)
                
                messageTitle.autoSetDimension(ALDimension.Height, toSize: TF_15)
                messageTitle.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: view, withOffset: serviceCustomerCell_offset_15)
                messageTitle.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: view, withOffset: serviceCustomerCell_offset_15)
                
                
                var messageLabel = UILabel(forAutoLayout: ())
                messageLabel.text = "积分解锁后显示经纪人留言"
                messageLabel.font = Define.font(TF_15)
                messageLabel.textColor = CD_Txt_Color_99
                view.addSubview(messageLabel)
                
                messageLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: messageTitle, withOffset: TF_13)
                messageLabel.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: view, withOffset: serviceCustomerCell_offset_15)
                messageLabel.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Right, ofView: view, withOffset: -serviceCustomerCell_offset_15)
                
                return view
            }
            else
            {
                _footerView = UIView(frame: CGRectMake(0, 0, kScreenWidth, 100))
                //_footerView.drawBottomLine()
                
                var messageTitle = UILabel(forAutoLayout: ())
                messageTitle.text = "经纪人留言"
                messageTitle.font = Define.font(TF_15)
                _footerView.addSubview(messageTitle)
                
                messageTitle.autoSetDimension(ALDimension.Height, toSize: TF_15)
                messageTitle.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: _footerView, withOffset: serviceCustomerCell_offset_15)
                messageTitle.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: _footerView, withOffset: serviceCustomerCell_offset_15)
                
                var messageLabel = UILabel(forAutoLayout: ())
                if (_dic?.stringObjectForKey("message") == nil || _dic?.stringObjectForKey("message") == "")
                {
                    messageLabel.text = "没有留言信息"
                }
                else
                {
                    messageLabel.text = _dic?.stringObjectForKey("message")
                    //messageLabel.text = "我的房店动态，留言内容出现省略号.我的房店动态，留言内容出现省略号.我的房店动态，留言内容出现省略号.我的房店动态，留言内容出现省略号.我的房店动态，留言内容出现省略号.我的房店动态，留言内容出现省略号."
                }
                messageLabel.font = Define.font(TF_15)
                messageLabel.textColor = CD_Txt_Color_99
                messageLabel.numberOfLines = 0
                _footerView.addSubview(messageLabel)
                
                messageLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: messageTitle, withOffset: TF_13)
                messageLabel.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: _footerView, withOffset: serviceCustomerCell_offset_15)
                messageLabel.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Right, ofView: _footerView, withOffset: -serviceCustomerCell_offset_15)
                
                _footerView.frame = CGRectMake(_footerView.frame.origin.x, _footerView.frame.origin.y, _footerView.frame.size.width, _footerView.frame.size.height + messageLabel.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height)
                _footerView.drawBottomLine()
                return _footerView
            }
            
        }
        else if (section == 1)
        {
            //modify by gusheng
            let footView = UIView(frame: CGRectMake(0, 0, kScreenWidth, 65))
            
            //拒绝按钮
            var cancelButton = UIButton(forAutoLayout: ())
            cancelButton.layer.masksToBounds = true
            cancelButton.layer.cornerRadius = 3
            cancelButton.addTarget(self, action: "didClickBtn:", forControlEvents: UIControlEvents.TouchUpInside)
            cancelButton.setBackgroundImage(Utility.imageWithColor(CD_Btn_GrayColor, _size: CGSizeMake(kScreenWidth, 65)), forState: UIControlState.Normal)
            cancelButton.setBackgroundImage(Utility.imageWithColor(CD_Btn_GrayColor_Clicked, _size: CGSizeMake(kScreenWidth, 65)), forState: UIControlState.Highlighted)
            cancelButton.setTitle("拒绝", forState: UIControlState.Normal)
            cancelButton.tag = 1
            footView.addSubview(cancelButton)
            
            cancelButton.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: footView, withOffset: 20)
            cancelButton.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: footView, withOffset: 15)
            cancelButton.autoSetDimension(ALDimension.Height, toSize: 45)
            
            var sureButton = UIButton(forAutoLayout: ())
            sureButton.tag = 2
            sureButton.layer.masksToBounds = true
            sureButton.layer.cornerRadius = 3
            sureButton.addTarget(self, action: "didClickBtn:", forControlEvents: UIControlEvents.TouchUpInside)
            sureButton.setBackgroundImage(Utility.imageWithColor(CD_Btn_MainColor, _size: CGSizeMake(kScreenWidth, 65)), forState: UIControlState.Normal)
            sureButton.setBackgroundImage(Utility.imageWithColor(CD_Btn_MainColor_Clicked, _size: CGSizeMake(kScreenWidth, 65)), forState: UIControlState.Highlighted)
            sureButton.setTitle("同意", forState: UIControlState.Normal)
            sureButton.backgroundColor = CD_Btn_MainColor
            footView.addSubview(sureButton)
            
            sureButton.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: footView, withOffset: 20)
            sureButton.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Right, ofView: footView, withOffset: -15)
            sureButton.autoSetDimension(ALDimension.Height, toSize: 45)
            sureButton.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: cancelButton, withOffset: 20)
            sureButton.autoMatchDimension(ALDimension.Width, toDimension: ALDimension.Width, ofView: cancelButton)
    
            return footView
        }
        else
        {
            return Optional.None
        }
            //end by gusheng
    }
    
    //MARK:--拒绝，同意按钮点击事件
    func didClickBtn(btn:UIButton)
    {
        //拒绝按钮
        if (btn.tag == 1)
        {
            //埋点：我的房店-动态详情 点击拒绝
            MobClick.event("SCDhouse-clientrefuseagree_click")
            
            Utility.showMBProgress(self, _message: "请求中")
            let manager = HWHttpRequestOperationManager.baseManager()
            
//            println(_dic?.stringObjectForKey("id"))
            var param = NSMutableDictionary()
            param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
            param.setPObject(_dic?.stringObjectForKey("id"), forKey: "id")
            
            manager.postHttpRequest(kRefuse, parameters: param, queue: nil, success:
            { (responseObject) -> Void in
                Utility.hideMBProgress(self)
                self.dynamicDetailViewDelegate?.toPopVC()
            }, failure:
            { (code, error) -> Void in
                Utility.hideMBProgress(self)
                Utility.showToastWithMessage(error, _view: self)
            })
        }
        //同意按钮
        else if (btn.tag == 2)
        {
            //已锁状态，弹出提示框
            if(_dic?.stringObjectForKey("isLock") == "yes")
            {
                //埋点：我的房店-动态详情 点击解锁
                MobClick.event("SCDhouse-clientunlock_click")
                
                let messageIntegral = _dic?.stringObjectForKey("integral")
                var alert = UIAlertView(title: "积分解锁", message: "解锁经纪人联系方式\n消费：\(messageIntegral!)积分", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "确认")
                alert.show()
            }
            //同意预约
            else
            {
                //埋点：我的房店-动态详情 点击同意
                MobClick.event("SCDhouse-clientagree_click")
                
                Utility.showMBProgress(self, _message: "请求中")
                let manager = HWHttpRequestOperationManager.baseManager()
                
                var param = NSMutableDictionary()
                param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
                param.setPObject(_dic?.stringObjectForKey("id"), forKey: "id")
                
                manager.postHttpRequest(kAgree, parameters: param, queue: nil, success:
                    { (responseObject) -> Void in
                        Utility.hideMBProgress(self)
                        self.dynamicDetailViewDelegate?.toPopVC()
                    }, failure:
                    { (code, error) -> Void in
                        Utility.hideMBProgress(self)
                        Utility.showToastWithMessage(error, _view: self)
                })
            }
        }
    }
    
    //MARK:--alertView点击事件
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int)
    {
        //点击alertView确认按钮,解锁经纪人
        if (buttonIndex == 1)
        {
            self.toUnlockManager()
        }
    }
    
    //MARK:--解锁经纪人
    //解锁经纪人 请求url 错误
    func toUnlockManager()
    {
        Utility.showMBProgress(self, _message: "请求中")
        let manager = HWHttpRequestOperationManager.baseManager()
        
        var param = NSMutableDictionary()
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param.setPObject(self._dic?.stringObjectForKey("id"), forKey: "id")
        param.setPObject(self._dic?.stringObjectForKey("integral"), forKey: "integral")
        
        manager.postHttpRequest(kUnlockManager, parameters: param, queue: nil, success:
            { (responseObject) -> Void in
                Utility.hideMBProgress(self)
                
                //解锁成功
                if (responseObject.stringObjectForKey("status") == "1")
                {
                    Utility.showToastWithMessage(responseObject.stringObjectForKey("data"), _view: self)
                    sleep(1)
                    self.queryListData()
                }
                //解锁失败
                else
                {
                    Utility.showAlertWithMessage(responseObject.stringObjectForKey("detail"))
                }

            }, failure:
            { (code, error) -> Void in
                Utility.hideMBProgress(self)
                Utility.showToastWithMessage(error, _view: self)
        })
    }
    //MARK:--详情cell代理
    func didUnlockBtn()
    {
        //已锁状态，弹出提示框
        if(_dic?.stringObjectForKey("isLock") == "yes")
        {
            //埋点：我的房店-动态详情 点击解锁
            MobClick.event("SCDhouse-clientunlock_click")
            
            let messageIntegral = _dic?.stringObjectForKey("integral")
            var alert = UIAlertView(title: "积分解锁", message: "解锁经纪人联系方式\n消费：\(messageIntegral!)积分", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "确认")
            alert.show()
        }

        //self.toUnlockManager()
//        _dic?.setValue("no", forKey: "isLock")
//        self.baseTable.reloadData()
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
