//
//  HWScdHouMakeAppointCell.swift
//  Partner-Swift
//
//  Created by niedi on 15/3/10.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：二手房预约看房下方预约历史Cell
//
//  修改记录：
//      姓名         日期               修改内容
//      聂迪      2015-02-26           UI及数据功能实现
//

import UIKit

protocol HWScdHouMakeAppointCellDelegate: NSObjectProtocol
{
    func callPhone(phoneNum: String, index: Int)
}

class HWScdHouMakeAppointCell: HWBaseTableViewCell
{
    var timeLab: UILabel!
    var stateLab: UILabel!
    var customNameLab: UILabel!
    var leaveMessageLab: UILabel!
    var phoneBtn: UIButton!
    
    var _index: Int!
    var _phoneNum: String! = "1"
    weak var delegate: HWScdHouMakeAppointCellDelegate!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        timeLab = UILabel(frame: CGRectMake(15, 8, kScreenWidth - 2 * 15, 20))
        timeLab.font = Define.font(TF_14)
        timeLab.textColor = CD_Txt_Color_99
        self.contentView.addSubview(timeLab)
        
        stateLab = UILabel(frame: CGRectMake(15, timeLab.frame.minY, kScreenWidth - 2 * 15, 20))
        stateLab.font = Define.font(TF_14)
        stateLab.textAlignment = NSTextAlignment.Right
        self.contentView.addSubview(stateLab)
        
        self.contentView.addSubview(Utility.drawLine(CGPointMake(15, timeLab.frame.maxY + 7), width: kScreenWidth - 15))
        
        customNameLab = UILabel(frame: CGRectMake(15, timeLab.frame.maxY + 14, kScreenWidth - 2 * 15, 20))
        customNameLab.font = Define.font(TF_15)
        customNameLab.textColor = CD_Txt_Color_00
        self.contentView.addSubview(customNameLab)
        
        leaveMessageLab = UILabel(frame: CGRectMake(15, customNameLab.frame.maxY + 4, kScreenWidth - 15 * 2 - 30 - 5, 20))
        leaveMessageLab.font = Define.font(TF_14)
        leaveMessageLab.textColor = CD_Txt_Color_00
        leaveMessageLab.numberOfLines = 0
        self.contentView.addSubview(leaveMessageLab)
        
        phoneBtn = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        phoneBtn.frame = CGRectMake(kScreenWidth - 15 - 30, customNameLab.frame.minY + 3, 30, 30)
        phoneBtn.setImage(UIImage(named: "phone2"), forState: UIControlState.Normal)
        phoneBtn.addTarget(self, action: "phoneBtnClick", forControlEvents: UIControlEvents.TouchUpInside)
        self.contentView.addSubview(phoneBtn)
    }
    
    
    
    func setCellContent(model: HWScdHouMakeAppointModel, index: Int)
    {
//        timeLab.text = Utility.getTimeWithTimestamp(model.appointmentTime, dateFormatStr: "yyyy-MM-dd HH:mm:ss")
        timeLab.text = Utility.getTimeFormattWithTimeStamp(model.appointmentTime)
        if(model.appointmentState == "confirm_w")
        {
            stateLab.text = "等待对方确认"
            stateLab.textColor = CD_GreenColor
        }
        else if(model.appointmentState == "rejected")
        {
            stateLab.text = "对方拒绝"
            stateLab.textColor = CD_RedLightColor
        }
        else
        {
            stateLab.text = "对方同意"
            stateLab.textColor = CD_OrangeColor
        }
        
        customNameLab.text = model.clientName
        
        _index = index
        _phoneNum = model.clientPhone
        
        var frame = leaveMessageLab.frame
        frame.size.height = Utility.calculateStringSize(model.message, textFont: Define.font(TF_14), constrainedSize: CGSizeMake(kScreenWidth - 15 - 30 - 5, 10000)).height
        leaveMessageLab.frame = frame
        leaveMessageLab.text = model.message
        
        var centerpoint = phoneBtn.center
        centerpoint.y = (HWScdHouMakeAppointCell.getCellHeight(model) - 35) / 2.0 + 35
        phoneBtn.center = centerpoint
        
        self.addSubview(Utility.drawLine(CGPointMake(0, HWScdHouMakeAppointCell.getCellHeight(model) - 0.5), width: kScreenWidth))
        
    }
    
    class func getCellHeight(model: HWScdHouMakeAppointModel) -> CGFloat
    {
        return 80 + Utility.calculateStringSize(model.message, textFont: Define.font(TF_14), constrainedSize: CGSizeMake(kScreenWidth - 15 - 30 - 5, 10000)).height
    }
    
    //MARK: 打电话
    @objc private func phoneBtnClick()
    {
        delegate.callPhone(_phoneNum, index: _index)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
