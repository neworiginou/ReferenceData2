//
//  HWDynamicDetailCell.swift
//  Partner-Swift
//
//  Created by hw500027 on 15/3/5.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

protocol HWDynamicDetailCellDelegate:NSObjectProtocol
{
    func didUnlockBtn()
}

class HWDynamicDetailCell: HWBaseTableViewCell
{

    weak var dynamicDetailCellDelegate:HWDynamicDetailCellDelegate?
    
    var _titleLabel:UILabel!
    var _phoneBtn:UIButton!
    var _phoneLabel:UILabel!
    var _nameLabel:UILabel!
    
    var _phoneNum:NSString!
    var _lockImgView:UIImageView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //联系经纪人
        _titleLabel = UILabel(forAutoLayout: ())
        _titleLabel.font = Define.font(TF_15)
        _titleLabel.text = "联系经纪人"
        self.contentView.addSubview(_titleLabel)
        
        //电话图标
        _phoneBtn = UIButton(forAutoLayout: ())
        self.contentView.addSubview(_phoneBtn)
        
        //电话
        _phoneLabel = UILabel(forAutoLayout: ())
        _phoneLabel.font = Define.font(TF_15)
        _phoneLabel.textColor = CD_Txt_Color_99
        self.contentView.addSubview(_phoneLabel)
        
        //姓名
        _nameLabel = UILabel(forAutoLayout: ())
        _nameLabel.font = Define.font(TF_15)
        _nameLabel.textColor = CD_Txt_Color_99
        self.contentView.addSubview(_nameLabel)
        
        _titleLabel.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: self.contentView, withOffset: serviceCustomerCell_offset_15 * kRate)
        _titleLabel.autoAlignAxis(ALAxis.Horizontal, toSameAxisOfView: self.contentView)
        
        _phoneBtn.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Right, ofView: self.contentView, withOffset: -serviceCustomerCell_offset_15 * kRate)
        _phoneBtn.autoAlignAxis(ALAxis.Horizontal, toSameAxisOfView: self.contentView)
        
        _phoneLabel.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Left, ofView: _phoneBtn, withOffset: -serviceCustomerCell_offset_10 * kRate)
        _phoneLabel.autoAlignAxis(ALAxis.Horizontal, toSameAxisOfView: self.contentView)
        
        _nameLabel.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Left, ofView: _phoneLabel, withOffset: -serviceCustomerCell_offset_10 * kRate)
        _nameLabel.autoAlignAxis(ALAxis.Horizontal, toSameAxisOfView: self.contentView)
    }
    
    //已解锁，拨打电话
    func phoneBtnFillNumber(num:NSString!)
    {
        if (_lockImgView != nil)
        {
            _lockImgView.removeFromSuperview()
        }
        _phoneNum = num
        _phoneBtn.setImage(UIImage(named: "phone2"), forState: UIControlState.Normal)
        _phoneBtn.removeTarget(self, action: "toUnlock", forControlEvents: UIControlEvents.TouchUpInside)
        _phoneBtn.addTarget(self, action: "callPhone", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    //未解锁
    func phoneBtnToUnlock()
    {
//        _lockImgView = UIImageView(forAutoLayout: ())
//        self.contentView.addSubview(_lockImgView)
//        _lockImgView.image = UIImage(named: "lock2")
//        
//        _lockImgView.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Right, ofView: self.contentView, withOffset: -10)
//        _lockImgView.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: self.contentView, withOffset: 5)
        
        _phoneBtn.removeTarget(self, action: "callPhone", forControlEvents: UIControlEvents.TouchUpInside)
        _phoneBtn.setImage(UIImage(named: "phone_lock"), forState: UIControlState.Normal)
        _phoneBtn.addTarget(self, action: "toUnlock", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func phoneCantToUnlock()
    {
        _phoneBtn.removeTarget(self, action: "callPhone", forControlEvents: UIControlEvents.TouchUpInside)
        _phoneBtn.removeTarget(self, action: "toUnlock", forControlEvents: UIControlEvents.TouchUpInside)
        _phoneBtn.setImage(UIImage(named: "phone_lock2"), forState: UIControlState.Disabled)
    }
    
    func toUnlock()
    {
        dynamicDetailCellDelegate?.didUnlockBtn()
    }
    
    func callPhone()
    {
//        println("call\(_phoneNum)")
        Utility.callPhone(_phoneNum)
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
