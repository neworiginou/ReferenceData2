//
//  HWScdHouMakeAppointView.swift
//  Partner-Swift
//
//  Created by niedi on 15/3/10.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：二手房预约看房 mianView
//
//  修改记录：
//      姓名         日期               修改内容
//      聂迪      2015-02-26           UI、数据请求及功能逻辑实现
//

import UIKit

protocol HWScdHouMakeAppointViewDelegate: NSObjectProtocol
{
    func pushToLinkCustomVC(vc: HWBaseViewController)
    func popToScdHouDetailVC()
}

class HWScdHouMakeAppointView: HWBaseRefreshView, UITextViewDelegate, HWScdHouMakeAppointCellDelegate, ScdHouLinkCustomVCDelegate, UIAlertViewDelegate
{
    //MARK: 成员变量
    var _houseId: String! = ""
    var _integral: String! = "0"
    var _appointTime: NSDate!
    var _customId: String!
    var _customName: String!
    var _clientModel: HWClientModel?
    var _leaveMessage: String!
    weak var delegate: HWScdHouMakeAppointViewDelegate!
    
    var remindLab: UILabel!
    var appointHistoryLab: UILabel!
    var pickBackView: UIView!
    var datePicker: UIDatePicker!
    var lastContentOffest: CGPoint!
    var isDruging: Bool! = false
    
    init(frame: CGRect, houseId: String, integral: String!)
    {
        super.init(frame: frame)
        
        _houseId = houseId
        _integral = integral
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardChange:", name: UITextViewTextDidChangeNotification, object: nil)
        self.initTableHeaderView()
        self.loadDatePicker()
        
        self.queryListData()
    }
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UITextViewTextDidChangeNotification, object: nil)
    }
    
    //MARK: 初始化 预约UI
    func initTableHeaderView()
    {
        var headerView = UIView(frame: CGRectMake(0, 0, kScreenWidth, 360))
        headerView.backgroundColor = UIColor.clearColor()
        
        var clearView1 = UIView(frame: CGRectMake(0, 0, kScreenWidth, 10))
        clearView1.backgroundColor = UIColor.clearColor()
        clearView1.drawBottomLine()
        headerView.addSubview(clearView1)
        
        let titleArr = ["看房时间", "预约客户"]
        for var i = 0; i < 2; i++
        {
            var cellView: UIView! = UIView(frame: CGRectMake(0, CGFloat(10 + 45 * i), kScreenWidth, 45))
            cellView.drawBottomLine()
            cellView.backgroundColor = CD_WhiteColor
            cellView.tag = 1333 + i
            headerView.addSubview(cellView)
            
            var tap = UITapGestureRecognizer(target: self, action: "topCellClick:")
            cellView.addGestureRecognizer(tap)
            
            var leftTxtLab = UILabel(frame: CGRectMake(15, 0, 80, 45))
            leftTxtLab.font = Define.font(TF_15)
            leftTxtLab.textColor = CD_Txt_Color_00
            leftTxtLab.text = titleArr[i]
            cellView.addSubview(leftTxtLab)
            
            var rightTxtLab = UILabel(frame: CGRectMake(15, 0, kScreenWidth - 2 * 15 - 13, 45))
            rightTxtLab.textColor = CD_Txt_Color_99
            rightTxtLab.font = Define.font(TF_15)
            rightTxtLab.textAlignment = NSTextAlignment.Right
            rightTxtLab.tag = 1222 + i
            cellView.addSubview(rightTxtLab)
            
            var jmpImg = UIImageView(frame: CGRectMake(kScreenWidth - 15 - 8, (45 - 13) / 2, 8, 13))
            jmpImg.image = UIImage(named: "arrow_next")
            cellView.addSubview(jmpImg)
        }
        
        var titleLab = UILabel(frame: CGRectMake(15, 110, kScreenWidth - 2 * 15, 15))
        titleLab.font = Define.font(TF_15)
        titleLab.textColor = CD_Txt_Color_99
        titleLab.text = "*预约客户仅自己可见"
        headerView.addSubview(titleLab)
        
        var textViewBackView = UIView(frame: CGRectMake(0, titleLab.frame.maxY + 10, kScreenWidth, 110))
        textViewBackView.backgroundColor = CD_WhiteColor
        textViewBackView.drawTopLine()
        textViewBackView.drawBottomLine()
        headerView.addSubview(textViewBackView)
        
        var textView = UITextView(frame: CGRectMake(15, 1, kScreenWidth - 2 * 15, textViewBackView.frame.height - 2))
        textView.delegate = self
        textView.backgroundColor = CD_WhiteColor
        textView.font = Define.font(TF_Text_15)
        textViewBackView.addSubview(textView)
        
        var hideKeyBoardBtn = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        hideKeyBoardBtn.frame = CGRectMake(0, 0, kScreenWidth, 25)
        hideKeyBoardBtn.addTarget(self, action: "hideKeyboard", forControlEvents: UIControlEvents.TouchUpInside)
        hideKeyBoardBtn.setTitle("隐藏键盘", forState: UIControlState.Normal)
        hideKeyBoardBtn.setTitleColor(CD_Txt_Color_99, forState: UIControlState.Normal)
        textView.inputAccessoryView = hideKeyBoardBtn
        
        remindLab = UILabel(frame: CGRectMake(15, 10, kScreenWidth, 16))
        remindLab.text = "给对方经纪人留言80个字之内"
        remindLab.textColor = CD_Txt_Color_99
        remindLab.font = Define.font(TF_16)
        textViewBackView.addSubview(remindLab)
        
        var commitBtn = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        commitBtn.frame = CGRectMake(15, textViewBackView.frame.maxY + 20, kScreenWidth - 2 * 15, 45)
        commitBtn.setBackgroundImage(Utility.imageWithColor(CD_Btn_MainColor, _size: commitBtn.frame.size), forState: UIControlState.Normal)
        commitBtn.setTitle("提交", forState: UIControlState.Normal)
        commitBtn.setTitleColor(CD_Txt_Color_ff, forState: UIControlState.Normal)
        commitBtn.titleLabel?.font = Define.font(TF_Btn_Title_19)
        commitBtn.layer.cornerRadius = 3
        commitBtn.clipsToBounds = true
        commitBtn.addTarget(self, action: "publishBtnClick", forControlEvents: UIControlEvents.TouchUpInside)
        headerView.addSubview(commitBtn)
        
        appointHistoryLab = UILabel(frame: CGRectMake(15, commitBtn.frame.maxY + 15, kScreenWidth - 2 * 15, 16))
        appointHistoryLab.font = Define.font(TF_16)
        appointHistoryLab.textColor = CD_Txt_Color_00
        appointHistoryLab.text = "预约历史"
        appointHistoryLab.hidden = true
        headerView.addSubview(appointHistoryLab)
        
        baseTable.tableHeaderView = headerView
    }
    
    //MARK: 加载DatePicker
    func loadDatePicker()
    {
        pickBackView = UIView(frame: CGRectMake(0, contentHeight, kScreenWidth, 250))
        pickBackView.backgroundColor = CD_WhiteColor
        pickBackView.tag = 1444
        self.addSubview(pickBackView)
        
        datePicker = UIDatePicker()
        datePicker.backgroundColor = CD_WhiteColor
        datePicker.minuteInterval = 15
        var timeInterval = 15.0 * 60.0  - NSDate().timeIntervalSince1970 % ( 15.0 * 60.0) + NSDate().timeIntervalSince1970
        datePicker.minimumDate = NSDate(timeIntervalSince1970: timeInterval)
        pickBackView.addSubview(datePicker)
        
        var confirmBtn: UIButton! = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        confirmBtn.frame = CGRectMake(15, 240, kScreenWidth - 30, 40)
        confirmBtn.layer.cornerRadius = 5
        confirmBtn.clipsToBounds = true
        confirmBtn.setTitle("确认", forState: UIControlState.Normal)
        confirmBtn.titleLabel?.font = Define.font(TF_Btn_Title_19)
        confirmBtn.setBackgroundImage(Utility.imageWithColor(CD_MainColor, _size: confirmBtn.frame.size), forState: UIControlState.Normal)
        confirmBtn.addTarget(self, action: "dateConfirmBtnClick", forControlEvents: UIControlEvents.TouchUpInside)
        pickBackView.addSubview(confirmBtn)
    }
    
    
    //提交预约 按钮点击
    func publishBtnClick()
    {
        if(_appointTime == nil)
        {
            Utility.showToastWithMessage("请选择预约时间", _view: self)
            return
        }
        
        if(_customId == nil)
        {
            Utility.showToastWithMessage("请选择预约客户", _view: self)
            return
        }
        self.endEditing(true)
        self.popAAppointment()
    }
    
    func popAAppointment()
    {
        /*url:/appointment/appointmentHouse.do
        入参：scdhandHousesId=7
        clientId=5
        message=aaaa
        clientName=zdwzdw
        appointmentTime=1111111111111
        Integral=5
        出参：
        {"detail":"请求数据成功!","status":"1","data":""} */
        Utility.hideMBProgress(self)
        Utility.showMBProgress(self, _message: "请求数据")
        
        let manager = HWHttpRequestOperationManager.baseManager()
        var param = NSMutableDictionary()
        
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param.setPObject(_houseId, forKey: "scdhandHousesId")
        param.setPObject(_customId, forKey: "clientId")
        param.setPObject(_customName, forKey: "clientName")
        param.setPObject(_leaveMessage, forKey: "message")
        
        let t = _appointTime.timeIntervalSince1970 * 1000
        var timestamp: NSString = "\(t)"
        timestamp = timestamp.substringToIndex(timestamp.length - 2)
        
        param.setPObject(timestamp, forKey: "appointmentTime")
        param.setPObject(_integral, forKey: "Integral")
        
        manager.postHttpRequest(kScdHouMakeAppoint, parameters: param, queue: nil, success: { (responseObject) -> Void in
            
            Utility.hideMBProgress(self)
            Utility.showToastWithMessage("预约成功", _view: self)
            if(self.delegate != nil && self.delegate.respondsToSelector("popToScdHouDetailVC"))
            {
                self.delegate.popToScdHouDetailVC()
            }
            
            }) { (code, error) -> Void in
                
                Utility.hideMBProgress(self)
                Utility.showToastWithMessage(error, _view: self)
        }
    }
    
    //MARK: 看房时间/选择客户
    func topCellClick(tap: UITapGestureRecognizer)
    {
        if(tap.view?.tag == 1333)
        {
            self.showPickerAnimation()
        }
        else
        {
            self.hidePickerAnimation()
            var linkCustomVC = HWScdHouLinkCustomVC()
            linkCustomVC.isMultipleChoice = false
            linkCustomVC.delegate = self
            linkCustomVC.houseId = _houseId
            if(_clientModel != nil)
            {
                linkCustomVC.selectedClient = _clientModel
            }
            delegate.pushToLinkCustomVC(linkCustomVC)
        }
    }
    
    //MARK: ScdHouLinkCustomViewDelegate
    func linkCustomSelected(customModel: HWClientModel)
    {
        var cellRightLab = self.viewWithTag(1223) as UILabel
        cellRightLab.text = customModel.clientName
        _customId = customModel.clientInfoId
        _customName = customModel.clientName
        _clientModel = customModel
    }
    
    //MARK: datePicker 时间确定按钮点击
    func dateConfirmBtnClick()
    {
        self.hidePickerAnimation()
        var cellRightLab = self.viewWithTag(1222) as UILabel
        cellRightLab.text = Utility.convertStringFromDate(datePicker.date, formate: "yyyy-MM-dd  HH:mm")
        _appointTime = datePicker.date
    }
    
    //MARK: datePicker 动画
    func showPickerAnimation()
    {
        self.endEditing(true)
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.pickBackView.frame = CGRectMake(0, contentHeight - 300, kScreenWidth, 300)
            self.baseTable.frame = CGRectMake(0, 0, kScreenWidth, contentHeight - 300)
            }) { (finished) -> Void in
                
        }
    }
    
    func hidePickerAnimation()
    {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.pickBackView.frame = CGRectMake(0, contentHeight, kScreenWidth, 300)
            self.baseTable.frame = CGRectMake(0, 0, kScreenWidth, contentHeight)
            }) { (finished) -> Void in
                
        }
    }
    
    
    //MARK: 隐藏键盘
    func hideKeyboard()
    {
        self.endEditing(true)
    }
    
    //MARK: scrollView 代理 上拉收键盘
    override func scrollViewDidScroll(scrollView: UIScrollView)
    {
        if(lastContentOffest.y < scrollView.contentOffset.y && self.isDruging == true)
        {
            self.endEditing(true)
            self.isDruging = false
        }
        else
        {
            //            lastContentOffest.y = scrollView.contentOffset.y
        }
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView)
    {
        lastContentOffest = scrollView.contentOffset
        self.isDruging = true
    }
    
    //MARK: UITextViewDelegate
    func textViewShouldBeginEditing(textView: UITextView) -> Bool
    {
        self.hidePickerAnimation()
        remindLab.hidden = true
        return true
    }
    
    func textViewDidEndEditing(textView: UITextView)
    {
        if(countElements(textView.text) == 0)
        {
            remindLab.hidden = false
        }
        else
        {
            _leaveMessage = textView.text
        }
    }
    
    //MARK: 字数限制
    func keyboardChange(notifi: NSNotification)
    {
        var textView: UITextView! = notifi.object as UITextView
        var tmpString = textView.text
        
        var currentArr = UITextInputMode.activeInputModes() as Array
        var currentMode = currentArr.first as UITextInputMode
        if(currentMode.primaryLanguage == "zh-Hans")
        {
            var selectedRange = textView.markedTextRange
            if(selectedRange == nil)
            {
                if(countElements(textView.text) > 80)
                {
                    textView.text = tmpString.substringToIndex(advance(tmpString.startIndex, 80))
                }
            }
            else
            {
                //键盘输入
            }
        }
        else
        {
            if(countElements(textView.text) > 80)
            {
                textView.text = tmpString.substringToIndex(advance(tmpString.startIndex, 80))
            }
        }
    }
    
    //MARK: 请求预约历史
    override func queryListData()
    {
        /*url：/appointment/findAppointmentHis.do
        入参：无
        出参：
        {
        "detail": "请求数据成功!",
        "status": "1",
        "data": {
        "content": [
        { "message":"" -留言； "appointmentTime":"" -预约时间； "clientName":"" -客户姓名； "clientPhone":"" -客户电话 "appointmentState":"" -预约状态：confirm_w:等待对方确认;confirmed:对方同意;rejected:对方拒绝 } */
        Utility.hideMBProgress(self)
        Utility.showMBProgress(self, _message: "请求数据")
        
        let manager = HWHttpRequestOperationManager.baseManager()
        var param = NSMutableDictionary()
        
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param.setPObject(_houseId, forKey: "houseId")
        
        manager.postHttpRequest(kScdHouAppointHistory, parameters: param, queue: nil, success: { (responseObject) -> Void in
            
            Utility.hideMBProgress(self)
            var dataArr: NSArray = responseObject.arrayObjectForKey("data")
            var tmpArr = NSMutableArray()
            for var i = 0; i < dataArr.count; i++
            {
                var dict: NSDictionary = dataArr.pObjectAtIndex(i) as NSDictionary
                var model = HWScdHouMakeAppointModel()
                model.initWithDict(dict)
                tmpArr.addObject(model)
            }
            
            self.baseListArr = NSMutableArray(array: tmpArr)
            
            self.baseTable.reloadData()
            if(self.baseListArr.count > 0)
            {
                self.appointHistoryLab.hidden = false
            }
            self.doneLoadingTableViewData()
            self.hideEmptyView()
            
            }) { (code, error) -> Void in
                
                Utility.hideMBProgress(self)
                self.doneLoadingTableViewData()
                Utility.showToastWithMessage(error, _view: self)
                
//                if(self.baseListArr.count == 0 && code.integerValue == kStatusFailure)
//                {
//                    self.showNetworkErrorView(kFailureDetail)
//                }
//                else
//                {
//                    Utility.showToastWithMessage(error, _view: self)
//                }
        }
        
    }
    
    
    //MARK: tableViewDelegate
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return baseListArr.count
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cellId = "cellID"
        var cell: HWScdHouMakeAppointCell? = tableView.dequeueReusableCellWithIdentifier(cellId) as? HWScdHouMakeAppointCell
        if(cell == nil)
        {
            cell = HWScdHouMakeAppointCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellId)
            cell?.contentView.drawBottomLine()
            cell?.drawTopLine()
        }
        cell?.delegate = self
        var tmpModel = baseListArr[indexPath.section] as HWScdHouMakeAppointModel
        cell?.setCellContent(tmpModel, index: indexPath.row)
        
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        var tmpModel = baseListArr[indexPath.section] as HWScdHouMakeAppointModel
        return HWScdHouMakeAppointCell.getCellHeight(tmpModel)
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        return 10
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        var view = UIView(frame: CGRectMake(0, 0, kScreenWidth, 10))
        view.backgroundColor = UIColor.clearColor()
        return view
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    
    //MARK: HWScdHouMakeAppointCellDelegate
    func callPhone(phoneNum: String, index: Int)
    {
        var callWebView = UIWebView()
        self.addSubview(callWebView)
        
        if(phoneNum == "")
        {
            Utility.showToastWithMessage("手机号未空", _view: self)
        }
        else
        {
            var telUrl = NSURL(string: "tel:\(phoneNum)")
            callWebView.loadRequest(NSURLRequest(URL: telUrl!))
        }
    }
    
    
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
