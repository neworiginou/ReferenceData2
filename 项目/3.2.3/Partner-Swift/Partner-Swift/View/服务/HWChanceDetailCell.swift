//
//  HWChanceDetailCell.swift
//  Partner-Swift
//
//  Created by hw500027 on 15/2/11.
//  Copyright (c) 2015年 luxiaobo. All rights reserved.
//
//  功能描述：服务首页-机会详情列表自定义cell
//
//  修改记录：
//      姓名         日期              修改内容
//    陆晓波      2015-02-11           文件创建
//    陆晓波      2015-02-28           添加 修改状态文字颜色

import UIKit

class HWChanceDetailCell: HWBaseTableViewCell {

    var _titleLabel:UILabel!
    var _detailLabel:UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        _titleLabel = UILabel(forAutoLayout: ())
        _titleLabel.font = Define.font(TF_15)
        self.contentView.addSubview(_titleLabel)
        
        _detailLabel = UILabel(forAutoLayout: ())
        _detailLabel.font = Define.font(TF_15)
        _detailLabel.textAlignment = NSTextAlignment.Right
        _detailLabel.textColor = CD_Txt_Color_99
        self.contentView.addSubview(_detailLabel)
        
        _titleLabel.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: self.contentView, withOffset: serviceCustomerCell_offset_15 * kRate)
        _titleLabel.autoAlignAxis(ALAxis.Horizontal, toSameAxisOfView: self.contentView)
        
        _detailLabel.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Right, ofView: self.contentView, withOffset: -serviceCustomerCell_offset_15 * kRate)
        _detailLabel.autoAlignAxis(ALAxis.Horizontal, toSameAxisOfView: self.contentView)
        
    }
    
    func changeTextColor(model:HWServiceCustomerModel)
    {
        if (model.chanceStatus == "wait")
        {
            _detailLabel.text = "待处理"
            _detailLabel.textColor = CD_GreenColor
        }
        else if (model.chanceStatus == "signed")
        {
            _detailLabel.text = "已签单"
            _detailLabel.textColor = CD_OrangeColor
        }
        else if (model.chanceStatus == "nointention")
        {
            _detailLabel.text = "无意向"
            _detailLabel.textColor = CD_Txt_Color_99
        }
    }
    
    required init(coder aDecoder: NSCoder) {
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
