//
//  HWScheduleCalendarCell.swift
//  Partner-Swift
//
//  Created by caijingpeng.haowu on 15/2/21.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

// 2015年-3-24     杨庆龙         修改 (//  二手房预约  房源方 的name和phone)为clientName和clientPhone


import UIKit

protocol HWScheduleCalendarCellDelegate : NSObjectProtocol
{
    func calendarCell(cell: HWScheduleCalendarCell, didCallToPhone schedule: HWScheduleModel)
}

class HWScheduleCalendarCell: SWTableViewCell {
   
    var redPointView: UIView!
    var timeLabel: UILabel!
    var titleLabel: UILabel!
    var subTitleLabel: UILabel!
    var addressView: UIView!
    var addressLabel: UILabel!
    var imgView: UIImageView!
    var telephoneButton: UIButton!
    var lastTimeLabel: UILabel!
    var scheduleDelegate: HWScheduleCalendarCellDelegate?
    var scheduleModel: HWScheduleModel?
    
    let rightButtons = NSMutableArray()
    let leftButtons = NSMutableArray()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
                
        redPointView = UIView(frame: CGRectMake(15, 16.5, 8, 8))
        redPointView.backgroundColor = UIColor.redColor()
        redPointView.layer.cornerRadius = 4.0
        redPointView.layer.masksToBounds = true
        super.contentView.addSubview(redPointView)
        
        timeLabel = UILabel(frame: CGRectMake(CGRectGetMaxX(redPointView.frame) + CGFloat(5), 13, 40, 15))
        timeLabel.backgroundColor = UIColor.clearColor()
        timeLabel.font = Define.font(TF_14)
        timeLabel.textColor = CD_Txt_Color_66
        self.contentView.addSubview(timeLabel)
        
        lastTimeLabel = UILabel(frame: CGRectMake(CGRectGetMinX(timeLabel.frame), CGRectGetMaxY(timeLabel.frame) + 5, 35, 15))
        lastTimeLabel.backgroundColor = UIColor.clearColor()
        lastTimeLabel.font = Define.font(TF_14)
        lastTimeLabel.textColor = CD_Txt_Color_99
        //        lastTimeLabel.textAlignment = NSTextAlignment.Center
        lastTimeLabel.adjustsFontSizeToFitWidth = true
        self.contentView.addSubview(lastTimeLabel)
        
        lastTimeLabel.addSubview(Utility.drawLine(CGPointMake(0, 7.5), width: 35))
        
        titleLabel = UILabel(frame: CGRectMake(CGRectGetMaxX(timeLabel.frame) + 7, CGRectGetMinY(timeLabel.frame), kScreenWidth - 75 - 60, 15))
        titleLabel.backgroundColor = UIColor.clearColor()
        titleLabel.font = Define.font(TF_Text_15)
        titleLabel.textColor = CD_Txt_Color_00
        self.contentView.addSubview(titleLabel)
        
        subTitleLabel = UILabel(frame: CGRectMake(CGRectGetMinX(titleLabel.frame), CGRectGetMaxY(titleLabel.frame) + CGFloat(5), CGRectGetWidth(titleLabel.frame), 15))
        subTitleLabel.backgroundColor = UIColor.clearColor()
        subTitleLabel.font = Define.font(TF_Text_15 - 1)
        subTitleLabel.textColor = CD_Txt_Color_00
        subTitleLabel.numberOfLines = 0
        subTitleLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        self.contentView.addSubview(subTitleLabel)
        
        addressView = UIView(frame: CGRectMake(CGRectGetMinX(titleLabel.frame), 0, kScreenWidth - CGRectGetMinX(titleLabel.frame) - 15, 30))
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
        
        imgView = UIImageView(frame: CGRectMake(CGRectGetMinX(titleLabel.frame), 0, 45, 45))
        imgView.backgroundColor = UIColor.cyanColor()
        self.contentView.addSubview(imgView)
        
        telephoneButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        telephoneButton.frame = CGRectMake(kScreenWidth - 60, 0, 60, 45)
        telephoneButton.setImage(UIImage(named: "phone2"), forState: UIControlState.Normal)
        telephoneButton.addTarget(self, action: "toCallPhone:", forControlEvents: UIControlEvents.TouchUpInside)
        self.contentView.addSubview(telephoneButton)
        
//        var deleteBtn = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
//        deleteBtn.setTitle("删除", forState: UIControlState.Normal)
//        self.rightUtilityButtons = NSArray(objects: deleteBtn)
        
    }

    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func getIdentify() -> String
    {
        return "HWScheduleCalendarCell"
    }
    
    class func getCellHeight(schedule: HWScheduleModel?) -> CGFloat
    {
        
//        let subTitleStr = "撒地方萨芬撒地方阿斯达发送发送发送飞撒地方实地撒地方是撒地方是发生地方随碟附送大放送冯绍峰的撒地方撒地方晒单飞"
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
        
        
        let size = Utility.calculateStringSize(subTitleStr, textFont: Define.font(TF_Text_15 - 1), constrainedSize: CGSizeMake(kScreenWidth - 75 - 60, 1000))
        
        if (schedule?.clientInfoId?.length == 0)
        {
            // 未关联客户或楼盘 正常显示日程内容
            var height: CGFloat = size.height + 7 * 2
            
            if (schedule?.address?.length != 0)
            {
                height += 30
            }
            if (schedule?.picKey?.length != 0)
            {
                height += 45
                
                if schedule?.address?.length == 0
                {
                    height += 10
                }
            }
            
            return max(60, height)
        }
        
        var height = size.height
        
        if (schedule?.address?.length != 0)
        {
            height += 30
        }
        if (schedule?.picKey?.length != 0)
        {
            height += 45
            
            if schedule?.address?.length == 0
            {
                height += 5
            }
        }
        
        height += 7 * 2 + 15 + 13
        return max(60, height)
    }
    
    func setScheduleModel(schedule: HWScheduleModel?) -> Void
    {
        let timeStr = Utility.getTimeWithTimestamp(schedule?.finishTime as String, dateFormatStr: "HH:mm")
        
        if (schedule?.lastFinishTime.length == 0)
        {
            lastTimeLabel.hidden = true
        }
        else
        {
            lastTimeLabel.hidden = false
        }
        
        let lastTimeStr = Utility.getTimeWithTimestamp(schedule?.lastFinishTime as String, dateFormatStr: "dd日")
        
        var titleStr = ""
        var subTitleStr = ""
        let addressStr = schedule?.address
        
        self.scheduleModel = schedule
        
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
                self.titleLabel.hidden = true
                self.subTitleLabel.hidden = false
                self.addressView.hidden = true
                self.imgView.hidden = true
                
                self.subTitleLabel.frame = CGRectMake(CGRectGetMinX(titleLabel.frame), CGRectGetMinY(titleLabel.frame), CGRectGetWidth(titleLabel.frame), 15)
                
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
        
        timeLabel.text = timeStr
        
        var finishDate: NSDate? = Utility.convertDateFromString(Utility.getTimeWithTimestamp(schedule?.finishTime as String, dateFormatStr: "yyyy-MM-dd"), formate: "yyyy-MM-dd")
        var lastDate: NSDate? = Utility.convertDateFromString(Utility.getTimeWithTimestamp(schedule?.lastFinishTime as String, dateFormatStr: "yyyy-MM-dd"), formate: "yyyy-MM-dd")
        
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
        
        lastTimeLabel.text = lastTimeStr
        titleLabel.text = titleStr
        addressLabel.text = addressStr
        
        let size = Utility.calculateStringSize(subTitleStr, textFont: subTitleLabel.font, constrainedSize: CGSizeMake(subTitleLabel.frame.size.width, 1000))
        subTitleLabel.frame = CGRectMake(
            subTitleLabel.frame.origin.x,
            subTitleLabel.frame.origin.y,
            subTitleLabel.frame.size.width,
            size.height)
        
        let rangeArr: NSMutableArray = NSMutableArray()
        let templates = NSArray(objects: "面谈", "看房", "下定", "签合同", "打电话")
        var attStr : NSMutableAttributedString = NSMutableAttributedString(string: subTitleStr)
        
        for (var i = 0; i < templates.count; i++)
        {
            let string: NSString = templates.objectAtIndex(i) as NSString
            let temp: NSRange = (subTitleStr as NSString).rangeOfString(string)
            attStr.addAttribute(NSFontAttributeName, value: UIFont.boldSystemFontOfSize(TF_Text_15 - 1), range: temp)
        }
        
        
        
        subTitleLabel.attributedText = attStr
        
        addressView.frame = CGRectMake(
            addressView.frame.origin.x,
            CGRectGetMaxY(subTitleLabel.frame),
            addressView.frame.size.width,
            addressView.frame.size.height)
        
        var imgViewOriginY: CGFloat;
        if (self.scheduleModel?.address?.length == 0)
        {
            self.addressView.hidden = true
            imgViewOriginY = CGRectGetMaxY(subTitleLabel.frame) + 5
        }
        else
        {
            self.addressView.hidden = false
            imgViewOriginY = CGRectGetMaxY(addressView.frame)
        }
        
        if (self.scheduleModel?.picKey?.length == 0)
        {
            self.imgView.hidden = true
        }
        else
        {
            self.imgView.hidden = false
            let imgArr: NSArray? = self.scheduleModel?.picKey.componentsSeparatedByString(",")
            let mongoKey = imgArr?.objectAtIndex(0) as String
            
            weak var weakImgV: UIImageView? = self.imgView
            
            //MYP add 图片直接用url加载
            self.imgView?.setImageWithURL(NSURL(string: mongoKey), placeholderImage: Utility.getPlaceHolderImage(imgView.frame.size, imageName: "pic_wait_small"), completed: { (image, error, imageCacheType) -> Void in
                
                if (error != nil)
                {
                    let size: CGSize! = weakImgV?.frame.size
                    weakImgV?.image = Utility.getPlaceHolderImage(size, imageName: "pic_wait_small_no-")
                }
                else
                {
                    weakImgV?.image = image
                }
                
            })
        }
        
        imgView.frame = CGRectMake(
            imgView.frame.origin.x,
            imgViewOriginY,
            imgView.frame.size.width,
            imgView.frame.size.height)
        
        
        
        
        
        
        if (self.scheduleModel?.state?.isEqualToString("0") == true)
        {
            // 未完成
            self.contentView.backgroundColor = UIColor.whiteColor()
//            self.userInteractionEnabled = true
            self.redPointView.backgroundColor = UIColor.redColor()
        }
        else
        {
            // 已完成
            self.contentView.backgroundColor = CD_GrayColor
//            self.userInteractionEnabled = false
            self.redPointView.backgroundColor = CD_Btn_GrayColor
        }
    
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
            rightButtons.sw_addUtilityButtonWithColor(CD_Btn_GrayColor, title: "延迟")
            leftButtons.sw_addUtilityButtonWithColor(CD_GreenColor, title: "完成")
        }
        else
        {
            // 已完成
        }
        rightButtons.sw_addUtilityButtonWithColor(CD_RedLightColor, title: "删除")
        self.setRightUtilityButtons(rightButtons, withButtonWidth: 60.0)
        self.setLeftUtilityButtons(leftButtons, withButtonWidth: 60.0)
    }
    
    func toCallPhone(sender: UIButton) -> Void
    {
        if (scheduleDelegate != nil && scheduleDelegate?.respondsToSelector("calendarCell:didCallToPhone:") != false)
        {
            scheduleDelegate?.calendarCell(self, didCallToPhone: self.scheduleModel!)
        }
    }
    
}
