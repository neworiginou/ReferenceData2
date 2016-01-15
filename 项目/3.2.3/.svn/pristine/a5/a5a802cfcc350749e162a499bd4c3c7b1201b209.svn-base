//
//  HWScheduleCalendarView.swift
//  Partner-Swift
//
//  Created by caijingpeng.haowu on 15/2/19.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

protocol HWScheduleCalendarViewDelegate: NSObjectProtocol
{
    func didSelectSchedule(schedule: HWScheduleModel?)
    func toggleScheduleToListMode()
    func uploadScheduleInfoBySchedule(schedule: HWScheduleModel?)
}

class HWScheduleCalendarView: HWBaseRefreshView, HWCustomCalendarDelegate, HWScheduleCalendarCellDelegate, SWTableViewCellDelegate, MTCustomActionSheetDelegate, UIActionSheetDelegate {
    
    var calendarBackView: UIView!
    var calendarView: HWCustomCalendar!
    var currentDateBtn: UIButton!
    
    var toggleButton: UIButton!
    
    var selectedDate: NSDate? = NSDate()
    var delayDate: NSDate?
    var delaySchedule: HWScheduleModel?
    var delegate: HWScheduleCalendarViewDelegate?
    var callToSchedule: HWScheduleModel?
    var todayButton: UIButton!
    var signArray: NSArray! = NSArray()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        self.initialCalendar()
        self.initialCalendarTableHeaderView()
        self.baseTable.registerClass(HWScheduleCalendarCell.self, forCellReuseIdentifier: HWScheduleCalendarCell.getIdentify())
        self.baseTable.frame = CGRectMake(0, 150, self.bounds.size.width, self.bounds.size.height - 150)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "queryListData", name: "ScheduleViewSaveSuccess", object: nil)
        
    }
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ScheduleViewSaveSuccess", object: nil)
    }

    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect)
    {
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_after(1, queue) { () -> Void in
            self.queryListData()
            
        }
    }
    
    func initialCalendar() -> Void
    {
        calendarBackView = UIView(frame: CGRectMake(0, 0, self.bounds.size.width, 150))
        calendarBackView.backgroundColor = UIColor.whiteColor()
        self.addSubview(calendarBackView)
        
        calendarView = HWCustomCalendar(frame: CGRectMake(0, 50, 0, 0))
        calendarView.delegate = self
        calendarBackView.addSubview(calendarView)
        calendarView.drawBottomLine()
        
        currentDateBtn = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        currentDateBtn.frame = CGRectMake(0, 0, self.bounds.size.width, 50)
        currentDateBtn.titleLabel?.font = Define.font(TF_Text_15)
        currentDateBtn.setTitleColor(CD_MainColor, forState: UIControlState.Normal)
        currentDateBtn.addTarget(self, action: "toSelectMonth:", forControlEvents: UIControlEvents.TouchUpInside)
        calendarBackView.addSubview(currentDateBtn)
        currentDateBtn.drawBottomLine()
        
        let imgView = UIImageView(frame: CGRectMake((kScreenWidth - 15) / 2.0, 50 - 9, 15, 9))
        imgView.image = UIImage(named: "schedule_icon")
        calendarBackView.addSubview(imgView)
        
        currentDateBtn.setTitle(Utility.convertStringFromDate(NSDate(), formate: "yyyy 年 MM 月"), forState: UIControlState.Normal)
        
        toggleButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        toggleButton.setImage(UIImage(named: "schedule1"), forState: UIControlState.Normal)
        toggleButton.frame = CGRectMake(calendarBackView.frame.size.width - 50, 0, 50, 50)
        toggleButton.addTarget(self, action: "toShowListMode:", forControlEvents: UIControlEvents.TouchUpInside)
        calendarBackView.addSubview(toggleButton)
        
        todayButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        todayButton.setTitle("今日", forState: UIControlState.Normal)
        todayButton.setTitleColor(CD_MainColor, forState: UIControlState.Normal)
        todayButton.layer.cornerRadius = 3.0
        todayButton.layer.borderWidth = 1
        todayButton.layer.borderColor = CD_MainColor.CGColor
        todayButton.frame = CGRectMake(15, (50 - 25) / 2.0, 50, 25)
        todayButton.titleLabel?.font = Define.font(TF_Text_15)
        todayButton.hidden = true
        todayButton.addTarget(self, action: "toSelectToday:", forControlEvents: UIControlEvents.TouchUpInside)
        calendarBackView.addSubview(todayButton)
    }
    
    func calendar(cal: HWCustomCalendar!, didSelectDate date: NSDate!)
    {
        
        selectedDate = date
        currentDateBtn.setTitle(Utility.convertStringFromDate(date, formate: "yyyy 年 MM 月"), forState: UIControlState.Normal)
        self.queryListData()
        
        if (CalendarDateUtil.isEquleDate(date, other: NSDate()))
        {
            todayButton.hidden = true
        }
        else
        {
            todayButton.hidden = false
        }
    }
    
    func initialCalendarTableHeaderView() -> Void
    {
        let headerView: UIView! = UIView(frame: CGRectMake(0, 0, kScreenWidth, 10))
        headerView.backgroundColor = UIColor.clearColor()
        self.baseTable.tableHeaderView = headerView
        headerView.drawBottomLine()
    }
    
    func toSelectToday(sender: UIButton) -> Void
    {
        currentDateBtn.setTitle(Utility.convertStringFromDate(NSDate(), formate: "yyyy 年 MM 月"), forState: UIControlState.Normal)
        calendarView.setDate(NSDate())
        calendarView.setSignDate(self.signArray)
        todayButton.hidden = true
        selectedDate = NSDate()
        self.queryListData()
    }
     
    func toSelectMonth(sender: UIButton) -> Void
    {
        let monthDatePicker = MTCustomActionSheet(SRMonthPicker: selectedDate)
        monthDatePicker.tag = 9999
        monthDatePicker.delegate = self
        monthDatePicker.showInView(self)
    }
    
    func toShowListMode(sender: UIButton) -> Void
    {
        if (delegate != nil && delegate?.respondsToSelector("didSelectSchedule:") == true)
        {
            delegate?.toggleScheduleToListMode()
        }
    }
    
// MARK:---请求数据
    func queryScheduleNumber()
    {
        let manager = HWHttpRequestOperationManager.baseManager()
        var param: NSMutableDictionary! = NSMutableDictionary()
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        
        manager.postHttpRequest(kScheduleNumber, parameters: param, queue: nil, success: { (responseObject) -> Void in
            
//            println("日程数量: \(responseObject)")
            
            self.signArray = (responseObject as NSDictionary).arrayObjectForKey("data")
            self.calendarView.setSignDate(self.signArray)
            
        }) { (code, error) -> Void in
            println(error)
        }
    }
    
    override func queryListData()
    {
        /*
        /schedule/findScheduleManage.do
        入参:
        wakeTime:*** -日程提醒时间
        houseId:*** -客户详情中关联房源id
        clientInfoId:*** -client_info主键id
        
        */
        
        let dateFormat: NSDateFormatter! = NSDateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateStr = Utility.getTimestampWithTime(dateFormat.stringFromDate(selectedDate!))
        
        Utility.showMBProgress(self, _message: "加载中")
        
        let manager = HWHttpRequestOperationManager.baseManager()
        var param: NSMutableDictionary! = NSMutableDictionary()
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param.setPObject(dateStr, forKey: "wakeTime")
        param.setPObject(currentPage, forKey: "pageNumber")
        param.setPObject(kPageCount, forKey: "pageSize")
        
        manager.postHttpRequest(kScheduleCalendar, parameters: param, queue: nil, success: { (responseObject) -> Void in
            
            Utility.hideMBProgress(self)
        
            let resultArray: NSArray = ((responseObject.dictionaryObjectForKey("data") as NSDictionary).dictionaryObjectForKey("scheduleManageDtos") as NSDictionary).arrayObjectForKey("data")
            if (resultArray.count == 0 && self.currentPage == 1)
            {
                self.baseListArr.removeAllObjects()
                self.showEmptyView("无日程")
            }
            else
            {
                self.hideEmptyView()
            }
            
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
            var modelArray: NSMutableArray = NSMutableArray()
            for (var i = 0; i < resultArray.count; i++)
            {
                let dic: NSDictionary! = resultArray.pObjectAtIndex(i) as NSDictionary
                let model: HWScheduleModel = HWScheduleModel(scheduleInfo: dic)
                modelArray.addObject(model)
            }
            
            self.baseListArr.addObjectsFromArray(modelArray)
        
            self.baseTable.reloadData()
            self.doneLoadingTableViewData()
            
            self.queryScheduleNumber()
            
            }) { (code, error) -> Void in
            
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
    
    
// MARK:---tableView代理
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.baseListArr.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let model: HWScheduleModel = self.baseListArr.pObjectAtIndex(indexPath.row) as HWScheduleModel
        return HWScheduleCalendarCell.getCellHeight(model)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let model: HWScheduleModel = self.baseListArr.pObjectAtIndex(indexPath.row) as HWScheduleModel
        
        var cell: HWScheduleCalendarCell = tableView.dequeueReusableCellWithIdentifier(HWScheduleCalendarCell.getIdentify(), forIndexPath: indexPath) as HWScheduleCalendarCell
        cell.setScheduleModel(model)
        cell.delegate = self
        cell.scheduleDelegate = self
        cell.contentView.drawBottomLine()
        return cell
    
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        MobClick.event("Scheduledetails_click")//埋点
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true);
        
        if (delegate != nil && delegate?.respondsToSelector("didSelectSchedule:") == true)
        {
            let model: HWScheduleModel = self.baseListArr.pObjectAtIndex(indexPath.row) as HWScheduleModel
            delegate?.didSelectSchedule(model)
        }
    }
    
    func calendarCell(cell: HWScheduleCalendarCell, didCallToPhone schedule: HWScheduleModel) {
            // 拨打电话
        
        if (schedule.sourceType.isEqualToString("appointment_client") == true)
        {
            self.callToSchedule = schedule
            
            if (self.callToSchedule!.houseBrokerPhone.length > 0)
            {
                let actionSheet: UIActionSheet = UIActionSheet(title: "联系电话", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "\(schedule.clientName) \(schedule.clientPhone)", "\(schedule.houseBrokerName) \(schedule.houseBrokerPhone)")
                actionSheet.showInView(self)
            }
            else
            {
                let actionSheet: UIActionSheet = UIActionSheet(title: "联系电话", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "\(schedule.clientName) \(schedule.clientPhone)")
                actionSheet.showInView(self)
            }
            
            
        }
        else if (schedule.sourceType.isEqualToString("appointment_house") == true)
        {
            self.callToSchedule = schedule
            let actionSheet: UIActionSheet = UIActionSheet(title: "联系电话", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "\(schedule.clientName) \(schedule.clientPhone)")
            actionSheet.showInView(self)
        }
        else if (schedule.sourceType.isEqualToString("new") == true)
        {
            self.callToSchedule = schedule
            let actionSheet: UIActionSheet = UIActionSheet(title: "联系电话", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "\(schedule.clientName) \(schedule.clientPhone)")
            actionSheet.showInView(self)
        }
        else
        {
//            Utility.showToastWithMessage("无电话号码", _view: self)
        }
    }
    
    func swipeableTableViewCellShouldHideUtilityButtonsOnSwipe(cell: SWTableViewCell!) -> Bool {
        return true
    }
    
    func swipeableTableViewCell(cell: SWTableViewCell!, didTriggerLeftUtilityButtonWithIndex index: Int) {
        println(index)
        cell.hideUtilityButtonsAnimated(true)
        let indexPath: NSIndexPath = self.baseTable.indexPathForCell(cell)!
        let schedule: HWScheduleModel? = self.baseListArr.pObjectAtIndex(indexPath.row) as? HWScheduleModel
        
        if (index == 0)
        {
            if (schedule?.clientInfoId.length > 0 && (schedule?.longitude.length == 0 || schedule?.latitude.length == 0 || schedule?.picKey.length == 0))
            {
                // 有业务的日程  提示 
                let alert = UIAlertView(title: "提示", message: "上传现场图片和位置？", delegate: nil, cancelButtonTitle: "取消", otherButtonTitles: "暂不", "上传")
                alert.showAlertViewWithCompleteBlock({ (buttonIndex) -> Void in
                    if (buttonIndex == 1)
                    {
                        self.requestDoneBySchedule(schedule, isUpload: false)
                    }
                    else if (buttonIndex == 2)
                    {
                        MobClick.event("SubmitLOC&IMG_click")
                        if (self.delegate != nil && self.delegate?.respondsToSelector("uploadScheduleInfoBySchedule:") == true)
                        {
                            self.delegate?.uploadScheduleInfoBySchedule(schedule)
                        }
                    }
                })
            }
            else
            {
                self.requestDoneBySchedule(schedule, isUpload: false)
            }
            
        }
    }
    
    func swipeableTableViewCell(cell: SWTableViewCell!, didTriggerRightUtilityButtonWithIndex index: Int) {
        println(index)
        cell.hideUtilityButtonsAnimated(true)
        
        let indexPath: NSIndexPath = self.baseTable.indexPathForCell(cell)!
        let schedule: HWScheduleModel? = self.baseListArr.pObjectAtIndex(indexPath.row) as? HWScheduleModel
        
        if (index == 0 && schedule?.state?.isEqualToString("0") == true)
        {
            // 延迟    
            println("#################")
            MobClick.event("Delay_click")//埋点
            let datePicker = MTCustomActionSheet(datePicker: selectedDate)
            datePicker.tag = 8888
            datePicker.datepicker.minimumDate = NSDate()
            datePicker.datepicker.datePickerMode = UIDatePickerMode.DateAndTime
            datePicker.delegate = self
            datePicker.showInView(self)
        
            
            if (schedule != nil)
            {
                delayDate = Utility.convertDateFromString(Utility.getTimeWithTimestamp(schedule?.finishTime as String, dateFormatStr: "yyyy-MM-dd HH:mm:ss"), formate: "yyyy-MM-dd HH:mm:ss")
                delaySchedule = schedule
            }
            else
            {
                delayDate = NSDate()
                delaySchedule = schedule
            }
        
        }
        else
        {
            // 删除
            MobClick.event("Delete_click")//埋点
            let alert = UIAlertView(title: "提示", message: "是否删除日程", delegate: nil, cancelButtonTitle: "取消", otherButtonTitles: "确定")
            alert.showAlertViewWithCompleteBlock({ (index) -> Void in
                if (index == 1)
                {
                    // 确定删除
                    println("删除")
                    
                    // 删除
                    /*
                    id:*** - 日程id,
                    operType: *** （1延时，2完成，3删除）
                    delayTime: *** -延时时间[yyyy-MM-dd HH:mm:ss]
                    */
                    
                    Utility.showMBProgress(self, _message: "发送数据")
                    
                    let manager: HWHttpRequestOperationManager = HWHttpRequestOperationManager.baseManager()
                    
                    var param: NSMutableDictionary! = NSMutableDictionary()
                    param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
                    param.setPObject(schedule?.partnerScheduleId, forKey: "id")
                    param.setPObject("3", forKey: "operType")
                    manager.postHttpRequest(kScheduleStatusUpdate, parameters: param, queue: nil, success: { (responseObject) -> Void in
                        
                        Utility.hideMBProgress(self)
                        Utility.showToastWithMessage("操作成功", _view: shareAppDelegate.window!)
                        // 删除成功
//                        self.baseListArr.removeObjectAtIndex(indexPath.row)
//                        self.baseTable.deleteRowsAtIndexPaths(NSArray(object: indexPath), withRowAnimation: UITableViewRowAnimation.Fade)
                        
                        self.refreshData()
                        
                        }, failure: { (code, error) -> Void in
                            Utility.hideMBProgress(self)
                            Utility.showToastWithMessage(error, _view: self)
                        })
                    
                }
            })
        }
    }
    
    func swipeableTableViewCell(cell: SWTableViewCell!, canSwipeToState state: SWCellState) -> Bool {
        return true
    }
    
    func actionSheet(actionSheet: MTCustomActionSheet!, didClickButtonByIndex index: Int32, selectDate date: NSDate!) {
        
        if (index == 1)
        {
            // 延迟 操作
            if (delayDate != nil)
            {
                // 日期 选择正确
                println("日期 选择正确")
                
                /*
                id:*** - 日程id,
                operType: *** （1延时，2完成，3删除）
                delayTime: *** -延时时间[yyyy-MM-dd HH:mm:ss]
                */
                Utility.showMBProgress(self, _message: "发送数据")
                
                let manager: HWHttpRequestOperationManager = HWHttpRequestOperationManager.baseManager()
                
                var param: NSMutableDictionary! = NSMutableDictionary()
                param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
                param.setPObject(delaySchedule?.partnerScheduleId, forKey: "id")
                param.setPObject("1", forKey: "operType")
                param.setPObject(Utility.getTimestampWithTime(Utility.convertStringFromDate(date, formate: "yyyy-MM-dd HH:mm:ss")!), forKey: "delayTime")
                
                manager.postHttpRequest(kScheduleStatusUpdate, parameters: param, queue: nil, success: { (responseObject) -> Void in
                    
                    Utility.hideMBProgress(self)
                    Utility.showToastWithMessage("操作成功", _view: shareAppDelegate.window!)
                    // 延迟成功
                    //                self.delaySchedule?.finishTime = Utility.convertStringFromDate(date, formate: "yyyy-MM-dd HH:mm:ss")
                    //                self.delaySchedule?.lastFinishTime = Utility.convertStringFromDate(self.delayDate!, formate: "yyyy-MM-dd HH:mm:ss")
                    //                self.baseTable.reloadData()
                    self.refreshData()
                    
                    }, failure: { (code, error) -> Void in
                        Utility.hideMBProgress(self)
                        Utility.showToastWithMessage(error, _view: self)
                })
                
            }
            else
            {
                // 日期 选择错误
                println("delayDate 为空")
            }
        }
    }
    
    func actionSheet(actionSheet: MTCustomActionSheet!, didClickButtonByIndex index: Int32, selectMonthDate date: NSDate!)
    {
        currentDateBtn.setTitle(Utility.convertStringFromDate(date, formate: "yyyy 年 MM 月"), forState: UIControlState.Normal)
        calendarView.setDate(date)
        
        selectedDate = date
        self.queryListData()
        
        if (CalendarDateUtil.isEquleDate(date, other: NSDate()))
        {
            todayButton.hidden = true
        }
        else
        {
            todayButton.hidden = false
        }
    }
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int)
    {
        if (self.callToSchedule == nil)
        {
            return
        }
        
        if (self.callToSchedule!.sourceType.isEqualToString("appointment_client") == true)
        {
            if (buttonIndex == 1)
            {
                Utility.callPhone(self.callToSchedule!.clientPhone)
            }
            else if(self.callToSchedule!.houseBrokerPhone.length > 0 && buttonIndex == 2)
            {
                Utility.callPhone(self.callToSchedule!.houseBrokerPhone)
            }
        }
        else if (self.callToSchedule!.sourceType.isEqualToString("appointment_house") == true)
        {
            if (buttonIndex == 1)
            {
                Utility.callPhone(self.callToSchedule!.clientPhone)
            }
        }
        else if (self.callToSchedule!.sourceType.isEqualToString("new") == true)
        {
            if (buttonIndex == 1)
            {
                Utility.callPhone(self.callToSchedule!.clientPhone)
            }
        }
        
    }
    
    func requestDoneBySchedule(schedule: HWScheduleModel?, isUpload: Bool) -> Void
    {
        // 完成
        
        /*
        id:*** - 日程id,
        operType: *** （1延时，2完成，3删除）
        delayTime: *** -延时时间[yyyy-MM-dd HH:mm:ss]
        问题 添加 是否上传图片 参数
        */
        
        Utility.showMBProgress(self, _message: "发送数据")
        
        let manager: HWHttpRequestOperationManager = HWHttpRequestOperationManager.baseManager()
        
        var param: NSMutableDictionary! = NSMutableDictionary()
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param.setPObject(schedule?.partnerScheduleId, forKey: "id")
        param.setPObject("2", forKey: "operType")
        
        if (isUpload == false)
        {
            // 暂不
            param.setPObject("0", forKey: "finishType")
        }
        else
        {
            param.setPObject("1", forKey: "finishType")
        }
        
        manager.postHttpRequest(kScheduleStatusUpdate, parameters: param, queue: nil, success: { (responseObject) -> Void in
            
            Utility.hideMBProgress(self)
            Utility.showToastWithMessage("操作成功", _view: self)
            schedule?.state = "1"
            self.baseTable.reloadData()
            
            }, failure: { (code, error) -> Void in
                Utility.hideMBProgress(self)
                Utility.showToastWithMessage(error, _view: self)
        })
    }
    
    
}