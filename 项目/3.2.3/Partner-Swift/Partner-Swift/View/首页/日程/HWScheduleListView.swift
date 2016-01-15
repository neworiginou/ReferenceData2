//
//  HWScheduleListView.swift
//  Partner-Swift
//
//  Created by caijingpeng.haowu on 15/2/23.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

protocol HWScheduleListViewDelegate: NSObjectProtocol
{
    func toggleScheduleToCalendarMode()
    func didSelectScheuleList(schedule: HWScheduleModel?) -> Void
    func scheduleListUploadInfoBySchedule(schedule: HWScheduleModel?)
}

class HWScheduleListView: HWBaseRefreshView, HWScheduleListCellDelegate, UIActionSheetDelegate, SWTableViewCellDelegate, MTCustomActionSheetDelegate {

    var delegate: HWScheduleListViewDelegate?
    var dateDictionary: NSMutableDictionary! = NSMutableDictionary()
    var sectionArr: NSArray! = NSArray()
    var callToSchedule: HWScheduleModel?
    var delayDate: NSDate?
    var delaySchedule: HWScheduleModel?
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        self.baseTable.registerClass(HWScheduleListCell.self, forCellReuseIdentifier: HWScheduleListCell.getIdentify())
         NSNotificationCenter.defaultCenter().addObserver(self, selector: "queryListData", name: "ScheduleViewSaveSuccess", object: nil)
        
    }
    
    override func drawRect(rect: CGRect)
    {
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_after(1, queue) { () -> Void in
            self.queryListData()
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
        
//        let dateFormat: NSDateFormatter! = NSDateFormatter()
//        dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        let dateStr = Utility.getTimestampWithTime(dateFormat.stringFromDate(selectedDate!))
        
        Utility.showMBProgress(self, _message: "加载中")
        
        let manager = HWHttpRequestOperationManager.baseManager()
        var param: NSMutableDictionary! = NSMutableDictionary()
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
//        param.setPObject(dateStr, forKey: "wakeTime")
        
        manager.postHttpRequest(kScheduleCalendar, parameters: param, queue: nil, success: { (responseObject) -> Void in
            self.baseListArr = NSMutableArray()
            Utility.hideMBProgress(self)
            
            let resultArray: NSArray = ((responseObject.dictionaryObjectForKey("data") as NSDictionary).dictionaryObjectForKey("scheduleManageByPage") as NSDictionary).arrayObjectForKey("data")
            if (resultArray.count == 0)
            {
                self.baseListArr.removeAllObjects()
                self.showEmptyView("无日程")
            }
            else
            {
                self.hideEmptyView()
            }
            
            let modelArray: NSMutableArray = NSMutableArray()
            for (var i = 0; i < resultArray.count; i++)
                    {
                let dic: NSDictionary! = resultArray.pObjectAtIndex(i) as NSDictionary
                let model: HWScheduleModel = HWScheduleModel(scheduleInfo: dic)
                modelArray.addObject(model)
            }
            
            self.baseListArr = modelArray
            self.parseDate()
            
            self.baseTable.reloadData()
            self.doneLoadingTableViewData()
            
            
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
    
    func toShowCalendarSchedule(sender: UIButton) -> Void
    {
        if (delegate != nil && delegate?.respondsToSelector("toggleScheduleToCalendarMode") == true)
        {
            delegate?.toggleScheduleToCalendarMode()
        }
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRectMake(0, 0, kScreenWidth, 44))
        view.backgroundColor = CD_BackGroundColor
        
        let label = UILabel(frame: CGRectMake(15, 0, kScreenWidth - 50, 44))
        label.backgroundColor = UIColor.clearColor()
        label.font = Define.font(TF_Text_15)
        label.textColor = CD_Txt_Color_00
        
        
        let string = sectionArr.pObjectAtIndex(section) as? NSString
        
        if (string?.isEqualToString("2030-01") == true)
        {
            label.text = "今天"
        }
        else
        {
            label.text = string
        }
        
        view.addSubview(label)
        
        if (section == 0)
        {
            view.drawTopLine()
            let button: UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
            button.frame = CGRectMake(kScreenWidth - 50, 0, 50, 44)
            button.setImage(UIImage(named: "schedule2"), forState: UIControlState.Normal)
            button.addTarget(self, action: "toShowCalendarSchedule:", forControlEvents: UIControlEvents.TouchUpInside)
            view.addSubview(button)
        }
        
        view.drawBottomLine()
        
        return view
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        let key = self.sectionArr.objectAtIndex(indexPath.section) as String
        let scheduleArr = self.dateDictionary.arrayObjectForKey(key)
        
        let schedule: HWScheduleModel = scheduleArr.pObjectAtIndex(indexPath.row) as HWScheduleModel
        return HWScheduleListCell.getCellHeight(schedule)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let key: String = sectionArr.objectAtIndex(section) as String
        let scheduleArr = dateDictionary.arrayObjectForKey(key)
        return scheduleArr.count
    }
    
    func parseDate() -> Void
    {
        dateDictionary = NSMutableDictionary()
        
        var scheduleArr = NSMutableArray()
        var flag: NSString = "2030-01"
        
        for (var i = 0; i < self.baseListArr.count; i++)
        {
            let schedule: HWScheduleModel = self.baseListArr.pObjectAtIndex(i) as HWScheduleModel
            let finishDate = Utility.convertDateFromString(Utility.getTimeWithTimestamp(schedule.finishTime as String, dateFormatStr: "yyyy-MM-dd HH:mm:ss") , formate: "yyyy-MM-dd HH:mm:ss")
            let finishYearMonth: NSString? = Utility.convertStringFromDate(finishDate, formate: "yyyy-MM")
//            let finishMonth: NSString = Utility.convertStringFromDate(finishDate, formate: "MM")
//            let finishDay: NSString = Utility.convertStringFromDate(finishDate, formate: "dd")
            
            if (self.isEqualToday(finishDate!) == true)
            {
                //  今天
                scheduleArr.addObject(schedule)
            }
            else if (flag.isEqualToString(finishYearMonth!) == true &&
                self.isEqualToday(finishDate!) == false)
            {
                scheduleArr.addObject(schedule)
            }
            else
            {
                if scheduleArr.count != 0
                {
                    dateDictionary.setObject(scheduleArr, forKey: flag)
                    scheduleArr = NSMutableArray()
                    scheduleArr.addObject(schedule)
                }
                else if (self.isEqualToday(finishDate!) == false)
                {
                    scheduleArr = NSMutableArray()
                    scheduleArr.addObject(schedule)
                }
                flag = finishYearMonth!
            }
            
            if (i == self.baseListArr.count - 1)
            {
                dateDictionary.setObject(scheduleArr, forKey: flag)
            }
        }
        
        sectionArr = dateDictionary.allKeys
        sectionArr = sectionArr.sortedArrayUsingComparator { (obj1, obj2) -> NSComparisonResult in
            let str1: NSString = obj1 as NSString
            let str2: NSString = obj2 as NSString
            
            let date1: NSDate = Utility.convertDateFromString(str1, formate: "yyyy-MM")!
            let date2: NSDate = Utility.convertDateFromString(str2, formate: "yyyy-MM")!
            
            if (date1.timeIntervalSinceDate(date2) > 0)
            {
                return NSComparisonResult.OrderedAscending
            }
            else if (date1.timeIntervalSinceDate(date2) < 0)
            {
                return NSComparisonResult.OrderedDescending
            }
            else
            {
                return NSComparisonResult.OrderedSame
            }
        }
        
//        println(dateDictionary)
    }
    
    func isEqualToday(date: NSDate) -> Bool
    {
        let dateStr: NSString = Utility.convertStringFromDate(date, formate: "yyyy-MM-dd")!
        let todayStr: NSString = Utility.convertStringFromDate(NSDate(), formate: "yyyy-MM-dd")!
        if (dateStr.isEqualToString(todayStr))
        {
            return true
        }
        return false
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return dateDictionary.allKeys.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell: HWScheduleListCell = tableView.dequeueReusableCellWithIdentifier(HWScheduleListCell.getIdentify(), forIndexPath: indexPath) as HWScheduleListCell
        
        let key = self.sectionArr.objectAtIndex(indexPath.section) as String
        let scheduleArr = self.dateDictionary.arrayObjectForKey(key)
        cell.listDelegate = self
        cell.delegate = self
        let schedule: HWScheduleModel = scheduleArr.pObjectAtIndex(indexPath.row) as HWScheduleModel
        cell.setScheduleListModel(schedule)
        cell.contentView.drawBottomLine()
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let key = self.sectionArr.objectAtIndex(indexPath.section) as String
        let scheduleArr = self.dateDictionary.arrayObjectForKey(key)
        let schedule: HWScheduleModel = scheduleArr.pObjectAtIndex(indexPath.row) as HWScheduleModel
        if (self.delegate != nil && self.delegate?.respondsToSelector("didSelectScheuleList:") == true)
        {
            self.delegate?.didSelectScheuleList(schedule)
        }

    }
    
    func listCell(cell: HWScheduleListCell, didCallToPhone schedule: HWScheduleModel)
    {
        if (schedule.sourceType.isEqualToString("appointment_client") == true)
        {
            self.callToSchedule = schedule
            
            if (self.callToSchedule?.houseBrokerPhone.length > 0)
            {
                let actionSheet: UIActionSheet = UIActionSheet(title: "", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "\(schedule.clientName) \(schedule.clientPhone)", "\(schedule.houseBrokerName) \(schedule.houseBrokerPhone)")
                actionSheet.showInView(self)
            }
            else
            {
                let actionSheet: UIActionSheet = UIActionSheet(title: "", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "\(schedule.clientName) \(schedule.clientPhone)")
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
            Utility.showToastWithMessage("无电话号码", _view: self)
        }
    }
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int)
    {
        if (self.callToSchedule == nil)
        {
            return
        }
        
        if (self.callToSchedule?.clientPhone.length != 0 && self.callToSchedule?.houseBrokerPhone.length != 0)
        {
            if (buttonIndex == 1)
            {
                Utility.callPhone(self.callToSchedule!.clientPhone)
            }
            else if(self.callToSchedule?.houseBrokerPhone.length > 0 && buttonIndex == 2)
            {
                Utility.callPhone(self.callToSchedule!.houseBrokerPhone)
            }
        }
        else if (self.callToSchedule?.clientPhone.length != 0)
        {
            if (buttonIndex == 1)
            {
                Utility.callPhone(self.callToSchedule!.clientPhone)
            }
        }
        else if (self.callToSchedule?.houseBrokerPhone.length != 0)
        {
            if (buttonIndex == 1)
            {
                Utility.callPhone(self.callToSchedule!.houseBrokerPhone)
            }
        }
    }
    
    // MARK:  SWTableViewCellDelegate
    
    func swipeableTableViewCellShouldHideUtilityButtonsOnSwipe(cell: SWTableViewCell!) -> Bool {
        return true
    }
    
    func swipeableTableViewCell(cell: SWTableViewCell!, didTriggerLeftUtilityButtonWithIndex index: Int) {
        
        let indexPath: NSIndexPath = self.baseTable.indexPathForCell(cell)!
        let key = self.sectionArr.objectAtIndex(indexPath.section) as String
        let scheduleArr = self.dateDictionary.arrayObjectForKey(key)
        let schedule: HWScheduleModel? = scheduleArr.pObjectAtIndex(indexPath.row) as? HWScheduleModel
        
        cell.hideUtilityButtonsAnimated(true)
        
//        let schedule: HWScheduleModel? = self.baseListArr.pObjectAtIndex(indexPath.row) as? HWScheduleModel
        
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
                        if (self.delegate != nil && self.delegate?.respondsToSelector("scheduleListUploadInfoBySchedule:") == true)
                        {
                            self.delegate?.scheduleListUploadInfoBySchedule(schedule)
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
//        println(index)
        cell.hideUtilityButtonsAnimated(true)
        
        let indexPath: NSIndexPath = self.baseTable.indexPathForCell(cell)!
        let key = self.sectionArr.objectAtIndex(indexPath.section) as String
        let scheduleArr = self.dateDictionary.arrayObjectForKey(key)
        let schedule: HWScheduleModel? = scheduleArr.pObjectAtIndex(indexPath.row) as? HWScheduleModel
        
        if (index == 0 && schedule?.state?.isEqualToString("0") == true)
        {
            // 延迟
            println("#################")
            
            let datePicker = MTCustomActionSheet(datePicker: Utility.convertDateFromString(Utility.getTimeWithTimestamp(schedule?.finishTime as String, dateFormatStr: "yyyy-MM-dd HH:mm:ss"), formate: "yyyy-MM-dd HH:mm:ss"))
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
//                        self.baseTable.deleteRowsAtIndexPaths(NSArray(object: indexPath), withRowAnimation: UITableViewRowAnimation.None)
                        self.queryListData()
                        }, failure: { (code, error) -> Void in
                            Utility.hideMBProgress(self)
                            Utility.showToastWithMessage(error, _view: self)
                    })     
                    
                }
            })
        }
    }
    override func refreshData() -> Void
    {
        if (isNeedHeadRefresh)
        {
            self.queryListData()
            //            self.baseTable.setContentOffset(CGPointMake(0, -65), animated: true)
            //            self.slimeView.slime.state = SRSlimeStateShortening
            //            self.slimeView.pullApart(nil)
        }
    }

    func swipeableTableViewCell(cell: SWTableViewCell!, canSwipeToState state: SWCellState) -> Bool {
        return true
    }
    
    func actionSheet(actionSheet: MTCustomActionSheet!, didClickButtonByIndex index: Int32, selectDate date: NSDate!) {
        
        if (index == 1)
        {
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
                    self.delaySchedule?.finishTime = Utility.convertStringFromDate(date, formate: "yyyy-MM-dd HH:mm:ss")
                    self.delaySchedule?.lastFinishTime = Utility.convertStringFromDate(self.delayDate!, formate: "yyyy-MM-dd HH:mm:ss")
                    self.baseTable.reloadData()
                    
                    }, failure: { (code, error) -> Void in
                        Utility.hideMBProgress(self)
                        Utility.showToastWithMessage(error, _view: self)
                })
                
            }
            else
            {
                // 日期 选择错误
                println("日期 选择错误")
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
