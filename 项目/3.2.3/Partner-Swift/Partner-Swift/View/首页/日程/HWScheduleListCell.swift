//
//  HWScheduleListCell.swift
//  Partner-Swift
//
//  Created by caijingpeng.haowu on 15/2/23.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

protocol HWScheduleListCellDelegate: NSObjectProtocol
{
    func listCell(cell: HWScheduleListCell, didCallToPhone schedule: HWScheduleModel)
}

class HWScheduleListCell: SWTableViewCell {
   
    let marginLeft: CGFloat = 15.0
    
    var timeLabel: UILabel!
    var titleLabel: UILabel!
    var subTitleLabel: UILabel!
    var iconImgV: UIImageView!
    var addressView: UIView!
    var addressLabel: UILabel!
    var telephoneButton: UIButton!
    var lastTimeLabel: UILabel!
    
    var scheduleModel: HWScheduleModel?
    let rightButtons = NSMutableArray()
    let leftButtons = NSMutableArray()
    
    var listDelegate: HWScheduleListCellDelegate?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        timeLabel = UILabel(frame: CGRectMake(marginLeft, 5, 60, 25))
        timeLabel.font = Define.font(TF_Small_12)
        timeLabel.textColor = CD_Txt_Color_66
        self.contentView.addSubview(timeLabel)
        
        lastTimeLabel = UILabel(frame: CGRectMake(CGRectGetMaxX(timeLabel.frame) + 10, CGRectGetMinY(timeLabel.frame), 35, 25))
        lastTimeLabel.backgroundColor = UIColor.clearColor()
        lastTimeLabel.font = Define.font(TF_Small_12)
        lastTimeLabel.textColor = CD_Txt_Color_66
        lastTimeLabel.textAlignment = NSTextAlignment.Center
        lastTimeLabel.adjustsFontSizeToFitWidth = true
        self.contentView.addSubview(lastTimeLabel)
        
        lastTimeLabel.addSubview(Utility.drawLine(CGPointMake(0, 12.5), width: 35))
        
        titleLabel = UILabel(frame: CGRectMake(marginLeft, CGRectGetMaxY(timeLabel.frame), kScreenWidth - 2 * marginLeft, 20))
        titleLabel.font = Define.font(TF_Text_15)
        titleLabel.textColor = CD_Txt_Color_00
        self.contentView.addSubview(titleLabel)
        
        subTitleLabel = UILabel(frame: CGRectMake(marginLeft, CGRectGetMaxY(titleLabel.frame) + 3, 0, 0))
        subTitleLabel.backgroundColor = UIColor.clearColor()
        subTitleLabel.font = Define.font(TF_Text_15 - 1)
        subTitleLabel.textColor = CD_Txt_Color_00
        subTitleLabel.numberOfLines = 0
        subTitleLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        self.contentView.addSubview(subTitleLabel)
        
        iconImgV = UIImageView(frame: CGRectMake(0, 0, 21, 15))
        iconImgV.backgroundColor = UIColor.clearColor()
        iconImgV.image = UIImage(named: "schedule_pic")
        self.contentView.addSubview(iconImgV)
        
        addressView = UIView(frame: CGRectMake(marginLeft, 0, kScreenWidth - 2 * marginLeft, 30))
        addressView.backgroundColor = UIColor.clearColor()
        self.contentView.addSubview(addressView)
        
        let addressImgV: UIImageView = UIImageView(frame: CGRectMake(0, 7.5, 10, 15)) as UIImageView
        addressImgV.image = UIImage(named: "map_2")
        addressView.addSubview(addressImgV)
        
        addressLabel = UILabel(frame: CGRectMake(15, 0, CGRectGetWidth(addressView.frame) - 20, CGRectGetHeight(addressView.frame)))
        addressLabel.font = Define.font(TF_Small_12)
        addressLabel.textColor = CD_Txt_Color_66
        addressLabel.backgroundColor = UIColor.clearColor()
        addressView.addSubview(addressLabel)
     
        telephoneButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        telephoneButton.frame = CGRectZero
        telephoneButton.setImage(UIImage(named: "phone2"), forState: UIControlState.Normal)
        telephoneButton.addTarget(self, action: "toCallPhone:", forControlEvents: UIControlEvents.TouchUpInside)
        self.contentView.addSubview(telephoneButton)
        
    }
    
    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func getIdentify() -> String
    {
        return "HWScheduleListCell"
    }
    
    class func getCellHeight(schedule: HWScheduleModel?) -> CGFloat
    {
//        let subTitleStr: String! = "撒打发士大夫萨芬的撒"
        
        var subTitleStr = ""
        
        if (schedule?.sourceType.isEqualToString("appointment_client") == true)
        {
            //  二手房预约  客源方
            subTitleStr = "\(schedule?.clientName as String) \(schedule?.clientPhone as String) 房源预约"
        }
        else if (schedule?.sourceType.isEqualToString("appointment_house") == true)
        {
            //  二手房预约  房源方
            subTitleStr = "\(schedule?.houseName as String) 房源预约 \(schedule?.content as String)"
        }
        else if (schedule?.sourceType.isEqualToString("new") == true)
        {
            //  新建
            if (schedule?.clientInfoId?.length == 0)
            {
                subTitleStr = schedule?.content as String
            }
            else
            {
                subTitleStr = "\(schedule?.houseName as String) \(schedule?.content as String)"
            }
        }
        
        let size = Utility.calculateStringSize(subTitleStr, textFont: Define.font(TF_Text_15 - 1), constrainedSize: CGSizeMake(kScreenWidth - 15 - 60, 1000))
        
        var height = size.height
        
        
        // 计算 字符位置
        
        let widthSize = Utility.calculateStringSize(subTitleStr, textFont: Define.font(TF_Text_15 - 1), constrainedSize: CGSizeMake(10000, 10000))
        let numberLine = size.height / widthSize.height
        let width = widthSize.width - (numberLine - 1) * size.width
        
        if (width + 60 + 15 + 21 + 10 < kScreenWidth)
        {
            
        }
        else
        {
            if (schedule?.picKey?.length == 0)
            {
                
            }
            else
            {
                height += 15
            }
        }
        
        
        
        
        if (schedule?.clientInfoId?.length != 0)
        {
            height += 50
        }
        else
        {
            height += 5 + 25
        }
        
        if (schedule?.address.length != 0)
        {
            height += 35
        }
        else
        {
            height += 13
        }
        
        return max(45, height)
    }
    
    func setScheduleListModel(schedule: HWScheduleModel?) -> Void
    {
//        let timeStr = "12:00"
//        let titleStr = "张三 18618151325"
//        let subTitleStr: String! = "撒打发士大夫萨芬的撒"
//        let addressStr = "算法的发生辅色调发生的"
//        let lastTimeStr = "22日"
        
        self.scheduleModel = schedule
        
        let str: String! = schedule?.finishTime as String
        let finishDate: NSDate! = Utility.convertDateFromString(Utility.getTimeWithTimestamp(str, dateFormatStr: "yyyy-MM-dd HH:mm:ss"), formate: "yyyy-MM-dd HH:mm:ss")
        let lastStr: String! = schedule?.lastFinishTime as String
        var lastDate: NSDate? = Utility.convertDateFromString(Utility.getTimeWithTimestamp(lastStr, dateFormatStr: "yyyy-MM-dd HH:mm:ss"), formate: "yyyy-MM-dd HH:mm:ss")
        
        let timeStr = Utility.convertStringFromDate(finishDate, formate: "dd日 HH:mm")
        
        var lastTimeStr = ""
        if lastDate != nil
        {
            let lastDateFormat: NSDateFormatter! = NSDateFormatter()
            lastDateFormat.dateFormat = "dd日"
            lastTimeStr = lastDateFormat.stringFromDate(lastDate!)
            lastTimeLabel.hidden = false
        }
        else
        {
            lastTimeLabel.hidden = true
        }
        
        var titleStr = ""
        var subTitleStr = ""
        let addressStr: String! = schedule?.address as String
        
        if (self.scheduleModel?.sourceType.isEqualToString("appointment_client") == true)
        {
            //  二手房预约  客源方
            
            if (self.scheduleModel?.appointmentState.isEqualToString("confirm_w") == true)
            {
                // 未确定预约
                titleStr = "等待对方确认 \(self.scheduleModel?.houseName as String)"
                
            }
            else if (self.scheduleModel?.appointmentState.isEqualToString("confirmed") == true)
            {
                // 对方同意
                
                titleStr = "对方同意 \(self.scheduleModel?.houseName as String)"
            }
            else if (self.scheduleModel?.appointmentState.isEqualToString("rejected") == true)
            {
                // 对方拒绝
                
                titleStr = "对方拒绝 \(self.scheduleModel?.houseName as String)"
            }
            
            subTitleStr = "\(self.scheduleModel?.clientName as String) \(self.scheduleModel?.clientPhone as String) 房源预约"
            
        }
        else if (self.scheduleModel?.sourceType.isEqualToString("appointment_house") == true)
        {
            //  二手房预约  房源方
            titleStr = "\(self.scheduleModel?.clientName as String) \(self.scheduleModel?.clientPhone as String)"
            subTitleStr = "\(self.scheduleModel?.houseName as String) 房源预约 \(self.scheduleModel?.content as String)"
        }
        else if (self.scheduleModel?.sourceType.isEqualToString("new") == true)
        {
            //  新建
            if (self.scheduleModel?.clientInfoId?.length == 0)
            {
                // 未关联客户或楼盘 正常显示日程内容
                // 未关联客户或楼盘 正常显示日程内容
                self.titleLabel.hidden = true
                self.subTitleLabel.hidden = false
                
                self.subTitleLabel.frame = CGRectMake(CGRectGetMinX(titleLabel.frame), CGRectGetMinY(titleLabel.frame), CGRectGetWidth(subTitleLabel.frame), 15)
                
                subTitleStr = schedule?.content as String
            }
            else
            {
                self.titleLabel.hidden = false
                self.subTitleLabel.hidden = false
                self.subTitleLabel.frame = CGRectMake(CGRectGetMinX(titleLabel.frame), CGRectGetMaxY(titleLabel.frame) + CGFloat(5), CGRectGetWidth(titleLabel.frame), 15)
                
                titleStr = "\(schedule?.clientName as String) \(schedule?.clientPhone as String)"
                subTitleStr = "\(self.scheduleModel?.houseName as String) \(schedule?.content as String)"
            }
            
            
        }
        
        if (finishDate != nil && lastDate != nil)
        {
            if (CalendarDateUtil.isEquleDate(finishDate, other: lastDate))
            {
                lastTimeLabel.hidden = true
            }
            else
            {
                lastTimeLabel.hidden = false
            }
        }
        else
        {
            lastTimeLabel.hidden = true
        }
        
        
        timeLabel.text = timeStr
        lastTimeLabel.text = lastTimeStr
        titleLabel.text = titleStr
        let size = Utility.calculateStringSize(subTitleStr, textFont: subTitleLabel.font, constrainedSize: CGSizeMake(kScreenWidth - marginLeft - 60, 1000))
        subTitleLabel.frame = CGRectMake(marginLeft, subTitleLabel.frame.origin.y, size.width, size.height)
        subTitleLabel.text = subTitleStr
        
        // 计算 字符位置
        
        let widthSize = Utility.calculateStringSize(subTitleStr, textFont: subTitleLabel.font, constrainedSize: CGSizeMake(10000, 10000))
        let numberLine = size.height / widthSize.height
        let width = widthSize.width - (numberLine - 1) * size.width
        
        if (width + 60 + marginLeft + iconImgV.frame.size.width + 10 < kScreenWidth)
        {
            iconImgV.frame = CGRectMake(marginLeft + width + 5, CGRectGetMinY(subTitleLabel.frame) + widthSize.height * (numberLine - 1) + 1, 21, 15)
        }
        else
        {
            iconImgV.frame = CGRectMake(marginLeft, CGRectGetMaxY(subTitleLabel.frame), 21, 15)
        }
        
        if (self.scheduleModel?.picKey?.length == 0)
        {
            self.iconImgV?.hidden = true
        }
        else
        {
            self.iconImgV?.hidden = false
        }
        
        if (self.scheduleModel?.address?.length == 0)
        {
            self.addressView.hidden = true
        }
        else
        {
            self.addressView.hidden = false
        }
        
        let height = HWScheduleListCell.getCellHeight(schedule)
        
        if (iconImgV.hidden)
        {
            addressView.frame = CGRectMake(
                addressView.frame.origin.x,
                CGRectGetMaxY(subTitleLabel.frame),
                addressView.frame.size.width,
                addressView.frame.size.height)
        }
        else
        {
            addressView.frame = CGRectMake(
                addressView.frame.origin.x,
                CGRectGetMaxY(iconImgV.frame),
                addressView.frame.size.width,
                addressView.frame.size.height)
        }
        
        addressLabel.text = addressStr
        
        telephoneButton.frame = CGRectMake(kScreenWidth - 60, (height - 50) / 2.0, 60, 50)
        
        if (self.scheduleModel?.clientPhone?.length == 0 && self.scheduleModel?.houseBrokerPhone.length == 0)
        {
            self.telephoneButton.hidden = true
        }
        else
        {
            self.telephoneButton.hidden = false
        }
        
        
        rightButtons.removeAllObjects()
        leftButtons.removeAllObjects()
        
        if (self.scheduleModel?.state?.isEqualToString("0") == true)
        {
            // 未完成
            leftButtons.sw_addUtilityButtonWithColor(CD_GreenColor, title: "完成")
            rightButtons.sw_addUtilityButtonWithColor(CD_Btn_GrayColor, title: "延迟")
            self.contentView.backgroundColor = UIColor.whiteColor()
        }
        else
        {
            // 已完成
            self.contentView.backgroundColor = CD_GrayColor
        }
        rightButtons.sw_addUtilityButtonWithColor(CD_RedLightColor, title: "删除")
        self.setRightUtilityButtons(rightButtons, withButtonWidth: 60.0)
        self.setLeftUtilityButtons(leftButtons, withButtonWidth: 60.0)
        
    }
    
    func toCallPhone(sender: UIButton) -> Void
    {
        MobClick.event("Call_click")//埋点
        if (listDelegate != nil && listDelegate?.respondsToSelector("listCell:didCallToPhone:") != false)
        {
            listDelegate?.listCell(self, didCallToPhone: self.scheduleModel!)
        }
        
    }
    
}
