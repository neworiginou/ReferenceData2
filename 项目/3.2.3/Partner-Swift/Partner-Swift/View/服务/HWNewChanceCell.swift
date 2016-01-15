//
//  HWNewChanceCell.swift
//  Partner-Swift
//
//  Created by hw500027 on 15/2/6.
//  Copyright (c) 2015年 luxiaobo. All rights reserved.
//
//  功能描述：机会详情列表自定义cell
//
//  修改记录：
//      姓名         日期              修改内容
//    陆晓波      2015-02-12           文件创建
//

import UIKit

protocol HWNewChanceCellDelegate:NSObjectProtocol
{
    func didReturnKeyBoard(textFieldStr:NSString?)
}

class HWNewChanceCell: HWBaseTableViewCell,UITextFieldDelegate {

    weak var newChanceCellDelegate:HWNewChanceCellDelegate?
    
    var _titleLabel:UILabel!
    var _detailLabel:UILabel!
    var _rightArrowImgV:UIImageView!
    
    var _textField:UITextField!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        _titleLabel = UILabel(forAutoLayout: ())
        _titleLabel.font = Define.font(TF_15)
        self.contentView.addSubview(_titleLabel)
        
        _detailLabel = UILabel(forAutoLayout: ())
        _detailLabel.textAlignment = NSTextAlignment.Right
        _detailLabel.font = Define.font(TF_15)
        _detailLabel.textColor = CD_Txt_Color_99
        self.contentView.addSubview(_detailLabel)
        
        _rightArrowImgV = UIImageView(forAutoLayout: ())
        _rightArrowImgV.image = UIImage(named: "arrow_next")
        self.contentView.addSubview(_rightArrowImgV)
        
        _rightArrowImgV.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Right, ofView: self.contentView, withOffset: -serviceCustomerCell_offset_15 * kRate)
        _rightArrowImgV.autoAlignAxis(ALAxis.Horizontal, toSameAxisOfView: self.contentView)
        
        _titleLabel.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: self.contentView, withOffset: serviceCustomerCell_offset_15 * kRate)
        _titleLabel.autoAlignAxis(ALAxis.Horizontal, toSameAxisOfView: self.contentView)
        
        _detailLabel.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Right, ofView: _rightArrowImgV, withOffset: -serviceCustomerCell_offset_15 * kRate)
        _detailLabel.autoAlignAxis(ALAxis.Horizontal, toSameAxisOfView: self.contentView)
        
        _textField = UITextField(forAutoLayout: ())
        _textField.textAlignment = NSTextAlignment.Right
        _textField.font = Define.font(TF_15)
        _textField.textColor = CD_Txt_Color_99
        _textField.delegate = self
        _textField.returnKeyType = UIReturnKeyType.Done
        self.contentView.addSubview(_textField)
        _textField.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: _titleLabel, withOffset: serviceCustomerCell_offset_15 * kRate)
        _textField.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Right, ofView: self.contentView, withOffset: -serviceCustomerCell_offset_15 * kRate)
        _textField.autoAlignAxis(ALAxis.Horizontal, toSameAxisOfView: self.contentView)
        _textField.hidden = true
    }
    
    func addLoan()
    {
        _rightArrowImgV.removeFromSuperview()
        _detailLabel.removeFromSuperview()
        _textField.hidden = false
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        
        newChanceCellDelegate?.didReturnKeyBoard(textField.text)
        _textField.resignFirstResponder()
         _textField.text = ""
      
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField)
    {
        _textField.text = ""
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
