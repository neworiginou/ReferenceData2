//
//  HWScheduleDetailCell.swift
//  Partner-Swift
//
//  Created by caijingpeng.haowu on 15/2/23.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//  2015-03-24     杨庆龙        拨打电话按钮注释掉代理

import UIKit

protocol HWScheduleDetailCellDelegate: NSObjectProtocol
{
    func scheduleDetailCell(cell: HWScheduleDetailCell, didCallToPhone phoneNumber: String)
}

class HWScheduleDetailCell: HWBaseTableViewCell {
   
    var nameLabel: UILabel!
    var typeLabel: UILabel!
    var telephoneLabel: UILabel!
    var telephoneButton: UIButton!
    
    var schduleModel: HWScheduleModel?
    var delegate: HWScheduleDetailCellDelegate?
    var type: NSString?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        nameLabel = UILabel(frame: CGRectZero)
        nameLabel.font = Define.font(TF_Text_15)
        nameLabel.textColor = CD_Txt_Color_00
        self.contentView.addSubview(nameLabel)
        
        typeLabel = UILabel(frame: CGRectZero)
        typeLabel.backgroundColor = "#c2c2c2".UIColor
        typeLabel.font = Define.font(TF_Small_12)
        typeLabel.textColor = UIColor.whiteColor()
        typeLabel.textAlignment = NSTextAlignment.Center
        typeLabel.layer.cornerRadius = 5.0
        typeLabel.layer.masksToBounds = true
        self.contentView.addSubview(typeLabel)
        
        telephoneLabel = UILabel(frame: CGRectZero)
        telephoneLabel.backgroundColor = UIColor.clearColor()
        telephoneLabel.font = Define.font(TF_Text_15)
        telephoneLabel.textColor = CD_Txt_Color_00
        self.contentView.addSubview(telephoneLabel)
        
        telephoneButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        telephoneButton.frame = CGRectMake(kScreenWidth - 60, 0, 60, 44)
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
        return "HWScheduleDetailCell"
    }
    
    class func getCellHeight() -> CGFloat
    {
        return 44
    }
    
    func setScheduleClientInfo(schedule: HWScheduleModel?) -> Void
    {
        self.schduleModel = schedule
        self.type = "0"
        
//        let nameStr = "撒地sdfasdfsdfsd撒地方萨芬f方"
//        let typeStr: NSString = "0"
//        let telephoneStr = "18512312212"
        
        let nameStr = schedule?.clientName
        let typeStr: NSString = "0"
        var telephoneStr: NSString? = schedule?.clientPhone
        
        let size = Utility.calculateStringSize(nameStr!, textFont: nameLabel.font, constrainedSize: CGSizeMake(1000, 20))
        nameLabel.frame = CGRectMake(15, 0, min(size.width, kScreenWidth - 115 - 60 - 15 - 15 - 55), HWScheduleDetailCell.getCellHeight())
        nameLabel.text = nameStr
        
        if (typeStr.isEqualToString("0") == true)
        {
            typeLabel.frame = CGRectMake(CGRectGetMaxX(nameLabel.frame) + 7, (HWScheduleDetailCell.getCellHeight() - 18) / 2.0, 35.0, 18)
            typeLabel.text = "客户"
        }
        else
        {
            typeLabel.frame = CGRectMake(CGRectGetMaxX(nameLabel.frame) + 7, (HWScheduleDetailCell.getCellHeight() - 18) / 2.0, 45.0, 18)
            typeLabel.text = "经纪人"
        }
        
        telephoneLabel.frame = CGRectMake(CGRectGetMaxX(typeLabel.frame) + 15, 0, 115, HWScheduleDetailCell.getCellHeight())
        telephoneLabel.text = telephoneStr
        
        if telephoneStr?.length == 0
        {
            telephoneButton.hidden = true
        }
        else
        {
            telephoneButton.hidden = false
        }
        
    }
    
    func setScheduleHouseInfo(schedule: HWScheduleModel?) -> Void
    {
        self.schduleModel = schedule
        self.type = "1"
        
//        let nameStr = "撒地sdfasdfsdfsd撒地方萨芬f方"
//        let typeStr: NSString = "1"
//        let telephoneStr = "18512312212"
        
        let nameStr = schedule?.houseBrokerName
        let typeStr: NSString = "1"
        var telephoneStr: NSString? = schedule?.houseBrokerPhone
        
        let size = Utility.calculateStringSize(nameStr!, textFont: nameLabel.font, constrainedSize: CGSizeMake(1000, 20))
        nameLabel.frame = CGRectMake(15, 0, min(size.width, kScreenWidth - 115 - 60 - 15 - 15 - 55), HWScheduleDetailCell.getCellHeight())
        nameLabel.text = nameStr
        
        if (typeStr.isEqualToString("0") == true)
        {
            typeLabel.frame = CGRectMake(CGRectGetMaxX(nameLabel.frame) + 7, (HWScheduleDetailCell.getCellHeight() - 18) / 2.0, 35.0, 18)
            typeLabel.text = "客户"
        }
        else
        {
            typeLabel.frame = CGRectMake(CGRectGetMaxX(nameLabel.frame) + 7, (HWScheduleDetailCell.getCellHeight() - 18) / 2.0, 45.0, 18)
            typeLabel.text = "经纪人"
        }
        
        telephoneLabel.frame = CGRectMake(CGRectGetMaxX(typeLabel.frame) + 15, 0, 115, HWScheduleDetailCell.getCellHeight())
        telephoneLabel.text = telephoneStr
        
        if telephoneStr?.length == 0
        {
            telephoneButton.hidden = true
        }
        else
        {
            telephoneButton.hidden = false
        }
    }
    
    func toCallPhone(sender: UIButton) -> Void
    {
        Utility.callPhone(telephoneLabel.text!)
//        if (delegate != nil && delegate?.respondsToSelector("scheduleDetailCell:didCallToPhone:") != false)
//        {
//            if (self.type?.isEqualToString("0") == true)
//            {
//                delegate?.scheduleDetailCell(self, didCallToPhone: self.schduleModel?.clientPhone as String)
//            }
//            else if (self.type?.isEqualToString("1") == true)
//            {
//                delegate?.scheduleDetailCell(self, didCallToPhone: self.schduleModel?.houseBrokerPhone as String)
//            }
//            
//            
//        }
    }
    
    
}
