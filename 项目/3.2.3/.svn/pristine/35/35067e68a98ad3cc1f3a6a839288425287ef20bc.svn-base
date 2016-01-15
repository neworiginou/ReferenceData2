//
//  HWNewScheduleView.swift
//  Partner-Swift
//
//  Created by caijingpeng.haowu on 15/2/15.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：新建日程 view
//
//  修改记录：
//      姓名         日期               修改内容
//     蔡景鹏     2015-02-11           创建文件
//     马一平     2015-08-10           底部上传图片成功后加载图片使用 picUrl字段 直接加载图片完整链接

import UIKit

let IMG_EDIT_TAG = 2170

enum NewScheduleSourceType : Int {
    
    case New        // 新建日程
    case Appoint    // 客户详情  新建日程
    case EditUpload       //   编辑并上传
    case Edit       // 日程编辑
}

@objc protocol HWNewScheduleViewDelegate : NSObjectProtocol
{
    func didSelectClientWithRelatedClient(client: HWClientModel?)
    func didSelectHouseWithRelatedHouse(house: HWRelateHouseModel?, clientId: NSString?)
    func didCreateNewScheduleView()
    func didUpdateSchedule()
}

class HWNewScheduleView: HWBaseRefreshView, UIActionSheetDelegate, HWImagePickerWidgetDelegate, HWImageEditViewDelegate, MTCustomActionSheetDelegate, UITextViewDelegate{

    var selectedDate: NSDate? = NSDate()
    var selectedClient: HWClientModel?
    var selectedHouse: HWRelateHouseModel?
    var scheduleContent: NSString? = ""
    var selectedPicKeyArr: NSMutableArray! = NSMutableArray()
    var isShowLocation: Bool? = true
    
    var dateLabel: UILabel!
    
    var ctntTemplateBackView: UIView!
    var locationBackView: UIView!
    var locSwitch: UISwitch!
    var footerView: UIView!
    
    var imgPickerWidget: HWImagePickerWidget?
    weak var delegate: HWNewScheduleViewDelegate?
    var presentViewController: UIViewController?
    var todayButton: UIButton!
    var contentTV: UITextView!
    var editSchedule: HWScheduleModel?
    var sourceType: NewScheduleSourceType? = NewScheduleSourceType.New
    var location:locationStruct?
    var saveSuccess:(() -> ())?
    
    var selectedImageShowUrlArr:NSMutableArray = NSMutableArray()//MYP add 底部添加图片显示图片的url数组
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        imgPickerWidget = HWImagePickerWidget()
        imgPickerWidget?.delegate = self
        imgPickerWidget?.actionSheetShowInView = self
        
        self.setIsNeedHeadRefresh(false)
        self.baseTable.registerClass(HWDefaultCell.self, forCellReuseIdentifier: HWDefaultCell.getIdentify())
        self.baseTable.registerClass(HWInputCell.self, forCellReuseIdentifier: HWInputCell.getIdentify())
        initialHeaderView()
        initialFooterView()
        //定位成功
        HWLocationManager.shareManager().locationSuccess = { loc,cityName in
            self.location = loc
            self.locSwitch.setOn(true, animated: false)
            self.isShowLocation = true
        }
        //定位失败
        HWLocationManager.shareManager().locationFailure = {
        
            Utility.showToastWithMessage("定位失败", _view: self)
            self.locSwitch.setOn(false, animated: false)
            self.isShowLocation = false
        }
        
        HWLocationManager.shareManager().startLoacting()
    }
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UITextViewTextDidChangeNotification, object: nil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func toTapTable() -> Void
    {
        self.endEditing(true)
    }
    
    func initialHeaderView() -> Void
    {
        let headerView = UIView(frame: CGRectMake(0, 0, kScreenWidth, 80 * kRate))
        headerView.backgroundColor = UIColor.clearColor()
        self.baseTable.tableHeaderView = headerView
        headerView.drawBottomLine()
        
        let dateBackView = UIView(forAutoLayout: ())
        dateBackView.backgroundColor = UIColor.whiteColor()
        headerView.addSubview(dateBackView)
        dateBackView.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: headerView, withOffset: 10 * kRate)
        dateBackView.autoPinEdge(ALEdge.Bottom, toEdge: ALEdge.Bottom, ofView: headerView, withOffset: -10 * kRate)
        dateBackView.autoSetDimension(ALDimension.Width, toSize: kScreenWidth)
//        dateBackView.autoSetDimension(ALDimension.Height, toSize: 65)
        dateBackView.drawTopLine()
        dateBackView.drawBottomLine()
        
        dateLabel = UILabel(forAutoLayout: ())
        dateBackView.addSubview(dateLabel)
        dateLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: dateBackView, withOffset: 0)
        dateLabel.autoPinEdge(ALEdge.Bottom, toEdge: ALEdge.Bottom, ofView: dateBackView, withOffset: 0)
        
        dateLabel.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: headerView, withOffset: 15)
        dateLabel.numberOfLines = 2
        dateLabel.text = "2014-12-30 18：00\n周二 农历冬月初七"
        dateLabel.font = Define.font(TF_Text_15)
        dateLabel.setLineSpacing(3 * kRate)
        
        let arrowImgV: UIImageView! = UIImageView(forAutoLayout: ())
//        arrowImgV.backgroundColor = UIColor.redColor()
        dateBackView .addSubview(arrowImgV)
        
        arrowImgV.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: dateLabel, withOffset: 6 * kRate)
        arrowImgV.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: dateLabel, withOffset: 18 * kRate)
        arrowImgV.autoSetDimension(ALDimension.Width, toSize: 10)
        arrowImgV.autoSetDimension(ALDimension.Height, toSize: 5)
        
        arrowImgV.image = UIImage(named: "filter_down4")
        
        
        let coverBtn: UIButton! = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        coverBtn.backgroundColor = UIColor.clearColor()
        coverBtn.frame = CGRectMake(
            15,
            0,
            dateLabel.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).width + 20,
            CGRectGetHeight(headerView.frame) - 20 * kRate)
        
        coverBtn.addTarget(self, action: "toSelectDate", forControlEvents: UIControlEvents.TouchUpInside)
        
        dateBackView.addSubview(coverBtn)
        
        todayButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        todayButton.frame = CGRectMake(kScreenWidth - 55, 0, 55, CGRectGetHeight(headerView.frame))
        todayButton.setImage(UIImage(named: "schedule3"), forState: UIControlState.Normal)
        todayButton.setTitle("现在", forState: UIControlState.Normal)
        todayButton.titleLabel?.font = Define.font(TF_Small_12)
        todayButton.setTitleColor(CD_Txt_Color_00, forState: UIControlState.Normal)
        todayButton.imageEdgeInsets = UIEdgeInsetsMake(32 - 19, 39 / 2.0, 32 + 19, 39 / 2.0)
        todayButton.titleEdgeInsets = UIEdgeInsetsMake(5, -8, 0, 5)
        todayButton.addTarget(self, action: "toCurrentDate", forControlEvents: UIControlEvents.TouchUpInside)
        dateBackView.addSubview(todayButton)
        
        // 设置日期
        
        var string: String? = Utility.convertStringFromDate(selectedDate!, formate: "yyyy-MM-dd hh:mm \nEE")
        dateLabel.text = "\(string!) \(Utility.getChineseCalendar(selectedDate!))"
        
        if (selectedDate != nil)
        {
            if (Utility.isEqualDate(selectedDate!, otherDate: NSDate()) == true)
            {
                todayButton.hidden = true
            }
            else
            {
                todayButton.hidden = false
            }
        }
        else
        {
            todayButton.hidden = true
        }
        
    }
    
    func initialFooterView() -> Void
    {
        footerView = UIView(frame: CGRectMake(0, 0, kScreenWidth, 335 * kRate))
        footerView.backgroundColor = UIColor.clearColor()
        self.baseTable.tableFooterView = footerView
        
        initialTemplateView()
        initialLocationView()
        initialEditPictureView()
    }
    
    func initialTemplateView() -> Void
    {
        ctntTemplateBackView = UIView(frame: CGRectMake(0, 0, kScreenWidth, 145))
        footerView.addSubview(ctntTemplateBackView)
        ctntTemplateBackView.backgroundColor = UIColor.clearColor()
//        ctntTemplateBackView.drawBottomLine()
        
        let label = UILabel(frame: CGRectMake(15, 0, 200, 40))
        label.backgroundColor = UIColor.clearColor()
        label.font = Define.font(TF_Text_15)
        label.textColor = CD_Txt_Color_66
        label.text = "常用日程内容"
        ctntTemplateBackView.addSubview(label)
        
        let templates = NSArray(objects: "面谈", "看房", "下定", "签合同", "打电话")
        for (var i = 0; i < 5; i++)
        {
            let a = kScreenWidth > 320 ? 4 : 3
            
            var templateBtn: UIButton! = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
            templateBtn.frame = CGRectMake(15 + (75 + 15) * CGFloat(i % a), CGRectGetMaxY(label.frame) + (35 + 15) * CGFloat(i / a), 75, 35)
            templateBtn.backgroundColor = UIColor.whiteColor()
            templateBtn.setButtonGrayBorderStyle()
            templateBtn.setBackgroundImage(Utility.imageWithColor(UIColor.whiteColor(), _size: CGSizeMake(75, 35)), forState: UIControlState.Normal)
            templateBtn.titleLabel?.font = Define.font(TF_14)
            templateBtn.setTitleColor(CD_Txt_Color_00, forState: UIControlState.Normal)
            templateBtn.setTitle(templates.pObjectAtIndex(i) as? String, forState: UIControlState.Normal)
            templateBtn.addTarget(self, action: "toAddTemplate:", forControlEvents: UIControlEvents.TouchUpInside)
            ctntTemplateBackView.addSubview(templateBtn)
        }
        
    }
    
    func initialLocationView() -> Void
    {
        locationBackView = UIView(frame: CGRectMake(0, CGRectGetMaxY(ctntTemplateBackView.frame), kScreenWidth, 44))
        locationBackView.backgroundColor = UIColor.whiteColor()
        footerView.addSubview(locationBackView)
        
        locationBackView.drawTopLine()
        locationBackView.drawBottomLine()
        
        let locImgV: UIImageView! = UIImageView(frame: CGRectMake(15, (44 - 15) / 2.0, 10, 15))
        locImgV.image = UIImage(named: "map_2")
        locationBackView.addSubview(locImgV)
        
        let locLabel: UILabel! = UILabel(frame: CGRectMake(CGRectGetMaxX(locImgV.frame) + 10, 0, 200, CGRectGetHeight(locationBackView.frame)))
        locLabel.font = Define.font(TF_14)
        locLabel.textColor = CD_Txt_Color_66
        locLabel.text = "显示当前所在位置"
        locationBackView.addSubview(locLabel)
        
        locSwitch = UISwitch(frame: CGRectMake(CGRectGetWidth(locationBackView.frame) - 15 - 50, (44 - 30) / 2, 50, 30))
        locSwitch.addTarget(self, action: "locSwitchClick:", forControlEvents: UIControlEvents.TouchUpInside)
        locSwitch.on = true;
        locationBackView.addSubview(locSwitch)
        
    }
    
    func initialEditPictureView() -> Void
    {
        var editPicBackView: UIScrollView! = UIScrollView(frame: CGRectMake(0, CGRectGetMaxY(locationBackView.frame) + 10 * kRate, CGRectGetWidth(footerView.frame), 75))
        editPicBackView.backgroundColor = UIColor.whiteColor()
        footerView.addSubview(editPicBackView)
        
        Utility.drawLine(CGPointMake(0, CGRectGetMaxY(editPicBackView.frame)), width: editPicBackView.frame.size.width)
        Utility.drawLine(CGPointMake(0, CGRectGetMinY(editPicBackView.frame)), width: editPicBackView.frame.size.width)
        
        for (var i = 0; i < (self.selectedPicKeyArr.count + 1); i++)
        {
            if (i < self.selectedPicKeyArr.count)
            {
                let picKey: NSString! = self.selectedPicKeyArr.pObjectAtIndex(i) as NSString
                //MYP add 使用picUrl加载图片
                let picUrl: NSString! = self.selectedImageShowUrlArr.pObjectAtIndex(i) as NSString
                var imgEditView: HWImageEditView = HWImageEditView(frame: CGRectMake(15 + (60 + 15) * CGFloat(i), (CGRectGetHeight(editPicBackView.frame) - 60) / 2, 60, 60))
                imgEditView.delegate = self
                imgEditView.tag = i + IMG_EDIT_TAG
                imgEditView.setImage(picUrl)
                editPicBackView.addSubview(imgEditView)
            }
            else
            {
                
                let addPicBtn: UIButton = UIButton(frame: CGRectMake(15 + (60 + 15) * CGFloat(i), (CGRectGetHeight(editPicBackView.frame) - 60) / 2, 60, 60))
                addPicBtn.setImage(UIImage(named: "add_pic"), forState: UIControlState.Normal)
                if (self.selectedPicKeyArr.count >= 5)
                {
                    addPicBtn.addTarget(self, action: "chooseImageMax", forControlEvents: UIControlEvents.TouchUpInside)
                }
                else
                {
                    addPicBtn.addTarget(imgPickerWidget, action: "chooseImagePicker", forControlEvents: UIControlEvents.TouchUpInside)
                }
                editPicBackView.addSubview(addPicBtn)
            }
        }
        let width = 15 + (60 + 15) * CGFloat(self.selectedPicKeyArr.count + 1)
//        println("\(width)")
        editPicBackView.contentSize = CGSizeMake(width, editPicBackView.frame.size.height)
    }
    
    func chooseImageMax() -> Void
    {
        Utility.showToastWithMessage("最多添加5张图片", _view: self)
    }
    
    func toSelectDate() -> Void
    {
        let dateActionSheet: MTCustomActionSheet = MTCustomActionSheet(datePicker: selectedDate)
        dateActionSheet.datepicker.minimumDate = NSDate()
        dateActionSheet.datepicker.date = NSDate()
        dateActionSheet.datepicker.datePickerMode = UIDatePickerMode.DateAndTime
        dateActionSheet.delegate = self
        dateActionSheet.showInView(self)
    }
    
    func toAddTemplate(sender: UIButton) -> Void
    {
        if (contentTV.text == "请输入您的日程内容")
        {
            contentTV.text = ""
        }
        
        let str = contentTV.valueForKey("text") as? String
        scheduleContent = str! + "\(sender.titleForState(UIControlState.Normal)!)"
        if scheduleContent?.length >= 100
        {
            scheduleContent = str
        }
        contentTV.becomeFirstResponder()
        self.baseTable.reloadData()
    }
    
    func toCurrentDate() -> Void
    {
        selectedDate = NSDate()
        self.initialHeaderView()
    }
// MARK:---tableViewDelegate
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if (indexPath.row == 2)
        {
            return HWInputCell.getCellHeight()
        }
        else
        {
            return HWDefaultCell.getCellHeight()
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if (indexPath.row == 2)
        {
            let cell = tableView.dequeueReusableCellWithIdentifier(HWInputCell.getIdentify(), forIndexPath: indexPath) as HWInputCell
            contentTV = cell.textView
            if (scheduleContent == nil || scheduleContent?.length == 0)
            {
                contentTV.text = "请输入您的日程内容"
            }
            else
            {
                contentTV.text = scheduleContent
                contentTV.setValue(scheduleContent, forKey: "text")
            }
            
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "textViewTextChange:", name: UITextViewTextDidChangeNotification, object: nil)
            contentTV.delegate = self
            
            cell.contentView.drawBottomLine()
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCellWithIdentifier(HWDefaultCell.getIdentify(), forIndexPath: indexPath) as HWDefaultCell
            
            if (indexPath.row == 0)
            {
                if (selectedClient != nil)
                {
                    cell.myTextLabel.text = "\(selectedClient?.clientName as String) \(selectedClient?.clientPhone as String)"
                }
                else
                {
                    cell.myTextLabel.text = "关联客户"
                }
            }
            else if (indexPath.row == 1)
            {
                if (selectedHouse != nil)
                {
                    let houseName: NSString = "\(selectedHouse?.houseName as String)"
                    let title: NSString = "\(selectedHouse?.title as String)"
                    
                    if (houseName.length > 0)
                    {
                        cell.myTextLabel.text = houseName
                    }
                    else
                    {
                        cell.myTextLabel.text = title
                    }
// 修改  杨庆龙 2015-3-24
                    
//                    if (selectedHouse?.houseType.isEqualToString("new") == true)
//                    {
//                        cell.myTextLabel.text = "\(selectedHouse?.houseName as String)"
//                    }
//                    else
//                    {
//                        cell.myTextLabel.text = "\(selectedHouse?.title as String)"
//                    }
                    
                }
                else
                {
                    cell.myTextLabel.text = "关联房源"
                }
            }
            
            cell.contentView.drawBottomLine()
            
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if (indexPath.section == 0)
        {
            if (indexPath.row == 0)
            {
                // 关联客户
                if (delegate != nil && delegate?.respondsToSelector("didSelectClientWithRelatedClient:") == true)
                {
                    delegate?.didSelectClientWithRelatedClient(self.selectedClient?)
                }
            }
            else if (indexPath.row == 1)
            {
                // 关联房源
                if (selectedClient == nil || selectedClient?.clientInfoId.length == 0)
                {
                    Utility.showToastWithMessage("请关联客户", _view: self)
                }
                else
                {
                    if (delegate != nil && delegate?.respondsToSelector("didSelectHouseWithRelatedHouse:clientId:") == true)
                    {
                        delegate?.didSelectHouseWithRelatedHouse(self.selectedHouse?, clientId: selectedClient?.clientInfoId)
                    }
                }
            }
        }
    }
    
    
    func imagePickerWidget(widget: HWImagePickerWidget, didFinishSelectImage image: UIImage)
    {
        // 上传图片 
        
        Utility.showMBProgress(self, _message: "上传中")
        
        let manager: HWHttpRequestOperationManager = HWHttpRequestOperationManager.baseManager()
        
        var param: NSMutableDictionary! = NSMutableDictionary()
        param.setPObject(UIImageJPEGRepresentation(image, 1), forKey: "file")
        manager.postImageHttpRequest(kUploadImageUrl, parameters: param, queue: nil, success: { (responseObject) -> Void in
            
            Utility.hideMBProgress(self)
            let responseDic: NSDictionary? = responseObject as? NSDictionary
            let picKey: NSString? = responseDic?.dictionaryObjectForKey("data").stringObjectForKey("fileKey")
            let picUrl: NSString? = responseDic?.dictionaryObjectForKey("data").stringObjectForKey("picUrl")
            self.selectedPicKeyArr.addObject(picKey!)
            self.selectedImageShowUrlArr.addObject(picUrl!)
            
            // 刷新 footer
            self.initialFooterView()
            
        }) { (status, error) -> Void in
            Utility.hideMBProgress(self)
            Utility.showToastWithMessage(error, _view: self)
        }
    }
    
    func didDeleteImageEditView(imgEditView: HWImageEditView)
    {
        let index = imgEditView.tag - IMG_EDIT_TAG
        self.selectedPicKeyArr.removeObjectAtIndex(index)
        self.selectedImageShowUrlArr.removeObjectAtIndex(index)
        // 刷新 footer
        self.initialFooterView()
    }
    
    func actionSheet(actionSheet: MTCustomActionSheet!, didClickButtonByIndex index: Int32, selectDate date: NSDate!) {
        
        if (index == 1)
        {
            selectedDate = date
            self.initialHeaderView()
        }
    }
    
    func setEditSchedule(schedule: HWScheduleModel) -> Void
    {
        self.editSchedule = schedule
        
        if (sourceType == NewScheduleSourceType.Edit || sourceType == NewScheduleSourceType.EditUpload)
        {
            let str: String! = self.editSchedule?.finishTime as String
            selectedDate = Utility.convertDateFromString(Utility.getTimeWithTimestamp(str, dateFormatStr: "yyyy-MM-dd HH:mm:ss"), formate: "yyyy-MM-dd HH:mm:ss")
        }
        
        scheduleContent = self.editSchedule?.content
        let keyStr: NSString? = self.editSchedule?.picKey

        
        if (keyStr != nil && keyStr?.length != 0)
        {
            selectedPicKeyArr = NSMutableArray(array: keyStr!.componentsSeparatedByString(","))
        }

        if (self.editSchedule?.longitude?.length != 0 && self.editSchedule?.latitude?.length != 0)
        {
            isShowLocation = true
        }
        else
        {
            isShowLocation = false
        }
        
        if (self.editSchedule?.clientInfoId?.length != 0)
        {
            selectedClient = HWClientModel()
            selectedClient?.clientInfoId = self.editSchedule?.clientInfoId as String
            selectedClient?.clientName = self.editSchedule?.clientName as String
            selectedClient?.clientPhone = self.editSchedule?.clientPhone as String
        }
        
        if (self.editSchedule?.houseId?.length != 0)
        {
            selectedHouse = HWRelateHouseModel()
            selectedHouse?.houseId = self.editSchedule?.houseId
            selectedHouse?.houseType = self.editSchedule?.houseType
            selectedHouse?.houseName = self.editSchedule?.houseName
        }
        
        initialHeaderView()
        initialFooterView()
        self.baseTable.reloadData()
    }
    
    func setSelectedDate(date: NSDate?)
    {
        selectedDate = date
        self.initialHeaderView()
    }
    
    func setRelateHouse(house: HWRelateHouseModel?)
    {
        selectedHouse = house
        self.baseTable.reloadData()
    }
    
    func setRelateClient(client: HWClientModel?)
    {
        selectedClient = client
        self.baseTable.reloadData()
    }
// MARK:---保存
    func saveInfo() -> Void
    {
        /*
        waketime:*** -日程提醒时间
        clientId:*** -关联客户Id
        houseId:*** - 关联房源Id
        content:*** - 日程内容
        houseType:*** - new 新房 secondHouse 二手房
        longitude:*** - 位置经度
        latitude:*** - 位置纬度
        address:*** - 位置详情
        sourceType:*** - 日程来源[appoint,call,new]
        schedulePicInfo[i].picKey:*** -图片key
        schedulePicInfo[i].picName:*** -图片名字
        i代表数字,最多传5张图片 i从0开始到4        */
        MobClick.event("Finishschedule_click")//埋点
        var str = contentTV.valueForKey("text") as? String
        
        if (contentTV.text == "请输入您的日程内容")
        {
            str = ""
        }
        
        
        if (countElements(str!) == 0)
        {
            Utility.showToastWithMessage("日程内容不能为空", _view: self)
            return
        }
        if (countElements(str!) < 2)
        {
            Utility.showToastWithMessage("日程内容最少位两个字", _view: self)
            return
        }
        if (countElements(str!) >= 100)
        {
            Utility.showToastWithMessage("日程内容不能多于100字", _view: self)
            return
        }
        
//        if selectedClient?.clientInfoId.length == 0
//        {
//            Utility.showToastWithMessage("请关联客户", _view: self)
//            return
//        }
//        if selectedHouse?.houseId.length == 0
//        {
//            Utility.showToastWithMessage("请关联房源", _view: self)
//            return
//        }
        
        Utility.showMBProgress(self, _message: "提交中")
        
        let manager: HWHttpRequestOperationManager = HWHttpRequestOperationManager.baseManager()
        
        var param: NSMutableDictionary! = NSMutableDictionary()
        
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param.setPObject(str, forKey: "content")

//        if (editSchedule != nil)
//        {
//            param.setPObject(editSchedule?.partnerScheduleId, forKey: "id")
//        }
        
        for (var i = 0; i < self.selectedPicKeyArr.count; i++)
        {
            param.setPObject(self.selectedPicKeyArr.pObjectAtIndex(i), forKey: "schedulePicInfo[\(i)].picKey")
            let name = "yyyy-MM-dd-HH:mm:ss"
            param.setPObject("ios\(Utility.convertStringFromDate(NSDate(), formate: name))", forKey: "schedulePicInfo[\(i)].picName")
        }
        
        if (isShowLocation == true)
        {
            var location: CLLocationCoordinate2D! = HWLocationManager.shareManager().coordinate
            param.setPObject("\(location.longitude)", forKey: "longitude")
            param.setPObject("\(location.latitude)", forKey: "latitude")
            param.setPObject(HWLocationManager.shareManager().locationAddress, forKey: "address")
        }
        var st: String! = "\(sourceType!.rawValue)"
        param.setPObject(st, forKey: "sourceType")
        param.setPObject(Utility.getTimestampWithTime(Utility.convertStringFromDate(selectedDate!, formate: "yyyy-MM-dd HH:mm:ss")!), forKey: "wakeTime")
        
        if (selectedHouse != nil)
        {
            param.setPObject(selectedHouse?.houseId, forKey: "houseId")
            param.setPObject(selectedHouse!.houseType, forKey: "houseType")
        }
        if (selectedClient != nil)
        {
            param.setPObject(selectedClient?.clientInfoId, forKey: "clientId")
        }
        manager.postHttpRequest(kNewSchedule, parameters: param, queue: nil, success: { (responseObject) -> Void in
            
            NSNotificationCenter.defaultCenter().postNotificationName("ScheduleViewSaveSuccess", object: nil)
            Utility.hideMBProgress(self)
            Utility.showToastWithMessage("新建成功", _view: self)
            
            if (self.delegate != nil && self.delegate?.respondsToSelector("didCreateNewScheduleView") != false)
            {
                self.delegate?.didCreateNewScheduleView()
            }
            
        }) { (code, error) -> Void in
            Utility.hideMBProgress(self)
            Utility.showToastWithMessage(error, _view: self)
        }
    }
    
// MARK:---是否定位
    func locSwitchClick(sender:UISwitch)
    {
        if sender.on == false
        {
            isShowLocation = false
        }
        else
        {
            if (HWLocationManager.shareManager().startLoacting() == false)
            {
                Utility.showToastWithMessage("请打开定位", _view: self)
                sender.setOn(false, animated: false)
                isShowLocation = false
            }
            else
            {
                HWLocationManager.shareManager().startLoacting()
                isShowLocation = true
        
            }
        }
        
    }
    
    func editSaveInfo() -> Void
    {
        var str = contentTV.valueForKey("text") as? String
        
        if (contentTV.text == "请输入您的日程内容")
        {
            str = ""
        }
        
        if (countElements(str!) == 0)
        {
            Utility.showToastWithMessage("日程内容不能为空", _view: self)
            return
        }
        if (countElements(str!) < 2)
        {
            Utility.showToastWithMessage("日程内容最少位两个字", _view: self)
            return
        }
        if (countElements(str!) >= 100)
        {
            Utility.showToastWithMessage("日程内容不能多于100字", _view: self)
            return
        }
        
        if (sourceType == NewScheduleSourceType.EditUpload)
        {
            var location: CLLocationCoordinate2D! = HWLocationManager.shareManager().coordinate
            if (self.selectedPicKeyArr.count == 0 && location.latitude == 0 && location.longitude == 0)
            {
                Utility.showToastWithMessage("请填写上传位置或图片", _view: self)
                return
            }
        }
        
        Utility.showMBProgress(self, _message: "提交中")
        
        let manager: HWHttpRequestOperationManager = HWHttpRequestOperationManager.baseManager()
        
        var param: NSMutableDictionary! = NSMutableDictionary()
        
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param.setPObject(str, forKey: "content")
        
        if (editSchedule != nil)
        {
            param.setPObject(editSchedule?.partnerScheduleId, forKey: "id")
        }
        
        for (var i = 0; i < self.selectedPicKeyArr.count; i++)
        {
            param.setPObject(self.selectedPicKeyArr.pObjectAtIndex(i), forKey: "schedulePicInfo[\(i)].picKey")
            let name = "yyyy-MM-dd-HH:mm:ss"
            param.setPObject("ios\(Utility.convertStringFromDate(NSDate(), formate: name))", forKey: "schedulePicInfo[\(i)].picName")
        }
        
        if (isShowLocation == true)
        {
            var location: CLLocationCoordinate2D! = HWLocationManager.shareManager().coordinate
            param.setPObject("\(location.longitude)", forKey: "longitude")
            param.setPObject("\(location.latitude)", forKey: "latitude")
            param.setPObject(HWLocationManager.shareManager().locationAddress, forKey: "address")
        }
        var st: String! = "\(sourceType!.rawValue)"
        param.setPObject(st, forKey: "sourceType")
        param.setPObject(Utility.getTimestampWithTime(Utility.convertStringFromDate(selectedDate!, formate: "yyyy-MM-dd HH:mm:ss")!), forKey: "wakeTime")
        
        if (selectedHouse != nil)
        {
            param.setPObject(selectedHouse?.houseId, forKey: "houseId")
            param.setPObject(selectedHouse!.houseType, forKey: "houseType")
        }
        if (selectedClient != nil)
        {
            param.setPObject(selectedClient?.clientInfoId, forKey: "clientId")
        }
        manager.postHttpRequest(kNewSchedule, parameters: param, queue: nil, success: { (responseObject) -> Void in
            
            NSNotificationCenter.defaultCenter().postNotificationName("ScheduleViewSaveSuccess", object: nil)
            Utility.hideMBProgress(self)
            
            
            if (self.sourceType == NewScheduleSourceType.Edit)
            {
                Utility.showToastWithMessage("更新成功", _view: self)
                if (self.delegate != nil && self.delegate?.respondsToSelector("didUpdateSchedule") != false)
                {
                    self.delegate?.didUpdateSchedule()
                }
            }
            else if (self.sourceType == NewScheduleSourceType.EditUpload)
            {
                self.uploadSchedule();
            }
            
            }) { (code, error) -> Void in
                Utility.hideMBProgress(self)
                Utility.showToastWithMessage(error, _view: self)
        }
    }
    
    func uploadSchedule()
    {
        // 完成
        
        /*
        id:*** - 日程id,
        operType: *** （1延时，2完成，3删除）
        delayTime: *** -延时时间[yyyy-MM-dd HH:mm:ss]
        finishType  0 : 暂不  1： 上传
        */
        
        Utility.showMBProgress(self, _message: "提交中")
        
        let manager: HWHttpRequestOperationManager = HWHttpRequestOperationManager.baseManager()
        
        var param: NSMutableDictionary! = NSMutableDictionary()
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param.setPObject(self.editSchedule?.partnerScheduleId, forKey: "id")
        param.setPObject("2", forKey: "operType")
        param.setPObject("1", forKey: "finishType")
        
        manager.postHttpRequest(kScheduleStatusUpdate, parameters: param, queue: nil, success: { (responseObject) -> Void in
            
            Utility.hideMBProgress(self)
            Utility.showToastWithMessage("操作成功", _view: self)
            
            if (self.delegate != nil && self.delegate?.respondsToSelector("didUpdateSchedule") != false)
            {
                self.delegate?.didUpdateSchedule()
            }
            
            }, failure: { (code, error) -> Void in
                Utility.hideMBProgress(self)
                Utility.showToastWithMessage(error, _view: self)
        })
    }
    
   // MARK:---textViewNotify
    func textViewTextChange(notify:NSNotification)
    {
        let textView = notify.object as UITextView
//        textView.setValue(textView.text, forKey: "text")
        self.scheduleContent = textView.text
    }
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        self.endEditing(true)
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

extension HWNewScheduleView:UITextViewDelegate
{

    func textViewDidBeginEditing(textView: UITextView)
    {
        if (textView == contentTV && textView.text == "请输入您的日程内容")
        {
                    textView.text = ""
        }
    }
    
    func textViewDidEndEditing(textView: UITextView)
    {
//        println("textViewDidEndEditing")
        let str = contentTV.valueForKey("text") as? String
//        println(str)
        if (textView == contentTV && (textView.text as NSString).length == 0)
        {
            textView.text = "请输入您的日程内容"
        }
    }

    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
        if range.location >= 100 && range.length == 0
        {
            return false
        }
        return true
        
    }
    
}

