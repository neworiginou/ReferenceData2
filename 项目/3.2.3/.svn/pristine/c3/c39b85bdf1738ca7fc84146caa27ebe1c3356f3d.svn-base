//
//  HWDynamicCell.swift
//  Partner-Swift
//
//  Created by hw500027 on 15/3/3.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：我的房店-状态列表cell
//
//  修改记录：
//      姓名         日期              修改内容
//    陆晓波      2015-03-03           文件创建
//    陆晓波      2015-03-03           添加待办状态 判断红点显示

import UIKit

protocol HWDynamicCellDelegate:NSObjectProtocol
{
    func didUnlockBtn(id:NSString,integral:NSString)
}

class HWDynamicCell: HWBaseTableViewCell
{
    weak var dynamicCellDelegate:HWDynamicCellDelegate?
    
    var _villageNameLabel:UILabel!
    var _doorNumLabel:UILabel!
    var _operationTypeLabel:UILabel!
    var _createTimeLabel:UILabel!
    var _appointmentTimeLabel:UILabel!
    var _brokerNameLabel:UILabel!
    var _isLock:UIButton!
    var _redPoint:UILabel!
    var _model:HWDynamicModel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //小区名称
        _villageNameLabel = UILabel(forAutoLayout: ())
        _villageNameLabel.font = Define.font(TF_15)
        self.contentView.addSubview(_villageNameLabel)
        
        _villageNameLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: self.contentView, withOffset: serviceCustomerCell_offset_10)
        _villageNameLabel.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: self.contentView, withOffset: serviceCustomerCell_offset_15)
        _villageNameLabel.autoSetDimension(ALDimension.Height, toSize: TF_15)
        
        //门牌
        _doorNumLabel = UILabel(forAutoLayout: ())
        _doorNumLabel.font = Define.font(TF_15)
        self.contentView.addSubview(_doorNumLabel)
        
        _doorNumLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: self.contentView, withOffset: serviceCustomerCell_offset_10)
        _doorNumLabel.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: _villageNameLabel, withOffset: 6)
        _doorNumLabel.autoSetDimension(ALDimension.Height, toSize: TF_15)
        
        //是否解锁
        _isLock = UIButton(forAutoLayout: ())
        self.contentView.addSubview(_isLock)
        
        //动态类型
        _operationTypeLabel = UILabel(forAutoLayout: ())
        _operationTypeLabel.font = Define.font(TF_13)
        _operationTypeLabel.textColor = CD_GreenColor
        self.contentView.addSubview(_operationTypeLabel)
        
        //动态产生时间
        _createTimeLabel = UILabel(forAutoLayout: ())
        _createTimeLabel.font = Define.font(TF_13)
        _createTimeLabel.textColor = CD_Txt_Color_99
        self.contentView.addSubview(_createTimeLabel)
        
        _createTimeLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: _villageNameLabel, withOffset: serviceCustomerCell_offset_10)
        _createTimeLabel.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: _villageNameLabel)
        
        //客源经纪人姓名
        _brokerNameLabel = UILabel(forAutoLayout: ())
        _brokerNameLabel.font = Define.font(TF_13)
        _brokerNameLabel.textColor = CD_Txt_Color_99
        self.contentView.addSubview(_brokerNameLabel)
        
        _brokerNameLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: _createTimeLabel)
        _brokerNameLabel.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: _createTimeLabel, withOffset: 6)
        
        //预约时间
        _appointmentTimeLabel = UILabel(forAutoLayout: ())
        _appointmentTimeLabel.font = Define.font(TF_13)
        _appointmentTimeLabel.textColor = CD_Txt_Color_99
        _appointmentTimeLabel.numberOfLines = 1
        _appointmentTimeLabel.lineBreakMode = NSLineBreakMode.ByTruncatingTail
        self.contentView.addSubview(_appointmentTimeLabel)
        
        _appointmentTimeLabel.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: _createTimeLabel)
        _appointmentTimeLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: _createTimeLabel, withOffset: serviceCustomerCell_offset_10)
        
        
        
        //未处理信息 红点
        _redPoint = UILabel(forAutoLayout: ())
        _redPoint.backgroundColor = CD_RedDeepColor
        _redPoint.layer.masksToBounds = true
        _redPoint.layer.cornerRadius = 4
        _redPoint.hidden = true
        self.contentView.addSubview(_redPoint)
        
        _redPoint.autoSetDimension(ALDimension.Height, toSize: 8)
        _redPoint.autoSetDimension(ALDimension.Width, toSize: 8)
        _redPoint.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: self.contentView, withOffset: serviceCustomerCell_offset_10)
        _redPoint.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: _doorNumLabel, withOffset: 3)
        
        _isLock.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Right, ofView: self.contentView, withOffset: -serviceCustomerCell_offset_15 * kRate)
        _isLock.autoAlignAxis(ALAxis.Horizontal, toSameAxisOfView: self.contentView)
        
        _operationTypeLabel.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Left, ofView: _isLock, withOffset: -serviceCustomerCell_offset_15)
        _operationTypeLabel.autoAlignAxis(ALAxis.Horizontal, toSameAxisOfView: self.contentView)
        
        var labelWidth :CGFloat = _isLock.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).width
        _appointmentTimeLabel.autoSetDimension(ALDimension.Width, toSize: kScreenWidth - labelWidth - serviceCustomerCell_offset_15 * 3)
        
    }

    func fillData(model:HWDynamicModel)
    {
        _model = model
        _villageNameLabel.text = model.villageName
        
        _doorNumLabel.text = model.doorNum
        _operationTypeLabel.text = "预约看房"
        
        var createTimeStr:NSString = ""
        if (model.createTime!.length != 0)
        {
            //createTimeStr = Utility.getTimeFormattWithTimeStamp(Utility.getTimestampWithTime(model.createTime!))
            createTimeStr = Utility.getTimeFormattWithTimeStamp(model.createTime!)
        }
        
        _createTimeLabel.text = "\(createTimeStr)  \(model.brokerName!)"

        if (model.appointmentTime!.length != 0)
        {
            //_appointmentTimeLabel.text = "\(Utility.getTimeFormattWithTimeStamp(Utility.getTimestampWithTime(model.appointmentTime!)))  \(model.message!)"//appointmentTime
            _appointmentTimeLabel.text = "\(Utility.getTimeFormattWithTimeStamp(model.appointmentTime!))  \(model.message!)"
//            var aa:NSString = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
//            _appointmentTimeLabel.text = "\(Utility.getTimeFormattWithTimeStamp(model.appointmentTime!))  \(aa)"
        }
        
        if (model.operationType != "appoint")
        {
            _brokerNameLabel.text = ""
            _operationTypeLabel.text = ""
            _isLock.hidden = true
            _appointmentTimeLabel.text = createTimeStr
            if (model.operationType == "edit")
            {
                _createTimeLabel.text = "房源信息编辑"
            }
            else if (model.operationType == "putdown")
            {
                _createTimeLabel.text = "房源下架"
            }
        }
        else
        {
            _isLock.hidden = false
        }
        
        if(model.isLock == "yes" && model.pendingState == "pending")
        {
            _isLock.setImage(UIImage(named: "phone_lock"), forState: UIControlState.Normal)
            _isLock.removeTarget(self, action: "toCall", forControlEvents: UIControlEvents.TouchUpInside)
            _isLock.addTarget(self, action: "toUnlock", forControlEvents: UIControlEvents.TouchUpInside)
        }
        else if (model.isLock == "yes" && model.pendingState == "pended")
        {
            _isLock.setImage(UIImage(named: "phone_lock2"), forState: UIControlState.Normal)
            _isLock.removeTarget(self, action: "toCall", forControlEvents: UIControlEvents.TouchUpInside)
            _isLock.removeTarget(self, action: "toUnlock", forControlEvents: UIControlEvents.TouchUpInside)
        }
        else
        {
            _isLock.setImage(UIImage(named: "phone2"), forState: UIControlState.Normal)
            _isLock.removeTarget(self, action: "toUnlock", forControlEvents: UIControlEvents.TouchUpInside)
            _isLock.addTarget(self, action: "toCall", forControlEvents: UIControlEvents.TouchUpInside)
        }
        
        //待办状态 判断红点显示
        if (model.isRead != "unread")
        {
            _redPoint.hidden = true
        }
        else
        {
            _redPoint.hidden = false
        }
    }
    
    func toCall()
    {
//        println("call\(_model.brokerPhone!)")
        Utility.callPhone(_model.brokerPhone!)
    }
    
    func toUnlock()
    {
        dynamicCellDelegate?.didUnlockBtn(_model.id!, integral: _model.integral!)
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
