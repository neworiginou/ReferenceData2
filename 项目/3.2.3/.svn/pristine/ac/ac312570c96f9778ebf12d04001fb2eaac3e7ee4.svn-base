//
//  HWScdHouAppointListCell.swift
//  Partner-Swift
//
//  Created by niedi on 15/3/10.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：二手房房源方 预约人次列表 Cell
//
//  修改记录：
//      姓名         日期               修改内容
//      聂迪      2015-02-26           UI及数据实现
//

import UIKit

protocol scdHouAppointListCellDelegate: NSObjectProtocol
{
    func unLockClick(model: HWScdHouAppointListModel)
}

class HWScdHouAppointListCell: HWBaseTableViewCell, UIAlertViewDelegate
{
    var customNameLab: UILabel!
    var leaveMessageLab: UILabel!
    var timeLab: UILabel!
    var phoneBtn: UIButton!
    var lineView: UIImageView!
    
    var _model: HWScdHouAppointListModel!
    var _isPutDown: Bool! = false
    var delegate: scdHouAppointListCellDelegate!
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        customNameLab = UILabel(frame: CGRectMake(15, 8, kScreenWidth - 15 - 45, 20))
        customNameLab.font = Define.font(TF_15)
        customNameLab.textColor = CD_Txt_Color_00
        self.contentView.addSubview(customNameLab)
        
        leaveMessageLab = UILabel(frame: CGRectMake(15, customNameLab.frame.maxY + 5, kScreenWidth - 15 - 55, 20))
        leaveMessageLab.font = Define.font(TF_14)
        leaveMessageLab.textColor = CD_Txt_Color_00
        leaveMessageLab.numberOfLines = 0
        self.contentView.addSubview(leaveMessageLab)
        
        timeLab = UILabel(frame: CGRectMake(15, leaveMessageLab.frame.maxY + 1, kScreenWidth - 2 * 15, 20))
        timeLab.font = Define.font(TF_14)
        timeLab.textColor = CD_Txt_Color_99
        self.contentView.addSubview(timeLab)
        
        phoneBtn = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        phoneBtn.frame = CGRectMake(kScreenWidth - 15 - 35, leaveMessageLab.frame.minY + 3, 35, 35)
        phoneBtn.addTarget(self, action: "phoneBtnClick", forControlEvents: UIControlEvents.TouchUpInside)
        self.contentView.addSubview(phoneBtn)
        
        lineView = Utility.drawLine(CGPointMake(0, 65), width: kScreenWidth)
        self.contentView.addSubview(lineView)
    }
    
    //MARK: 数据实现
    func setContent(model: HWScdHouAppointListModel, isPutDown: Bool)
    {
        _model = model
        _isPutDown = isPutDown
        
        var center = phoneBtn.center
        center.y = (65 + Utility.calculateStringSize(model.appointmentContent, textFont: Define.font(TF_14), constrainedSize: CGSizeMake(kScreenWidth - 15 - 55, 10000)).height) / 2
        phoneBtn.center = center
        
        if(model.isLock == "yes")
        {
            if(isPutDown == true || model.pendingState == "pended")
            {
                phoneBtn.setImage(UIImage(named: "phone_lock2"), forState: UIControlState.Normal)
            }
            else
            {
                phoneBtn.setImage(UIImage(named: "phone_lock"), forState: UIControlState.Normal)
            }
            
        }
        else
        {
            phoneBtn.setImage(UIImage(named: "phone2"), forState: UIControlState.Normal)
        }
        
        customNameLab.text = model.brokerName
        
        var frame = leaveMessageLab.frame
        frame.size.height = Utility.calculateStringSize(model.appointmentContent, textFont: Define.font(TF_14), constrainedSize: CGSizeMake(kScreenWidth - 15 - 55, 10000)).height
        leaveMessageLab.frame = frame
        leaveMessageLab.text = model.appointmentContent
        
        frame = timeLab.frame
        frame.origin.y = CGRectGetMaxY(leaveMessageLab.frame) + 5
        timeLab.frame = frame
//        timeLab.text = Utility.getTimeWithTimestamp(model.createTime, dateFormatStr: "yyyy-MM-dd HH:mm:ss")
        timeLab.text = Utility.getTimeFormattWithTimeStamp(model.createTime)
        
        frame = lineView.frame
        frame.origin.y = 65 + Utility.calculateStringSize(model.appointmentContent, textFont: Define.font(TF_14), constrainedSize: CGSizeMake(kScreenWidth - 15 - 55, 10000)).height - 0.5
        lineView.frame = frame
    }
    
    //MARK: get 高度
    class func getCellHeight(model: HWScdHouAppointListModel) -> CGFloat
    {
        return 65 + Utility.calculateStringSize(model.appointmentContent, textFont: Define.font(TF_14), constrainedSize: CGSizeMake(kScreenWidth - 15 - 55, 10000)).height
    }
    
    //MARK: 解锁/打电话
    func phoneBtnClick()
    {
        if(_model.isLock == "yes")
        {
            if(_isPutDown == true || _model.pendingState == "pended")
            {
                return
            }
            else
            {
                delegate.unLockClick(_model)
            }
        }
        else
        {
            self.callAPhone()
        }
    }
    
    //MARK: 打电话
    func callAPhone()
    {
        var callWebView = UIWebView()
        self.addSubview(callWebView)
        
        if(_model.brokerPhone == "")
        {
            Utility.showToastWithMessage("手机号未空", _view: self)
        }
        else
        {
            var telUrl = NSURL(string: "tel:\(_model.brokerPhone)")
            callWebView.loadRequest(NSURLRequest(URL: telUrl!))
        }
    }
    
    
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
