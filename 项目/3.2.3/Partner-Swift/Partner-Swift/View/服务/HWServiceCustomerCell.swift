//
//  HWServiceCustomerCell.swift
//  Partner-Swift
//
//  Created by hw500027 on 15/2/12.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：服务首页-客户列表自定义cell
//
//  修改记录：
//      姓名         日期              修改内容
//    陆晓波      2015-02-12           文件创建
//    陆晓波      2015-02-28           模拟数据

import UIKit

let serviceCustomerCell_offset_5:CGFloat = 5.0
let serviceCustomerCell_offset_10:CGFloat = 10.0
let serviceCustomerCell_offset_15:CGFloat = 15.0
let serviceCustomerCell_offset_20:CGFloat = 20.0

class HWServiceCustomerCell: HWBaseTableViewCell {
   
    let kRate_cellFont: CGFloat = iPhone6plus ? 1 : 1
    var _nameLabel:UILabel!
    var _contentLabel:UILabel!
    var _dateLabel:UILabel!
    var _statusLab:UILabel!
    var _line:UIView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //客户姓名
        _nameLabel = UILabel(forAutoLayout: ())
        _nameLabel.font = Define.font(TF_15 * kRate_cellFont)
        self.contentView.addSubview(_nameLabel)
        
        _nameLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: self.contentView, withOffset: serviceCustomerCell_offset_10 * kRate)
        _nameLabel.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: self.contentView, withOffset: serviceCustomerCell_offset_15 * kRate)
        
        //内容
        _contentLabel = UILabel(forAutoLayout: ())
        _contentLabel.font = Define.font(TF_13 * kRate_cellFont)
        _contentLabel.textColor = CD_Txt_Color_99
        self.contentView.addSubview(_contentLabel)
        
        _contentLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: _nameLabel, withOffset: serviceCustomerCell_offset_5 * kRate)
        _contentLabel.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: _nameLabel)
        
        //时间
        _dateLabel = UILabel(forAutoLayout: ())
        _dateLabel.font = Define.font(TF_13 * kRate_cellFont)
        _dateLabel.textColor = CD_Txt_Color_99
        self.contentView.addSubview(_dateLabel)
        
        _dateLabel.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: _nameLabel)
        _dateLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: _contentLabel, withOffset: serviceCustomerCell_offset_5 * kRate)
        
        //意向状态
        _statusLab = UILabel(forAutoLayout: ())
        _statusLab.font = Define.font(TF_13 * kRate_cellFont)
        _statusLab.textAlignment = NSTextAlignment.Right
        self.contentView.addSubview(_statusLab)
        
        //_statusLab.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: self.contentView, withOffset: 30*kRate)
        _statusLab.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Right, ofView: self.contentView, withOffset: -serviceCustomerCell_offset_15 * kRate)
        _statusLab.autoAlignAxis(ALAxis.Horizontal, toSameAxisOfView: self.contentView)
        
        _line = UIView()
        _line.backgroundColor = CD_LineColor
        self.contentView .addSubview(_line)
    }
    
    //服务模块，客户列表填充数据
    func fillWithData(model:HWServiceCustomerModel)
    {
        _statusLab.text = model.chanceStatus
        if (model.chanceStatus == "wait")
        {
            _statusLab.text = "待处理"
            _statusLab.textColor = CD_GreenColor
        }
        else if (model.chanceStatus == "signed")
        {
            _statusLab.text = "已签单"
            _statusLab.textColor = CD_OrangeColor
        }
        else if (model.chanceStatus == "nointention")
        {
            _statusLab.text = "无意向"
            _statusLab.textColor = CD_Txt_Color_99
        }
        
        _nameLabel.text = model.name

        var chanceType:NSString = ""
        if (model.chanceType == "warrant")
        {
            chanceType = "权证"
        }
        else if (model.chanceType == "financial")
        {
            chanceType = "金融"
        }

        var productName:NSString = ""
        if (model.productName == nil)
        {
            productName = ""
        }
        else
        {
            productName = " | \(model.productName!)"
        }
        
        var loan:NSString = ""
        if (model.loan == nil)
        {
            loan = ""
        }
        else
        {
            loan = " | \(model.loan!)"
        }
        
        if (model.chanceType == "warrant")
        {
            _contentLabel.text = chanceType + productName
        }
        else if (model.chanceType == "financial")
        {
            _contentLabel.text = chanceType + productName + loan
        }

        _dateLabel.text = Utility.getTimeFormattWithTimeStamp(model.modifyTime!) //model.modifyTime
        _line.frame = CGRectMake(0, self.contentView.bounds.height - 0.5, kScreenWidth, 0.5)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
