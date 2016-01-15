//
//  HWSubmitSuccessCell.swift
//  Partner-Swift
//
//  Created by hw500027 on 15/2/16.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：提交成功列表自定义cell
//
//  修改记录：
//      姓名         日期              修改内容
//    陆晓波      2015-02-16           文件创建
//

import UIKit

class HWSubmitSuccessCell: HWBaseTableViewCell {

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
        _detailLabel.textColor = CD_Txt_Color_99
        self.contentView.addSubview(_detailLabel)
        
        _titleLabel.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: self.contentView, withOffset: serviceCustomerCell_offset_15 * kRate)
        _titleLabel.autoAlignAxis(ALAxis.Horizontal, toSameAxisOfView: self.contentView)
        
        _detailLabel.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Right, ofView: self.contentView, withOffset: -serviceCustomerCell_offset_15 * kRate)
        _detailLabel.autoAlignAxis(ALAxis.Horizontal, toSameAxisOfView: self.contentView)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
